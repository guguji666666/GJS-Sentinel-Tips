# Stream data from defender `DeviceTvmInfoGathering` table to sentinel worksapce
## 1. Entra ID application registration
![image](https://github.com/user-attachments/assets/054bec50-1447-48cb-9186-ac2de597c82f)

![image](https://github.com/user-attachments/assets/05e42b5c-e4d7-4a90-a055-063eab002063)

![image](https://github.com/user-attachments/assets/acd2911a-594c-4e21-bfd2-917251eda292)

## 2. Collect information below
* Tenant id (Directory id)
* Application id (Client id)
![image](https://github.com/user-attachments/assets/2a7ebc4b-0dcf-4d44-9779-9e8434f065d9)
* Client secret
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

