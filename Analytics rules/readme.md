## Deploy Analytics rule to Microsoft Sentinel

#### 1. [Deploy Analytics rule in the portal UI](https://learn.microsoft.com/en-us/azure/sentinel/import-export-analytics-rules)
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

#### 3. Monitor if the Azure machine is offline
```kusto
Heartbeat
| where ResourceProvider contains "Microsoft.Compute"
| summarize LastCall = max(TimeGenerated) by Computer, ResourceId, ComputerIP
| where LastCall < ago(5m)
```

#### 4. Monitor if the Arc machine is offline
```kusto
Heartbeat
| where ResourceProvider contains "Microsoft.HybridCompute"
| where ComputerEnvironment contains "Non-Azure"
| summarize LastCall = max(TimeGenerated) by Computer, ResourceId, ComputerIP
| where LastCall < ago(5m)
```

