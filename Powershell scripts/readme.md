# Useful powershell scripts

## 1. Get sentinel incidents created in specified time range
```powershell
Connect-AzAccount -TenantId <your tenant id>

Set-AzContext -Subscription <your subscription id>

# Define the start date (January 1, 2023)
$startDate = Get-Date -Year 2023 -Month 1 -Day 1
# Define the end date (May 1, 2023)
$endDate = Get-Date -Year 2023 -Month 2 -Day 15
# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}
# Expand all columns for the selected incidents
$incidents | ForEach-Object {
    $_ | Select-Object -Property *
}
```

## 2. Count sentinel incidents created in specified time range
```powershell
Connect-AzAccount -TenantId <your tenant id>

Set-AzContext -Subscription <your subscription id>

# Define the start date (January 1, 2023)
$startDate = Get-Date -Year 2023 -Month 1 -Day 1

# Define the end date (February 15, 2023)
$endDate = Get-Date -Year 2023 -Month 2 -Day 15

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Count the number of incidents
$incidentCount = $incidents.Count

# Display the count
Write-Host "Number of incidents between $($startDate.ToString('yyyy-MM-dd')) and $($endDate.ToString('yyyy-MM-dd')): $incidentCount"
```

## 3. Bulk close sentinel incidents created in specified time range
```powershell
Connect-AzAccount -TenantId <your tenant id>

Set-AzContext -Subscription <your subscription id>

# Define the start date (January 1, 2023)
$startDate = Get-Date -Year 2023 -Month 1 -Day 1

# Define the end date (February 15, 2023)
$endDate = Get-Date -Year 2023 -Month 2 -Day 28

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Bulk close the selected incidents
foreach ($incident in $incidents) {
    $incident | Update-AzSentinelIncident -Classification Undetermined -Status Closed -Severity 'Informational' -Title "Closed by Script"
    Write-Host "Closed incident $($incident.Name) created on $($incident.CreatedTimeUtc)"
}
```

# Playbook to trigger playbook running powershell scripts
### 1. Create a logic app (playbook) and enable managed identity following the doc [Enable system-assigned identity in Azure portal](https://learn.microsoft.com/en-us/azure/logic-apps/create-managed-service-identity?tabs=consumption#enable-system-assigned-identity-in-azure-portal) according to the type of the logic app

### 2. Search for `http` and select `request`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1d3e279c-793e-486d-a11b-6312ad44cf58) 

### 3. Select `When a HTTP request is received`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dac93013-67a8-4cbb-84b8-8538f96a12ea)

### 4. Click save and this url would be generated automatically
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/59d71480-0f7b-4eab-a025-a488b481c541) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e095cbb0-ad1c-40f2-a87b-2e68c8f4fbeb) <br>

### 5. Create an automation account following the doc [Quickstart: Create an Automation account using the Azure portal](https://learn.microsoft.com/en-us/azure/automation/quickstarts/create-azure-automation-account-portal)

### 6. Assign role to `logic app` to access this automation account
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5a926cff-0613-4fe8-86a3-755fb04c543b) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/4067c5e8-4b19-41e5-8354-5ef1c74c0437) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c176caad-96fb-4ca1-b3e0-16cd0e07c858) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/bd34734c-c028-4b71-9825-96b143bd5bf7) <br>

### 7. Assign permission to automation account's managed identity
We can refer to the doc here [Microsoft Sentinel roles, permissions, and allowed actions](https://learn.microsoft.com/en-us/azure/sentinel/roles#microsoft-sentinel-roles-permissions-and-allowed-actions)

Navigate to subscription > IAM <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/331b1746-4f01-464c-a0c1-bf287517f159) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/4c041545-9ddd-427b-9e39-f9b404261574) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/3039e92a-260e-4e5a-a90d-13294e779ffd) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/773c1b37-2eee-4884-af08-c700333141bf) <br>


### 8. Configure runbook in automation account
```powershell
Connect-AzAccount -Identity 

Set-AzContext -Subscription <your Subscription id>

# Define the start date (for example January 1, 2023)
$startDate = Get-Date -Year 2023 -Month 1 -Day 1

# Define the end date (for example May 15, 2023)
$endDate = Get-Date -Year 2023 -Month 5 -Day 15

# Rest of your script remains unchanged
$incidents = Get-AzSentinelIncident | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

foreach ($incident in $incidents) {
    $incident | Update-AzSentinelIncident -Classification Undetermined -Status Closed -Severity 'Informational' -Title "Closed by Script"
    Write-Host "Closed incident $($incident.Name) created on $($incident.CreatedTimeUtc)"
}
```

```powershell
Connect-AzAccount -Identity 

Set-AzContext -Subscription <your Subscription id>

# Define the end date (for example, today's date)
$endDate = Get-Date

# Define the start date by subtracting 10 days from the end date
$startDate = $endDate.AddDays(-10)

# Retrieve incidents that were created within the last 10 days
$incidents = Get-AzSentinelIncident | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

foreach ($incident in $incidents) {
    # Delete the incident
    Remove-AzSentinelIncident -Id $incident.Id
    Write-Host "Deleted incident $($incident.Name) created on $($incident.CreatedTimeUtc)"
}
```
