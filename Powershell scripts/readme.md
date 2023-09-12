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
### 1. Search for `http` and select `request`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1d3e279c-793e-486d-a11b-6312ad44cf58) 
### 2. Select `When a HTTP request is received`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dac93013-67a8-4cbb-84b8-8538f96a12ea)
