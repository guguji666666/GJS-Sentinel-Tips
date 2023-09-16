## Check the voluming of incoming logs to specified table and calculate sentinel cost

CEF log 
```kusto
CommonSecurityLog
| where _IsBillable == true
| where TimeGenerated >= 30d   //set the timerange
| where DeviceVendor == "Microsoft" // set the filter for devicevendor
| summarize Size = sum(_BilledSize) by bin(TimeGenerated, 1d), DeviceVendor, _IsBillable 
| extend MB = format_bytes(toint(Size), 2)
| project TimeGenerated, DeviceVendor, MB
| sort by TimeGenerated asc 
```
![image](https://user-images.githubusercontent.com/96930989/231068311-46c8b774-24b2-44ae-8ec8-4ab66db735bc.png)

Okta log
```kusto
Okta_CL
| where _IsBillable == true
| where TimeGenerated >= 30d
| where actor_displayName_s == "Okta System"
| summarize Size = sum(_BilledSize) by bin(TimeGenerated, 1d), actor_displayName_s, _IsBillable 
| extend MB = format_bytes(toint(Size), 2)
| project TimeGenerated, actor_displayName_s, MB
| sort by TimeGenerated asc ![image](https://user-images.githubusercontent.com/96930989/231069375-d1f61f9b-8350-4d3f-bd60-219cfa4030e3.png)
```
![image](https://user-images.githubusercontent.com/96930989/231069415-73f5ec0b-eed5-4a09-b61f-abe7c1396870.png)
