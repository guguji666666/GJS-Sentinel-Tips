## Connect your threat intelligence platform to Microsoft Sentinel

### Reference doc
* [Connect your threat intelligence platform to Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/connect-threat-intelligence-tip#enable-the-threat-intelligence-platforms-data-connector-in-microsoft-sentinel)
* [Create threat intelligence indicator - Graph](https://learn.microsoft.com/en-us/graph/api/tiindicators-post?view=graph-rest-beta&tabs=http)

### Workflow
![image](https://user-images.githubusercontent.com/96930989/226834203-ec5aaf75-069c-404e-9a33-24af28424512.png)

### [Prerequisites](https://learn.microsoft.com/en-us/azure/sentinel/connect-threat-intelligence-tip#prerequisites)
1. Either the `Global administrator` or `Security administrator` Azure AD roles
2. Read and write permissions to the Microsoft Sentinel `workspace` to store your threat indicators.

### [Deployment steps](https://learn.microsoft.com/en-us/azure/sentinel/connect-threat-intelligence-tip#instructions)
1. Obtain an Application ID and Client Secret from your Azure Active Directory
2. Input this information into your TIP solution or custom application
3. Enable the Threat Intelligence Platforms data connector in Microsoft Sentinel


#### For test purpose, we will use `graph explorer` as the client app to manually send TI to API
1. [Enable the Threat Intelligence Platforms data connector in Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/connect-threat-intelligence-tip#enable-the-threat-intelligence-platforms-data-connector-in-microsoft-sentinel)
2. Navigate to [Graph explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)
3. Modify the binding and url here
![image](https://user-images.githubusercontent.com/96930989/226835359-a539aca7-c531-40bd-9424-89f32748ab1d.png)

url
```
https://graph.microsoft.com/beta/security/tiIndicators
```

4. Grant consent here
![image](https://user-images.githubusercontent.com/96930989/226835538-17fd311d-6085-4538-8e49-7453b6aa94c2.png)

5. Send the TI information in the body for test
```
{
  "action": "alert",
  "activityGroupNames": [],
  "confidence": 0,
  "description": "This is a canary indicator for demo purpose. Take no action on any observables set in this indicator.",
  "expirationDateTime": "2023-12-01T21:43:37.5031462+00:00",
  "externalId": "Test--20230322",
  "fileHashType": "sha256",
  "fileHashValue": "aa64428647b57bf51524d1756b2ed746e5a3f31b67cf7fe5b5d8a9daf07ca313",
  "killChain": [],
  "malwareFamilyNames": [],
  "severity": 0,
  "tags": [],
  "targetProduct": "Azure Sentinel",
  "threatType": "WatchList",
  "tlpLevel": "green"
}
```

6. Click `Run query`
![image](https://user-images.githubusercontent.com/96930989/226836142-1fbec3cf-6998-420e-aad4-9fd052f377db.png)

7. Wait for 5 min and verify if the TI has been sent to the workspace
Table we used
```
ThreatIntelligenceIndicator
```
![image](https://user-images.githubusercontent.com/96930989/226836702-01278dc6-37d3-4d62-8a32-7c37eedc8da6.png)

Verify in `Threat intelligence` section

![image](https://user-images.githubusercontent.com/96930989/226837029-5d5f09df-a44b-40c3-9143-336115e287b2.png)
