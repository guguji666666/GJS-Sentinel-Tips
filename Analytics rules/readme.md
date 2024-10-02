# Deploy Analytics rule in Microsoft Sentinel

## Methods to deploy ayalytics rules
#### 1. [Deploy Analytics rule in the portal](https://learn.microsoft.com/en-us/azure/sentinel/import-export-analytics-rules)
#### 2. Deploy Analytics rule using powershell and ARM template

First, we need to [Export existing Analytics rule to ARM template](https://learn.microsoft.com/en-us/azure/sentinel/import-export-analytics-rules#export-rules)

Next, we need to [Using powershell command to import ARM template to specified scope](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-powershell#deployment-scope)

Please refer to the [Demo](https://github.com/guguji666666/GJS-Sentinel-Tips/blob/main/Repository%20integration/Export%20contents%20to%20ARM%20templates/Export%20analytics%20rules.md#optional-use-powershell-to-import-arm-template)

#### 3. Deploy Analytics rule using [API](https://learn.microsoft.com/en-us/rest/api/securityinsights/stable/alert-rules)

## Useful Analytics rules

#### 1. Generate alerts when the times of same password from same IP exceeds thereshold

Due to ingestion delay we can only use scheduled analytics rule
```kusto
let ingestion_delay = 3min;
let rule_look_back = 5min;
SigninLogs
| where TimeGenerated >= ago(ingestion_delay + rule_look_back)
| where ingestion_time() > ago(rule_look_back)
| where Status contains "Failure" and Status contains "50126"
| summarize RepeatTimesWhenBadPassWordInSameIp = count() by AlternateSignInName, IPAddress
| where RepeatTimesWhenBadPassWordInSameIp > 5
```

Test before deployment in production environment (remove the scanning time range)
```kusto
SigninLogs
| where Status contains "Failure" and Status contains "50126"
| summarize RepeatTimesWhenBadPassWordInSameIp = count() by AlternateSignInName, IPAddress
| where RepeatTimesWhenBadPassWordInSameIp > 5
```

#### 2. Generate incident when AD account is locked
```kusto
SecurityEvent
| where EventID == "4740"
| summarize count() by Account, EventID
```

#### 3. Monitor if the Azure VM is offline for more than 5 mins
Look back range > 10 mins <br>
Frequency > Every 5 mins
```kusto
Heartbeat
| where ResourceProvider contains "Microsoft.Compute"
| summarize LastCall = max(TimeGenerated) by Computer, ResourceId, ComputerIP
| where LastCall < ago(5m)
```
Once the incident is generated, we can check the VM in the events <br>
![image](https://user-images.githubusercontent.com/96930989/236965945-220d3c6c-7911-4ddc-83a2-e18828384909.png)

#### 4. Monitor if the Arc machine is offline for more than 5 mins
Look back range > 10 mins <br>
Frequency > Every 5 mins
```kusto
Heartbeat
| where ResourceProvider contains "Microsoft.HybridCompute"
| where ComputerEnvironment contains "Non-Azure"
| summarize LastCall = max(TimeGenerated) by Computer, ResourceId, ComputerIP
| where LastCall < ago(5m)
```

#### 5. Monitor if VM stops forwarding CEF logs

Azure VM
```kusto
CommonSecurityLog
| where _ResourceId contains "Microsoft.Compute"
| summarize LastCall = max(TimeGenerated) by Computer, _ResourceId
| where LastCall < ago(5m)
```

Arc VM
```kusto
CommonSecurityLog
| where _ResourceId contains "Microsoft.HybridCompute"
| summarize LastCall = max(TimeGenerated) by Computer, _ResourceId
| where LastCall < ago(5m)
```

#### 6. Get alert when device is isolated in defender for endpoint
```kusto
DeviceRegistryEvents
| where * contains "Windows Advanced Threat Protection"
| where RegistryValueName contains "DisableEnterpriseAuthProxyValueToRestoreAfterIsolation"
| where RegistryValueData == "0"
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2ffee352-f97b-4e69-83cd-68f61b8c7943)

#### 7. Whitelist watchlist IPs
```kql
let watchlist = (_GetWatchlist('WHITELISTIP') | project IPAddress);
let IPRegex = '[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}';
let dt_lookBack = 1h; // Look back 1 hour for CommonSecurityLog events
let ioc_lookBack = 14d; // Look back 14 days for threat intelligence indicators
// Fetch threat intelligence indicators related to IP addresses
let IP_Indicators = ThreatIntelligenceIndicator
  | where TimeGenerated >= ago(ioc_lookBack)
  | summarize LatestIndicatorTime = arg_max(TimeGenerated, *) by IndicatorId
  | where Active == true and ExpirationDateTime > now()
  | where isnotempty(NetworkIP) or isnotempty(EmailSourceIpAddress) or isnotempty(NetworkDestinationIP) or isnotempty(NetworkSourceIP)
  | extend TI_ipEntity = iff(isnotempty(NetworkIP), NetworkIP, NetworkDestinationIP)
  | extend TI_ipEntity = iff(isempty(TI_ipEntity) and isnotempty(NetworkSourceIP), NetworkSourceIP, TI_ipEntity)
  | extend TI_ipEntity = iff(isempty(TI_ipEntity) and isnotempty(EmailSourceIpAddress), EmailSourceIpAddress, TI_ipEntity)
  | where ipv4_is_private(TI_ipEntity) == false and  TI_ipEntity !startswith "fe80" and TI_ipEntity !startswith "::" and TI_ipEntity !startswith "127.";
// Perform a join between IP indicators and CommonSecurityLog events

IP_Indicators
  // Use innerunique to keep performance fast and result set low, as we only need one match to indicate potential malicious activity that needs investigation
  | join kind=innerunique (
      CommonSecurityLog
      | where TimeGenerated >= ago(dt_lookBack)
      | extend MessageIP = extract(IPRegex, 0, Message)
      | extend CS_ipEntity = iff(isnotempty(SourceIP), SourceIP, DestinationIP)
      | extend CS_ipEntity = iff(isempty(CS_ipEntity) and isnotempty(MessageIP), MessageIP, CS_ipEntity)
      | extend CommonSecurityLog_TimeGenerated = TimeGenerated
  )
  on $left.TI_ipEntity == $right.CS_ipEntity
  // Filter out logs that occurred after the expiration of the corresponding indicator
  | where CommonSecurityLog_TimeGenerated < ExpirationDateTime
  // Group the results by IndicatorId and CS_ipEntity, and keep the log entry with the latest timestamp
  | summarize CommonSecurityLog_TimeGenerated = arg_max(CommonSecurityLog_TimeGenerated, *) by IndicatorId, CS_ipEntity
  // Select the desired output fields
  | project timestamp = CommonSecurityLog_TimeGenerated, SourceIP, DestinationIP, MessageIP, Message, DeviceVendor, DeviceProduct, IndicatorId, ThreatType, ExpirationDateTime, ConfidenceScore, TI_ipEntity, CS_ipEntity, LogSeverity, DeviceAction, Type
  | where SourceIP !in (watchlist)
```

#### 8.Check status of MDC data connectors
```kql
resources 
| where ['type'] =~ "microsoft.security/securityconnectors"
| extend propertiesJson = parse_json(tostring(['properties']))
| where propertiesJson contains "enabled"
| project
    subid = tostring(split(split(['id'], '/')[2], '/')[0]),
    connectorname = split(['id'], '/')[-1],
    environmentName = propertiesJson.environmentName, 
    environmentType = tostring(propertiesJson.environmentData.environmentType)
//| where environmentName == "AWS"
| sort by subid, environmentType
//| summarize count() by subid
```

#### 9.Generate incidents when data source stops ingestion of logs

### SecurityEvent
```kql
// Define a subset of SecurityEvent data
let SecurityEventData = SecurityEvent
    // Summarize to get the latest TimeGenerated for each combination of Computer, _ResourceId, and SourceComputerId
    | summarize TimeGenerated=max(TimeGenerated) by Computer, _ResourceId, SourceComputerId
    // Filter to keep only those events that occurred more than 5 minutes ago, you could modify this threshold
    | where TimeGenerated < ago(24h);
// Define a subset of Heartbeat data
let HeartbeatData = Heartbeat
    // Get distinct combinations of Computer, Category, and SourceComputerId
    | distinct Computer, Category, SourceComputerId;
// Perform an inner join between SecurityEventData and HeartbeatData on SourceComputerId
SecurityEventData
// The 'kind=inner' specifies that only matching rows from both datasets will be included
| join kind=inner (HeartbeatData) on SourceComputerId
// Select specific columns to include in the final output
| project Computer, _ResourceId, Category, TimeGenerated
```

### Syslog
```kql
// Define a subset of Syslog data
let SyslogData = Syslog
    // Summarize to get the latest TimeGenerated for each combination of Computer and _ResourceId
    | summarize TimeGenerated=max(TimeGenerated) by Computer, _ResourceId
    // Filter to keep only those events that occurred more than 5 minutes ago, you could modify this threshold
    | where TimeGenerated < ago(24h);
// Define a subset of Heartbeat data
let HeartbeatData = Heartbeat
    // Get distinct combinations of Computer and Category
    | distinct Computer, Category;
// Perform an inner join between SyslogData and HeartbeatData on Computer
SyslogData
// The 'kind=inner' specifies that only matching rows from both datasets will be included
| join kind=inner (HeartbeatData) on Computer
// Select specific columns to include in the final output
| project Computer, _ResourceId, Category, TimeGenerated
```

### AzureDiagnostics
```kql
AzureDiagnostics
    // Summarize to get the latest TimeGenerated for each _ResourceId
    | summarize TimeGenerated=max(TimeGenerated) by _ResourceId
    // Filter to keep only those events that occurred more than 15 minutes ago, you could modify this threshold
    | where TimeGenerated < ago(24h)
```
