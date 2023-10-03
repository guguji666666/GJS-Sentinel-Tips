# Bulk close sentinel incidents generated xxx days ago

## [Logic app pricing](https://azure.microsoft.com/en-us/pricing/details/logic-apps/)

## Deploy logic app

### 1. Trigger

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d53f046e-8320-40df-811a-886e09015b62)

### 2. Action - Run query and list results
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/46007568-2c1e-470c-a2e8-640a76f875ce)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/7b30ba6f-1d34-4246-a561-8e88823f2990)

```kusto
SecurityIncident
| where TimeGenerated < ago(10d) //You can customizd the days here
| where Severity contains "Low" or Severity contains "Informational"
| where Status !contains "Closed"
| project IncidentName, Title, Status, IncidentUrl, TimeGenerated, IncidentNumber
| extend IncidentUrl = tostring(IncidentUrl) //Ensure that the field is treated as a string
| extend SubstringStart = indexof(IncidentUrl,"/subscriptions")  //Find the index where "/subscriptions"appears in the URL
| extend IncidentArmld = substring(IncidentUrl,SubstringStart)  //Extract the substring starting from theindex
// | distinct IncidentArmld
| project TimeGenerated, IncidentArmld, Title, Status, IncidentName, IncidentNumber
| order by TimeGenerated desc
| take 10
```
We take 10 just to test if the logic app is working or not.


### 3. API action - HTTP (Authenticate with managed identity)
Enable Managed identity of the logic app <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/40293346-d98e-404e-8e06-0c44ab6160c2)

Assign `Microsoft Sentinel Contributor` role to MI of logic app <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/84095bb2-78ed-4668-8d19-027a4d44374f)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/781afb2a-adae-4ebd-803e-7bb4ca9cd27c)


#### Set the binding,request URL and request body <br>

```
https://management.azure.com/@{items('For_each')?['IncidentArmld']}?api-version=2023-02-01
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/309ae268-7d67-4bfc-b9f1-7bdbcb2a8420)


Request body <br>
```json
{
  "properties": {
    "severity": "Informational",
    "classification": "Undetermined",
    "Title": "Close by logic app",
    "status": "Closed"
  }
}
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/277ee825-bb26-4d3f-9a05-f420259e91a6)

Configure authentication with MI <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/7905ff53-9f03-4aba-a4c7-9c0986bba12c)


### 4. Save the logic app and run it manually

Verify the results in the running history
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d5aaeabc-d07a-4a58-8978-ffef6d05a09a)

