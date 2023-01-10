## Azure Sentinel FAQ

#### 1. When we try to open the data connectors page in sentinel, we get the error below.
![image](https://user-images.githubusercontent.com/96930989/211318356-9e6403e3-6856-4a7a-a71f-322d63cfb356.png)

Each time you open the data connectors page, sentinel runs backend queries for all the connectors configured, if something wrong happens in the query, then it is expected that you got the error in UI.

Backend query found in the kusto query
```kusto
let emptyTable = datatable(TimeGenerated:datetime)[];let cefTableBase = materialize(union isfuzzy=true
(emptyTable),(CommonSecurityLog | summarize TimeGenerated = max(TimeGenerated) by DeviceVendor, DeviceProduct));
union isfuzzy=true 
(emptyTable),
(agari_bpalerts_log_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Agari", Group = 0) ,
(agari_apdpolicy_log_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Agari", Group = 0) ,
(agari_apdtc_log_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Agari", Group = 0) ,
(cefTableBase​
| where DeviceVendor == "Darktrace"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Darktrace", Group = 0) ,
(cefTableBase | where DeviceVendor == "Vectra Networks"
| where DeviceProduct == "X Series"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AIVectraDetect", Group = 0) ,
(cefTableBase​ 
| where DeviceVendor == "Akamai"
| where DeviceProduct == "akamai_siem"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AkamaiSecurityEvents", Group = 0) ,
(alcide_kaudit_activity_1_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AlcideKAudit", Group = 0) ,
(afad_parser
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AlsidForAD", Group = 0) ,
(ApacheHTTPServer
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ApacheHTTPServer", Group = 0) ,
(TomcatEvent
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ApacheTomcat", Group = 0) ,
(cefTableBase 
| where DeviceVendor == "Aruba Networks" and DeviceProduct == "ClearPass"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ArubaClearPass", Group = 0) ,
(Confluence_Audit_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ConfluenceAuditAPI", Group = 0) ,
(Jira_Audit_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "JiraAuditAPI", Group = 0) ,
(SigninLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AuditLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADNonInteractiveUserSignInLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADServicePrincipalSignInLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADManagedIdentitySignInLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADProvisioningLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(ADFSSignInLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADUserRiskEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADRiskyUsers
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(NetworkAccessTraffic
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADRiskyServicePrincipals
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AADServicePrincipalRiskEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActiveDirectory", Group = 0) ,
(AzureActivity
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureActivity", Group = 0) ,
(AzureDiagnostics | where ResourceType == "PUBLICIPADDRESSES"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "DDOS", Group = 0) ,
(AzureDiagnostics | where ResourceType == "AZUREFIREWALLS"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureFirewall", Group = 0) ,
(InformationProtectionLogs_CL​​
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureInformationProtection", Group = 0) ,
(AzureDiagnostics | where ResourceProvider == "MICROSOFT.KEYVAULT"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKeyVault", Group = 0) ,
(AzureDiagnostics | where Category == "kube-apiserver"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKubernetes", Group = 0) ,
(AzureDiagnostics | where Category == "kube-audit"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKubernetes", Group = 0) ,
(AzureDiagnostics | where Category == "kube-audit-admin"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKubernetes", Group = 0) ,
(AzureDiagnostics | where Category == "kube-controller-manager"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKubernetes", Group = 0) ,
(AzureDiagnostics | where Category == "kube-scheduler"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKubernetes", Group = 0) ,
(AzureDiagnostics | where Category == "cluster-autoscaler"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKubernetes", Group = 0) ,
(AzureDiagnostics | where Category == "guard"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureKubernetes", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "SQLSecurityAuditEvents"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "SQLInsights"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "AutomaticTuning"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "QueryStoreWaitStatistics"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "Errors"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "DatabaseWaitStatistics"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "Timeouts"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "Blocks"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "Deadlocks"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "Basic"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "InstanceAndAppAdvanced"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "WorkloadManagement"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(AzureDiagnostics | where ResourceType == "SERVERS/DATABASES" | where ResourceProvider == "MICROSOFT.SQL" | where Category == "DevOpsOperationsAudit"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureSql", Group = 0) ,
(StorageBlobLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureStorageAccount", Group = 0) ,
(StorageQueueLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureStorageAccount", Group = 0) ,
(StorageTableLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureStorageAccount", Group = 0) ,
(StorageFileLogs
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureStorageAccount", Group = 0) ,
(AzureDiagnostics | where ResourceType == "APPLICATIONGATEWAYS"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "WAF", Group = 0) ,
(AzureDiagnostics | where ResourceType in ("FRONTDOORS", "PROFILES")
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "WAF", Group = 0) ,
(AzureDiagnostics | where ResourceType == "CDNWEBAPPLICATIONFIREWALLPOLICIES"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "WAF", Group = 0) ,
(CGFWFirewallActivity
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BarracudaCloudFirewall", Group = 0) ,
(cefTableBase​ 
| where DeviceVendor == "Barracuda"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Barracuda", Group = 0) ,
(barracuda_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Barracuda", Group = 0) ,
(BetterMTDIncidentLog_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BetterMTD", Group = 0) ,
(BetterMTDDeviceLog_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BetterMTD", Group = 0) ,
(BetterMTDAppLog_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BetterMTD", Group = 0) ,
(BetterMTDNetflowLog_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BetterMTD", Group = 0) ,
(beSECURE_ScanEvent_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BeyondSecuritybeSECURE", Group = 0) ,
(beSECURE_ScanResults_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BeyondSecuritybeSECURE", Group = 0) ,
(beSECURE_Audit_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BeyondSecuritybeSECURE", Group = 0) ,
(CylancePROTECT​
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BlackberryCylancePROTECT", Group = 0) ,
(cefTableBase  
| where DeviceVendor == "Symantec" 
| where DeviceProduct == "DLP"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "BroadcomSymantecDLP", Group = 0) ,
(cefTableBase​ 
| where DeviceVendor == "Check Point"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CheckPoint", Group = 0) ,
(cefTableBase​ 
| where DeviceVendor =~ "Cisco"
| where DeviceProduct == "ASA"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CiscoASA", Group = 0) ,
(cefTableBase​
| where DeviceVendor == "Cisco"
| where DeviceProduct == "Firepower"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CiscoFirepowerEStreamer", Group = 0) ,
(CiscoMeraki
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CiscoMeraki", Group = 0) ,
(CiscoUCS
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CiscoUCS", Group = 0) ,
(Cisco_Umbrella_dns_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(1d)
| extend Key = "CiscoUmbrellaDataConnector", Group = 0) ,
(Cisco_Umbrella_proxy_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(1d)
| extend Key = "CiscoUmbrellaDataConnector", Group = 0) ,
(Cisco_Umbrella_ip_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(1d)
| extend Key = "CiscoUmbrellaDataConnector", Group = 0) ,
(Cisco_Umbrella_cloudfirewall_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(1d)
| extend Key = "CiscoUmbrellaDataConnector", Group = 0) ,
(CitrixAnalytics_userProfile_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(30d)
| extend Key = "Citrix", Group = 0) ,
(cefTableBase​ 
| where DeviceVendor == "Citrix" | where DeviceProduct == "NetScaler"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CitrixWAF", Group = 0) ,
(CognniIncidents_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CognniSentinelDataConnector", Group = 0) ,
(cefTableBase​ 
| where DeviceVendor !in ("Cisco","Check Point","Palo Alto Networks","Fortinet","F5","Barracuda","ExtraHop","OneIdentity","Zscaler", "ForgeRock Inc", "CyberArk", "illusive", "Vectra Networks", "Citrix")
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CEF", Group = 0) ,
(cefTableBase​
| where DeviceVendor == "Cyber-Ark"
| where DeviceProduct == "Vault"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CyberArk", Group = 0) ,
(CyberpionActionItems_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "CyberpionSecurityLogs", Group = 0) ,
(ESETEnterpriseInspector_CL​
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ESETEnterpriseInspector", Group = 0) ,
(eset_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "EsetSMC", Group = 0) ,
(ExabeamEvent
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Exabeam", Group = 0) ,
(cefTableBase
| where DeviceVendor == "ExtraHop"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ExtraHopNetworks", Group = 0) ,
(F5Telemetry_system_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "F5BigIp", Group = 0) ,
(cefTableBase
| where DeviceVendor == "F5"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "F5", Group = 0) ,
(cefTableBase​ 
| where DeviceVendor == "Forcepoint CASB"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ForcepointCasb", Group = 0) ,
(cefTableBase | where DeviceVendor == "Forcepoint CSG" | where  DeviceProduct == "Web"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ForcepointCSG", Group = 0) ,
(cefTableBase | where DeviceVendor == "Forcepoint CSG" | where  DeviceProduct == "Email"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ForcepointCSG", Group = 0) ,
(ForcepointDLPEvents_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ForcepointDlp", Group = 0) ,
(cefTableBase​ 
| where tolower(DeviceVendor) == "forcepoint" | where tolower(DeviceProduct) in ("ngfw", "firewall")
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ForcepointNgfw", Group = 0) ,
(cefTableBase
| where DeviceVendor == "ForgeRock Inc"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ForgeRock", Group = 0) ,
(cefTableBase
| where DeviceVendor == "Fortinet"
| where DeviceProduct startswith "Fortigate"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Fortinet", Group = 0) ,
(GWorkspace_ReportsAPI_admin_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "GWorkspaceRAPI", Group = 0) ,
(GWorkspace_ReportsAPI_calendar_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "GWorkspaceRAPI", Group = 0) ,
(GWorkspace_ReportsAPI_drive_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "GWorkspaceRAPI", Group = 0) ,
(GWorkspace_ReportsAPI_login_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "GWorkspaceRAPI", Group = 0) ,
(GWorkspace_ReportsAPI_mobile_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "GWorkspaceRAPI", Group = 0) ,
(GWorkspace_ReportsAPI_token_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "GWorkspaceRAPI", Group = 0) ,
(GWorkspace_ReportsAPI_user_accounts_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "GWorkspaceRAPI", Group = 0) ,
(cefTableBase
| where DeviceVendor == "illusive"
| where DeviceProduct == "illusive"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "illusiveAttackManagementSystem", Group = 0) ,
(cefTableBase 
| where DeviceVendor == "Imperva Inc."
| where DeviceProduct == "WAF Gateway"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ImpervaWAFGateway", Group = 0) ,
(InfobloxNIOS
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "InfobloxNIOS", Group = 0) ,
(JuniperSRX
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "JuniperSRX", Group = 0) ,
(DeviceEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceFileEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceImageLoadEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceInfo
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceLogonEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceNetworkEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceNetworkInfo
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceProcessEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceRegistryEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(DeviceFileCertificateInfo
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 0) ,
(EmailEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 1) ,
(EmailUrlInfo
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 1) ,
(EmailAttachmentInfo
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 1) ,
(EmailPostDeliveryEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 1) ,
(UrlClickEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 1) ,
(IdentityLogonEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 2) ,
(IdentityQueryEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 2) ,
(IdentityDirectoryEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 2) ,
(CloudAppEvents
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 3) ,
(AlertEvidence
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MicrosoftThreatProtection", Group = 4) ,
(SAPConnectorOverview() 
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SAP", Group = 0) ,
(Morphisec
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "MorphisecUTPP", Group = 0) ,
(Netskope_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Netskope", Group = 0) ,
(AzureDiagnostics | where Category == "NetworkSecurityGroupEvent"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureNSG", Group = 0) ,
(AzureDiagnostics | where Category == "NetworkSecurityGroupRuleCounter"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "AzureNSG", Group = 0) ,
(NGINXHTTPServer
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "NGINXHTTPServer", Group = 0) ,
(BSMmacOS_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "NXLogBSMmacOS", Group = 0) ,
(DNS_Logs_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "NXLogDnsLogs", Group = 0) ,
(LinuxAudit_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "NXLogLinuxAudit", Group = 0) ,
(Okta_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "OktaSSO", Group = 0) ,
(cefTableBase
| where DeviceVendor == "Onapsis"
| where DeviceProduct == "OSP"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "OnapsisPlatform", Group = 0) ,
(cefTableBase
| where DeviceVendor == "OneIdentity" and DeviceProduct == "SPS"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "OneIdentity", Group = 0) ,
(OracleWebLogicServerEvent
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "OracleWebLogicServer", Group = 0) ,
(OrcaAlerts_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "OrcaSecurityAlerts", Group = 0) ,
(OSSECEvent
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "OSSEC", Group = 0) ,
(cefTableBase
| where DeviceVendor == "Palo Alto Networks"
| where DeviceProduct has "PAN-OS"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "PaloAltoNetworks", Group = 0) ,
(Perimeter81_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Perimeter81ActivityLogs", Group = 0) ,
(ProofpointPOD_message_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ProofpointPOD", Group = 0) ,
(ProofpointPOD_maillog_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ProofpointPOD", Group = 0) ,
(ProofPointTAPMessagesDelivered_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ProofpointTAP", Group = 0) ,
(ProofPointTAPMessagesBlocked_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ProofpointTAP", Group = 0) ,
(ProofPointTAPClicksPermitted_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ProofpointTAP", Group = 0) ,
(ProofPointTAPClicksPermitted_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ProofpointTAP", Group = 0) ,
(PulseConnectSecure
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "PulseConnectSecure", Group = 0) ,
(QualysKB_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "QualysKB", Group = 0) ,
(QualysHostDetection_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "QualysVulnerabilityManagement", Group = 0) ,
(QualysHostDetectionV2_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "QualysVulnerabilityManagement", Group = 0) ,
(SalesforceServiceCloud_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SalesforceServiceCloud", Group = 0) ,
(SentinelOne_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SentinelOne", Group = 0) ,
(cefTableBase​
| where DeviceVendor == "SonicWall"
| where DeviceProduct has_any ("firewall","TZ 670","TZ 600","TZ 600P","NSv 270","TZ 570","TZ 570W","TZ 570P","TZ 500","TZ 500W","TZ 270","TZ 270W","TZ 370W","TZ 470W","TZ 350W","TZ 350","TZ 370","TZ 470","TZ 300W","TZ 300P","TZ 300","TZ 400W","TZ 400","SOHO 250","SOHO 250W","NSa 2700","NSv 470","NSv 870","NSa 3700","NSa 2600","NSa 2650","NSa 3600","NSa 3650","NSa 4650","NSa 5650","NSa 5700","NSa 6650","NSa 9250","NSa 9450","NSa 9650","NSsp 12400","NSsp 12800","NSsp 15700","NSv 10","NSv 25","NSv 50","NSv 100","NSv 200","NSv 300","NSv 400","NSv 800","NSv 1600")
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SonicWallFirewall", Group = 0) ,
(SophosCloudOptix_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SophosCloudOptix", Group = 0) ,
(SophosXGFirewall
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SophosXGFirewall", Group = 0) ,
(secRMM_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SquadraTechnologiesSecRmm", Group = 0) ,
(SquidProxy
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SquidProxy", Group = 0) ,
(SymantecICDx_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Symantec", Group = 0) ,
(SymantecProxySG
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(3d)
| extend Key = "SymantecProxySG", Group = 0) ,
(SymantecVIP
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "SymantecVIP", Group = 0) ,
(Syslog
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Syslog", Group = 0) ,
(cefTableBase
| where DeviceVendor == "Thycotic Software"| where DeviceProduct == "Secret Server"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ThycoticSecretServer_CEF", Group = 0) ,
(TrendMicroDeepSecurity
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "TrendMicro", Group = 0) ,
(TrendMicroTippingPoint
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "TrendMicroTippingPoint", Group = 0) ,
(TrendMicro_XDR_Health_Check_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "TrendMicroXDR", Group = 0) ,
(CarbonBlackEvents_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "VMwareCarbonBlack", Group = 0) ,
(CarbonBlackNotifications_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "VMwareCarbonBlack", Group = 0) ,
(CarbonBlackAuditLogs_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "VMwareCarbonBlack", Group = 0) ,
(VMwareESXi
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "VMwareESXi", Group = 0) ,
(WatchGuardFirebox​
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "WatchguardFirebox", Group = 0) ,
(cefTableBase
| where DeviceVendor == "WireX"
| where DeviceProduct == "WireX NFP"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "WireX_Systems_NFP", Group = 0) ,
(Workplace_Facebook_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "WorkplaceFacebook", Group = 0) ,
(ZimperiumThreatLog_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ZimperiumMtdAlerts", Group = 0) ,
(ZimperiumMitigationLog_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ZimperiumMtdAlerts", Group = 0) ,
(Zoom_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Zoom", Group = 0) ,
(cefTableBase
| where DeviceVendor == "Zscaler"
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "Zscaler", Group = 0) ,
(ZPA_CL
| summarize LastLogReceived = max(TimeGenerated)
| project IsConnected = LastLogReceived > ago(7d)
| extend Key = "ZscalerPrivateAccess", Group = 0)
```
Though this error shows, but your data connectors are still sending the data to your workspace, normally the error in UI `will not` affect your production environment.

Possible reasons:
1. The volume of incoming data from specified data source is too high
2. Query timeout due to high volume of incoming data
3. Query fails due to wrong parameter defined

Troubleshooting steps:
1. Capture the `HAR` log when `refreshing` the data connector page
![image](https://user-images.githubusercontent.com/96930989/211319057-e6e73958-4476-4441-985e-f03d01a2c7fb.png)
2. In HAR log, look for the event whose `response` is "400"
![image](https://user-images.githubusercontent.com/96930989/211438200-4f3d2f62-e365-45b4-854a-8c9d43007ae2.png)
3. Check the data connector mentioned in the "400" error separately and see if we meet the issue when running the query for this data source `alone`
4. Check the `volume` of incoming logs from the affected data source found in the HAR log
5. Check the `time` it takes to perform the query

