# 📊 Stream `DeviceTvmInfoGathering` Data to Microsoft Sentinel Workspace

## 📚 Reference Documentation
- [Advanced Hunting API – Microsoft Defender for Endpoint](https://learn.microsoft.com/en-us/defender-endpoint/api/run-advanced-query-api#example)
- [Tutorial: Send data to Azure Monitor using Logs Ingestion API (Resource Manager templates)](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-api?tabs=dcr#assign-permissions-to-a-dcr)
- [Azure Monitor Logs Ingestion API – Overview](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/logs-ingestion-api-overview#rest-api-call)

---

## 🔐 1. Register an App in Microsoft Entra ID

![App Registration Step 1](https://github.com/user-attachments/assets/054bec50-1447-48cb-9186-ac2de597c82f)
![App Registration Step 2](https://github.com/user-attachments/assets/05e42b5c-e4d7-4a90-a055-063eab002063)
![App Registration Step 3](https://github.com/user-attachments/assets/acd2911a-594c-4e21-bfd2-917251eda292)

---

## 🧾 2. Collect Required Information

### 🔹 Application (Client) ID
### 🔹 Tenant (Directory) ID
![Collect App Info](https://github.com/user-attachments/assets/2a7ebc4b-0dcf-4d44-9779-9e8434f065d9)

### 🔹 Client Secret
![Client Secret](https://github.com/user-attachments/assets/fe0df5d1-fb3a-4106-8cdd-0ae7f1ef51d9)

---

## 🪪 3. Acquire Access Token (PowerShell)

```powershell
# Replace placeholder values with your actual App registration details
$tenantId = '<Paste your tenant ID here>'
$appId = '<Paste your Application ID here>'
$appSecret = 'Paste your Application key here'
$resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
$oAuthUri = "https://login.windows.net/$tenantId/oauth2/token"

$authBody = [Ordered]@{
    resource      = $resourceAppIdUri
    client_id     = $appId
    client_secret = $appSecret
    grant_type    = 'client_credentials'
}

try {
    $authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
    $token = $authResponse.access_token
    Set-Clipboard -Value $token
    Write-Host "Access Token: $token"
    Write-Host "The access token has been copied to the clipboard."
} catch {
    Write-Error "Failed to acquire the access token. Error: $_"
}
```

The token will be automatically copied to your clipboard.

![Token Output](https://github.com/user-attachments/assets/462f994c-b692-4dea-856a-1fec346e81c5)

---

## 📬 4. Test API Using REST Tool (e.g., [Bruno](https://www.usebruno.com/))

### ➤ Method: `POST`

### ➤ URL:
```
https://api.securitycenter.microsoft.com/api/advancedqueries/run
```

### ➤ Body:
```json
{
  "Query": "DeviceTvmInfoGathering | where Timestamp >= ago(7d)"
}
```

Sample Response:
![Sample Response](https://github.com/user-attachments/assets/18093f84-1747-4043-aeaf-8a6388418b1d)

Copy the `results` section into a file named `AH_results.json`:
![Copy Results](https://github.com/user-attachments/assets/87244455-42a1-4940-94a8-bb681aea57e4)

Pick one sample result for schema creation:
![Sample Entry](https://github.com/user-attachments/assets/cf6b6937-5dd4-41d1-9aba-24067909bcf6)

---

## 📁 5. Create Custom Table in Sentinel Workspace

### Step 1: Log Analytics Workspace > Tables > `+ Create`

![Create Table](https://github.com/user-attachments/assets/ce319deb-d10d-4447-befe-3aa739b06245)

### Step 2: Define Basics
- Table name
- DCR name
- Data Collection Endpoint

![Define Basics](https://github.com/user-attachments/assets/d2d846b3-2636-4e5a-9f76-feb7524b3af1)

### Step 3: Upload `AH_results.json` and Transform

![Upload File](https://github.com/user-attachments/assets/214a832e-5c27-4cbe-ad52-2c8956c135fb)

Open Transformation Editor:
![Open Editor](https://github.com/user-attachments/assets/449d50a2-ec27-4689-8617-134dfbf31d7d)

Apply the following KQL:
```kusto
source
| extend TimeGenerated = Timestamp
| project-away TenantId, Type
```

![Run Transformation](https://github.com/user-attachments/assets/0759d57c-18da-4c55-88a7-6ca94126ec6a)

Finish table creation:
![Table Done](https://github.com/user-attachments/assets/83a6d34b-fcfa-4af3-a2ad-e2c9fdd3624a)

---

## ⚙️ 6. Logic App: Ingest to Sentinel

### 🔸 Create Logic App (Consumption Plan)

![Create Logic App](https://github.com/user-attachments/assets/fa47564b-fb2c-477b-a710-9e2ba1faaa4e)

### 🔸 1. Add Recurrence Trigger

![Recurrence](https://github.com/user-attachments/assets/27843f07-ef2c-4fce-9490-95dbd96ffeb1)

### 🔸 2. Run Advanced Hunting Query

- Method: `POST`
- URI: `https://api.securitycenter.microsoft.com/api/advancedqueries/run`
- Body:
```json
{
  "Query": "DeviceTvmInfoGathering | where Timestamp >= ago(7d)"
}
```

- Authority: `https://login.windows.net/`
- Audience: `https://api.securitycenter.microsoft.com`

Use app credentials from Step 2.

![HTTP Config](https://github.com/user-attachments/assets/ad3e452a-eac9-4d3b-851e-4e1e74286adf)

### 🔸 3. Parse JSON Results

![Parse JSON](https://github.com/user-attachments/assets/77df6146-1c0b-4ebe-8237-f8c14ecb91b1)

*(Full schema available in original documentation)*

### 🔸 4. Ingest Results via Logs Ingestion API

**Endpoint Format:**
```
{DataCollectionEndpoint}/dataCollectionRules/{DCR Immutable ID}/streams/{Stream Name}?api-version=2023-01-01
```

- 🔹 Find DataCollectionEndpoint  
  ![Endpoint](https://github.com/user-attachments/assets/5e48d9ee-4017-434f-8d15-16c93934b57f)
- 🔹 Find DCR Immutable ID  
  ![DCR ID](https://github.com/user-attachments/assets/01bfeed6-fd91-478a-8327-da3fcc25bbee)
- 🔹 Find Stream Name  
  ![Stream Name](https://github.com/user-attachments/assets/668222e1-f651-4609-ad8c-805679c338cc)

Audience:
```
https://monitor.azure.com
```

![Audience](https://github.com/user-attachments/assets/c749df98-d4eb-42d7-860b-af8ac2cdff5a)

---

### 🔸 5. Assign Role to Logic App

Assign `Monitoring Metrics Publisher` role:

![Assign Role](https://github.com/user-attachments/assets/7ccf7e80-7ac6-476e-852e-7592d50990e1)

![Role Selection](https://github.com/user-attachments/assets/c5633305-1a4e-4023-9ba1-d77fe7c01353)

---

## ✅ 7. Run & Monitor

Run manually and review logic app run history.

![Run Logic App](https://github.com/user-attachments/assets/dee7ec6a-1ee3-4436-8947-d23ae71e3798)

![History](https://github.com/user-attachments/assets/9d87cd22-8723-48d7-9e77-2e821a939953)
