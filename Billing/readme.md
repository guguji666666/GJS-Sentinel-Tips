## Sentinel Cost

## 1. Log volume (ingestion)
### Azure monitor doc: [Standard columns in Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/log-standard-columns#_billedsize)
### Check volume per table
```kusto
// Sort billed table in KB/MB/GB
union withsource= table *
| where TimeGenerated >= 30d
| where _IsBillable == true
| summarize Size = sum(_BilledSize) by table, _IsBillable 
| sort by Size desc 
| extend Format_Size = format_bytes(toint(Size), 2)
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/60e89eb8-6355-4666-bdfd-8269d138d317)

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
// Sort billed table in KB/MB/GB
union withsource= table *
| where TimeGenerated >= 30d
| where _IsBillable == true
| summarize Size = sum(_BilledSize) by table, _IsBillable 
| sort by Size desc 
| summarize totalsize = format_bytes(toint(sum(Size)), 2)
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/57d5a31a-a5cb-4226-96ce-3640466a5038)

### We can also check the volume for specifed table
Sample 1 : CommonSecurityLog
```kusto
CommonSecurityLog
| where _IsBillable == true
| where TimeGenerated >= 30d
| where DeviceVendor == "Microsoft"
| summarize Size = sum(_BilledSize) by bin(TimeGenerated, 1d), DeviceVendor, _IsBillable 
| extend Format_Size = format_bytes(toint(Size), 2)
| project TimeGenerated, DeviceVendor, Format_Size
| sort by TimeGenerated desc
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/9c4248db-3eaa-4d4f-a442-a4c451caf149)

Sample 2 : OKta_CL
```kusto
Okta_CL
| where _IsBillable == true
| where TimeGenerated >= 30d
| where actor_displayName_s == "Okta System"
| summarize Size = sum(_BilledSize) by bin(TimeGenerated, 1d), actor_displayName_s, _IsBillable 
| extend Format_Size = format_bytes(toint(Size), 2)
| project TimeGenerated, actor_displayName_s, Format_Size
| sort by TimeGenerated desc
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/81bce13d-aba7-48c1-b97f-7bf6ea8aec8e)

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

Sample
#### 1. The region of my sentinel workspace is `East Asia`
#### 2. The price tier i am using is `Pay-As-You-Go`
#### 3. The cost shown here covers sentinel data analysis and data ingestion to workspace
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/bd38d4c3-da2a-4bd2-a22d-ae9c8e7fc63d)
#### 4. Then i will use the query below
```kusto
union withsource=TableName1 *
| where TimeGenerated > ago(30d)
| summarize Entries = count(), Size = sum(_BilledSize), last_log = datetime_diff("second",now(), max(TimeGenerated)), estimate  = sumif(_BilledSize, _IsBillable==true)  by TableName1, _IsBillable
| project ['Table Name'] = TableName1, ['Table Entries'] = Entries, ['Table Size'] = Size,
          ['Size per Entry'] = 1.0 * Size / Entries, ['IsBillable'] = _IsBillable, ['Last Record Received'] =  last_log , ['Estimated Table Price'] =  (estimate/(1024*1024*1024)) * 7.13
 | order by ['Table Size']  desc
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/13569b25-d437-4855-adbc-f3ec52e4d6a3)

