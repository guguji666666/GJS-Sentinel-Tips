# Useful powershell scripts

## 1. Get sentinel incidents created in specified time range

## 2. Count sentinel incidents created in specified time range


## 3. Bulk close sentinel incidents created in specified time range
```powershell
Connect-AzAccount -TenantId <your tenant id>

Set-AzContext -Subscription <your subscription id>

# Define the start date (January 1, 2023)
$startDate = Get-Date -Year 2023 -Month 3 -Day 1

# Define the end date (May 1, 2023)
$endDate = Get-Date -Year 2023 -Month 3 -Day 15

# Define the Azure resource group and workspace name
$resourceGroupName = "<resource group name>"
$workspaceName = "<workspace name>"

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Close incidents with specific classification, status, and title
foreach ($incident in $incidents) {
    $incidentID = $incident.Name
    $title = "<Your Title Here>"  # Replace with the desired title
    $severity = "Informational"  # Set the desired severity level
    
    # Close the incident with specific classification, status, severity, and title
    Update-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName -IncidentID $incidentID -Classification Undetermined -Status 'Closed' -Severity $severity -Title $title

    Write-Host "Executed command to close incident $incidentID with Classification 'Undetermined', Status 'Closed', Severity '$severity', and Title '$title'"
}
```

or

```powershell
Connect-AzAccount -TenantId <your tenant id>

Set-AzContext -Subscription <your subscription id>

# Calculate the date 10 days ago
$endDate = Get-Date
$startDate = $endDate.AddDays(-10)

# Define the Azure resource group and workspace name
$resourceGroupName = "<Your ResourceGroup Name>"
$workspaceName = "<Your Workspace Name>"

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Close the selected incidents
foreach ($incident in $incidents) {
    $incidentID = $incident.Name

    # Close the incident with specific classification, status, and title
    Update-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName -IncidentID $incidentID -Classification Undetermined -Status 'Closed' -Title "Closed by Script"

    Write-Host "Closed incident $incidentID created on $($incident.CreatedTimeUtc)"
}
```

# Playbook to trigger playbook running powershell scripts
### 1. Create a logic app (playbook) and enable managed identity following the doc [Enable system-assigned identity in Azure portal](https://learn.microsoft.com/en-us/azure/logic-apps/create-managed-service-identity?tabs=consumption#enable-system-assigned-identity-in-azure-portal) according to the type of the logic app

### 2. Search for `http` and select `request`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1d3e279c-793e-486d-a11b-6312ad44cf58) 

### 3. Select `When a HTTP request is received`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dac93013-67a8-4cbb-84b8-8538f96a12ea)

### 4. Click save and this url would be generated automatically, save the logic app
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


### 8. Configure powershell script, runbook in automation account

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/261ee288-7c25-4811-af59-cfc4d2817f87)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/4cd3097f-3638-4626-9b9e-1e8d19e7e634)

### Then paste the powershell script below:
#### Define the time range
```powershell
Connect-AzAccount -Identity 

Set-AzContext -Subscription <sub id>

# Define the start date (January 1, 2023)
$startDate = Get-Date -Year 2023 -Month 3 -Day 1

# Define the end date (May 1, 2023)
$endDate = Get-Date -Year 2023 -Month 3 -Day 15

# Define the Azure resource group and workspace name
$resourceGroupName = "<resource group name>"
$workspaceName = "<workspace name>"

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Close incidents with specific classification, status, and title
foreach ($incident in $incidents) {
    $incidentID = $incident.Name
    $title = "<Your Title Here>"  # Replace with the desired title
    $severity = "Informational"  # Set the desired severity level
    
    # Close the incident with specific classification, status, severity, and title
    Update-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName -IncidentID $incidentID -Classification Undetermined -Status 'Closed' -Severity $severity -Title $title

    Write-Host "Executed command to close incident $incidentID with Classification 'Undetermined', Status 'Closed', Severity '$severity', and Title '$title'"
}
```

#### Or you can delete the incidents generated xxx days ago
```powershell
Connect-AzAccount -Identity 

Set-AzContext -Subscription <your Subscription id>

# Calculate the date 10 days ago
$endDate = Get-Date
$startDate = $endDate.AddDays(-10)

# Define the Azure resource group and workspace name
$resourceGroupName = "<Your ResourceGroup Name>"
$workspaceName = "<Your Workspace Name>"

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Close the selected incidents
foreach ($incident in $incidents) {
    $incidentID = $incident.Name

    # Close the incident with specific classification, status, and title
    Update-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName -IncidentID $incidentID -Classification Undetermined -Status 'Closed' -Title "Closed by Script"

    Write-Host "Closed incident $incidentID created on $($incident.CreatedTimeUtc)"
}
```

### Sample 
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1c906781-74ba-4485-9569-b1ce8843c5a9)


### 9. Configure workflow in logic app

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/12a9efeb-7d5a-41e9-9423-62c48e120611)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1531b4d0-2af1-4fac-a2a8-c5d271d9121f)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/3ac174a4-bfda-4193-84cc-c5c4f27a3792)

You can also set Recurrence in logic app so that you can close the old incidents regularly <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/35984e39-99ee-43c8-812a-fd2a37f1cf4c)
