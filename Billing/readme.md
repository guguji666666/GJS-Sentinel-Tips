## Sentinel Cost

## 1. Log volume (ingestion)
### Azure monitor doc: [Standard columns in Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-standard-columns#_billedsize)
### Check volume per table
```kusto
// Sort billed table in MB
union withsource= table *
| where TimeGenerated >= 30d
| where _IsBillable == true
| summarize Size = sum(_BilledSize) by table, _IsBillable 
| sort by Size desc 
| extend MB = format_bytes(toint(Size), 2)
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/fbc642bc-cfcd-4488-864d-ade7f5057d1f)


### Check the volume in the specifed timerange
```kusto
union withsource= table *
| where _IsBillable == true
| where TimeGenerated between(datetime(2023-05-01) ..datetime(2023-08-03))
| summarize Size = sum(_BilledSize) by table, _IsBillable 
| sort by Size desc 
| extend Size2 = format_bytes(toint(Size), 2)
```

### Check total volume
```kusto
// Sort billed table in MB
union withsource= table *
| where TimeGenerated >= 30d
| where _IsBillable == true
| summarize Size = sum(_BilledSize) by table, _IsBillable 
| sort by Size desc 
| extend MB = format_bytes(toint(Size), 2)
| summarize totalsize = format_bytes(toint(sum(Size)), 2)
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/702bc6d7-f2ca-4916-8926-09264d23148f)

### We can also check the volume for specifed table
Sample 1 : CommonSecurityLog
```kusto
CommonSecurityLog
| where _IsBillable == true
| where TimeGenerated >= 30d
| where DeviceVendor == "Microsoft"
| summarize Size = sum(_BilledSize) by bin(TimeGenerated, 1d), DeviceVendor, _IsBillable 
| extend MB = format_bytes(toint(Size), 2)
| project TimeGenerated, DeviceVendor, MB
| sort by TimeGenerated asc
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b0d79dd1-0fd9-436c-a35f-1f8838264766)

Sample 2 : OKta_CL
```kusto
Okta_CL
| where _IsBillable == true
| where TimeGenerated >= 30d
| where actor_displayName_s == "Okta System"
| summarize Size = sum(_BilledSize) by bin(TimeGenerated, 1d), actor_displayName_s, _IsBillable 
| extend MB = format_bytes(toint(Size), 2)
| project TimeGenerated, actor_displayName_s, MB
| sort by TimeGenerated asc
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ef304968-bcba-4cc5-9378-4127dadf7afd)


## 2. Calculation of Sentinel cost
### Reference doc
* [Microsoft Sentinel pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-sentinel/)
* [Azure Monitor pricing](https://azure.microsoft.com/en-us/pricing/details/monitor/)
* [Switch to the simplified pricing tiers for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/enroll-simplified-pricing-tier?tabs=microsoft-sentinel)
* [SentinelKQL/TableUsageandCost.txt](https://github.com/rod-trent/SentinelKQL/blob/master/TableUsageandCost.txt)
```kusto
//Shows Tables by Table size and how much it costs
//For the 0.0 - Enter your price (tip. Use the Azure Pricing Calculator, enter a value of 1GB and divide by 30days)
union withsource=TableName1 *
| where TimeGenerated > ago(30d)
| summarize Entries = count(), Size = sum(_BilledSize), last_log = datetime_diff("second",now(), max(TimeGenerated)), estimate  = sumif(_BilledSize, _IsBillable==true)  by TableName1, _IsBillable
| project ['Table Name'] = TableName1, ['Table Entries'] = Entries, ['Table Size'] = Size,
          ['Size per Entry'] = 1.0 * Size / Entries, ['IsBillable'] = _IsBillable, ['Last Record Received'] =  last_log , ['Estimated Table Price'] =  (estimate/(1024*1024*1024)) * 0.0
 | order by ['Table Size']  desc
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/12558001-9c88-438f-a8d3-40462dbeab83)



