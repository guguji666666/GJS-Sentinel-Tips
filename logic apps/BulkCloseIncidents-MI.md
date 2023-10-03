![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/56ade6c2-c949-4011-b4b3-072727c260f6)# Bulk close sentinel incidents generated xxx days ago

### [Logic app pricing](https://azure.microsoft.com/en-us/pricing/details/logic-apps/)

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
| take 10 //For testing purpose we can take 10 to check if the logic app is working
```

### 3. API action - HTTP (Authenticate with managed identity)
Enable Managed identity of the logic app <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/40293346-d98e-404e-8e06-0c44ab6160c2)

Assign `Microsoft Sentinel Contributor` role to MI of logic app <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/84095bb2-78ed-4668-8d19-027a4d44374f) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/781afb2a-adae-4ebd-803e-7bb4ca9cd27c)


Set the request URL <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/14b68648-9510-4f0b-a1f8-d68aa76239ea)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c1bab4f1-1794-4456-b38c-42ade861f85b)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e36ef82c-2023-44fa-8b8e-417b70257e2f)

URL
```
https://management.azure.com/@{items('For_each')?['IncidentArmld']}?api-version=2023-02-01
```

Set the request body <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1dbd5bff-a410-40f6-b919-e6665fa7a6fc)

```json
{
  "properties": {
    "severity": "Informational",
    "classification": "Undetermined",
    "Title": "Close by API",
    "status": "Closed"
  }
}
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5340f61d-9e36-4333-aedf-48d579729b58)

### 4. Save the logic app and run it manually
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2f3f0d35-90d3-4539-b56a-bbe93f8cde04)

Verify the results in the running history
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d5aaeabc-d07a-4a58-8978-ffef6d05a09a)

