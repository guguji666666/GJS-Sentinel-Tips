# Stream data from defender `DeviceTvmInfoGathering` table to sentinel worksapce
## 1. Entra ID application registration
![image](https://github.com/user-attachments/assets/054bec50-1447-48cb-9186-ac2de597c82f)

![image](https://github.com/user-attachments/assets/05e42b5c-e4d7-4a90-a055-063eab002063)

![image](https://github.com/user-attachments/assets/acd2911a-594c-4e21-bfd2-917251eda292)

## 2. Collect information below
### Application id (Client id)
### Tenant id (Directory id)
![image](https://github.com/user-attachments/assets/2a7ebc4b-0dcf-4d44-9779-9e8434f065d9)
### Client secret
![image](https://github.com/user-attachments/assets/fe0df5d1-fb3a-4106-8cdd-0ae7f1ef51d9)


## 3. Get token using application context (powershell script)
```powershell
# This script acquires the App Context Token and stores it in the variable $token for later use in the script.
# Paste your Tenant ID, App ID, and App Secret (App key) into the indicated quotes below.
$tenantId = '<Paste your tenant ID here>' ### Paste your tenant ID here
$appId = '<Paste your Application ID here>' ### Paste your Application ID here
$appSecret = 'Paste your Application key here' ### Paste your Application key here
$resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
$oAuthUri = "https://login.windows.net/$tenantId/oauth2/token"
# Prepare the authorization body
$authBody = [Ordered] @{
    resource      = "$resourceAppIdUri"
    client_id     = "$appId"
    client_secret = "$appSecret"
    grant_type    = 'client_credentials'
}
try {
    # Make the authentication request
    $authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
    # Extract and store the token
    $token = $authResponse.access_token
    # Set the token to clipboard
    Set-Clipboard -Value $token
    # Output token for verification (optional)
    Write-Host "Access Token: $token"
    Write-Host "The access token has been copied to the clipboard."
}
catch {
    Write-Error "Failed to acquire the access token. Error: $_"
}
```
The token will be copied to your clipboard automatically <br>
![image](https://github.com/user-attachments/assets/462f994c-b692-4dea-856a-1fec346e81c5)

## 4. Test in Rest API tool (such as bruno)
### Method
```
Post
```
### URL
```
https://api.securitycenter.microsoft.com/api/advancedqueries/run
```
### Body (you can customize the query inside)
```json
{
    "Query":"DeviceTvmInfoGathering | where Timestamp >= ago(7d)"
}
```

Sample API response <br>
![image](https://github.com/user-attachments/assets/18093f84-1747-4043-aeaf-8a6388418b1d)

Find section `results` in response, copy to your notepad, let's say `AH_results.json` <br>
![image](https://github.com/user-attachments/assets/87244455-42a1-4940-94a8-bb681aea57e4)

We pick one entry in the results section <br>
![image](https://github.com/user-attachments/assets/cf6b6937-5dd4-41d1-9aba-24067909bcf6)

Or you can use the json below directly <br>
```json
{
    "Timestamp": "2025-02-19T06:09:28Z",
    "LastSeenTime": "2025-01-20T14:55:23Z",
    "DeviceId": "fd4977d8bef46e122a91fc57fb96c362de70c425",
    "DeviceName": "yyds-ad2025.testing.com",
    "OSPlatform": "Windows11",
    "AdditionalFields": {
        "AvMode": null,
        "AvEngineVersion": null,
        "AvSignatureVersion": null,
        "AvPlatformVersion": null,
        "AvScanResults": null,
        "AvModeDataRefreshTime": null,
        "CloudProtectionState": null,
        "SslClient20": null,
        "SslClient30": null,
        "SslServer20": null,
        "SslServer30": null,
        "TlsClient10": null,
        "TlsClient11": null,
        "TlsClient12": null,
        "TlsServer10": null,
        "TlsServer11": null,
        "TlsServer12": null,
        "SchUseStrongCrypto35": null,
        "SchUseStrongCrypto35Wow6432": null,
        "SchUseStrongCrypto40": null,
        "SchUseStrongCrypto40Wow6432": null,
        "SystemDefaultTlsVersions35": null,
        "SystemDefaultTlsVersions35Wow6432": null,
        "SystemDefaultTlsVersions40": null,
        "SystemDefaultTlsVersions40Wow6432": null,
        "Log4j_CVE_2021_44228": null,
        "LocalCveScannerExecuted": null,
        "Log4jLocalScanVulnerable": null,
        "Log4JEnvironmentVariableMitigation": "false",
        "IsWindowsLtscVersionRunning": null,
        "AvEngineUpdateTime": null,
        "AvSignatureUpdateTime": null,
        "AvPlatformUpdateTime": null,
        "AvIsSignatureUptoDate": null,
        "AvIsEngineUptodate": null,
        "AvIsPlatformUptodate": null,
        "WdavorHeartbeatEventType": null,
        "AvSignaturePublishTime": null,
        "AvPlatformPublishTime": null,
        "AvEnginePublishTime": null,
        "AvSignatureRing": null,
        "AvPlatformRing": null,
        "AvEngineRing": null,
        "Spring4Shell_CVE_2022_22965": null,
        "CVE_2022_30190_Mitigated": null,
        "Bootiful_Mind_status": null,
        "AvSignatureDataRefreshTime": null,
        "EBPFStatus": null
    },
    "TenantId": "",
    "Type": "DeviceTvmInfoGathering",
    "SourceSystem": "",
    "MachineGroup": ""
}
```


## 4. Create custom table in sentinel workspace

### Navigate to Log Analytics workspace > your workspace > table, click `+ Create`
![image](https://github.com/user-attachments/assets/ce319deb-d10d-4447-befe-3aa739b06245)

### Basic settings
* New Table name
* New Data collection rule name
* Data collection endpoint used
![image](https://github.com/user-attachments/assets/d2d846b3-2636-4e5a-9f76-feb7524b3af1)

### Define new custom table schema
Upload sample file --- `AH_results.json` we saved before <br>
![image](https://github.com/user-attachments/assets/214a832e-5c27-4cbe-ad52-2c8956c135fb)

Enter transformation editor <br>
![image](https://github.com/user-attachments/assets/449d50a2-ec27-4689-8617-134dfbf31d7d)

Add the query below, run it and apply <br>
```kusto
source
| extend TimeGenerated = Timestamp
| project-away TenantId, Type
```
![image](https://github.com/user-attachments/assets/0759d57c-18da-4c55-88a7-6ca94126ec6a)

Go ahead to complete creation <br>
![image](https://github.com/user-attachments/assets/83a6d34b-fcfa-4af3-a2ad-e2c9fdd3624a)

![image](https://github.com/user-attachments/assets/5b6c07c1-12d5-43f9-95f7-c3197c7c40b1)


