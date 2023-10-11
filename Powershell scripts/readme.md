# Useful powershell scripts
* [Sentinel API](https://learn.microsoft.com/en-us/rest/api/securityinsights/)
* [Az.SecurityInsights powershell module](https://learn.microsoft.com/en-us/powershell/module/az.securityinsights/?view=azps-10.4.1&viewFallbackFrom=azps-6.0.0#security)
* [az sentinel](https://learn.microsoft.com/en-us/cli/azure/sentinel?view=azure-cli-latest)

## 1. Get sentinel incidents created in specified time range
```powershell
# Define your Azure resource group, workspace, subscription, and tenant names or IDs
$resourceGroupName = "YourResourceGroupName"
$workspaceName = "YourWorkspaceName"
$subscriptionId = "YourSubscriptionId"
$tenantId = "YourTenantId"

# Define the start date (you can custom it)
$startDate = Get-Date -Year 2023 -Month 3 -Day 1
# Define the end date (you can custom it)
$endDate = Get-Date -Year 2023 -Month 3 -Day 15

# Authenticate to Azure using the specified tenant, subscription, and account
Connect-AzAccount -Tenant $tenantId -Subscription $subscriptionId

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Print incidents
$incidents | fl
```

## 2. Count sentinel incidents created in specified time range
```powershell
# Define your Azure resource group, workspace, subscription, and tenant names or IDs
$resourceGroupName = "YourResourceGroupName"
$workspaceName = "YourWorkspaceName"
$subscriptionId = "YourSubscriptionId"
$tenantId = "YourTenantId"

# Define the start date (you can custom it)
$startDate = Get-Date -Year 2023 -Month 3 -Day 1
# Define the end date (you can custom it)
$endDate = Get-Date -Year 2023 -Month 3 -Day 15

# Authenticate to Azure using the specified tenant, subscription, and account
Connect-AzAccount -Tenant $tenantId -Subscription $subscriptionId

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Count the number of incidents
$incidentCount = $incidents.Count

# Display the count of retrieved incidents
Write-Host "Total incidents within the specified time range: $incidentCount"

```

## 3. Bulk `close` sentinel incidents created in specified time range
```powershell
# Define your Azure resource group, workspace, subscription, and tenant names or IDs
$resourceGroupName = "YourResourceGroupName"
$workspaceName = "YourWorkspaceName"
$subscriptionId = "YourSubscriptionId"
$tenantId = "YourTenantId"

# Define the start date (you can custom it)
$startDate = Get-Date -Year 2023 -Month 3 -Day 1
# Define the end date (you can custom it)
$endDate = Get-Date -Year 2023 -Month 3 -Day 15

# Authenticate to Azure using the specified tenant, subscription, and account
Connect-AzAccount -Tenant $tenantId -Subscription $subscriptionId

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

## 4. Bulk `delete` sentinel incidents created in specified time range
```powershell
# Define your Azure resource group, workspace, subscription, and tenant names or IDs
$resourceGroupName = "YourResourceGroupName"
$workspaceName = "YourWorkspaceName"
$subscriptionId = "YourSubscriptionId"
$tenantId = "YourTenantId"

# Define the start date (you can custom it)
$startDate = Get-Date -Year 2023 -Month 3 -Day 1
# Define the end date (you can custom it)
$endDate = Get-Date -Year 2023 -Month 3 -Day 15

# Authenticate to Azure using the specified tenant, subscription, and account
Connect-AzAccount -Tenant $tenantId -Subscription $subscriptionId

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Delete incidents
foreach ($incident in $incidents) {
    $incidentID = $incident.Name

    Remove-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName -IncidentID $incidentID

    Write-Host "Executed command to remove incident $incidentID"
}
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/71727ee3-8657-45cd-b7cd-78a40925ec6f)

# Playbook to trigger runbook(Automation account) running powershell scripts
### 1. Create a logic app (playbook) and enable managed identity following the doc [Enable system-assigned identity in Azure portal](https://learn.microsoft.com/en-us/azure/logic-apps/create-managed-service-identity?tabs=consumption#enable-system-assigned-identity-in-azure-portal) according to the type of the logic app

### 2. Search for `http` and select `request`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1d3e279c-793e-486d-a11b-6312ad44cf58) 

### 3. Select `When a HTTP request is received`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dac93013-67a8-4cbb-84b8-8538f96a12ea)

### 4. Click save and this url would be generated automatically, save the logic app
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/59d71480-0f7b-4eab-a025-a488b481c541) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e095cbb0-ad1c-40f2-a87b-2e68c8f4fbeb) <br>

### 5. Create an automation account following the doc [Quickstart: Create an Automation account using the Azure portal](https://learn.microsoft.com/en-us/azure/automation/quickstarts/create-azure-automation-account-portal)

#### Update modules `Az.Accounts` and `Az.SecurityInsights` 

<img width="1787" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5db854ca-0656-4b25-b5c1-cf5add5a6f04">

<img width="756" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/4233d73b-8a3b-4e2b-a712-f83cdd0ba370">

<img width="1543" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/29a9ee86-38f4-490a-8b56-3d36c20a5431">

<img width="1785" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2202c9c3-1ade-4c6a-8996-4783c20120af">

<img width="753" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e52ccb22-828b-443e-bcd1-90dadb338258">

<img width="782" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/67397ae9-4190-4788-bdc2-4d3926417668">

It may take some time to complete the updates.

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
# Define your Azure resource group, workspace, subscription, and tenant names or IDs
$resourceGroupName = "YourResourceGroupName"
$workspaceName = "YourWorkspaceName"
$subscriptionId = "YourSubscriptionId"
$tenantId = "YourTenantId"

# Authenticate to Azure using the specified tenant, subscription, and account
Connect-AzAccount -Identity 
Set-AzContext -Subscription $subscriptionId


# Define the start date (you can custom it)
$startDate = Get-Date -Date "2023-03-01T00:00:00"
# Define the end date (you can custom it)
$endDate = Get-Date -Date "2023-03-15T00:00:00"


# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDate -and $_.CreatedTimeUtc -lt $endDate
}

# Close incidents with specific classification, status, and title
foreach ($incident in $incidents) {
    $incidentID = $incident.Name
    $title = "Close-By-Automation"  # Replace with the desired title
    $severity = "Informational"  # Set the desired severity level
    
    # Close the incident with specific classification, status, severity, and title
    Update-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName -IncidentID $incidentID -Classification Undetermined -Status 'Closed' -Severity $severity -Title $title

    Write-Host "Executed command to close incident $incidentID with Classification 'Undetermined', Status 'Closed', Severity '$severity', and Title '$title'"
}
```

#### Or you can delete the incidents generated xxx days ago
```powershell
# Define your Azure resource group, workspace, subscription, and tenant names or IDs
$resourceGroupName = "YourResourceGroupName"
$workspaceName = "YourWorkspaceName"
$subscriptionId = "YourSubscriptionId"
$tenantId = "YourTenantId"

# Authenticate to Azure using the specified tenant, subscription, and account
Connect-AzAccount -Identity 
Set-AzContext -Subscription $subscriptionId

# Calculate the start date (10 days ago) and end date (current time)
$endDate = Get-Date
$startDate = $endDate.AddDays(-10)

# Format the dates in the desired format
$startDateFormatted = $startDate.ToString("yyyy-MM-ddTHH:mm:ss")
$endDateFormatted = $endDate.ToString("yyyy-MM-ddTHH:mm:ss")

# Get incidents within the specified date range
$incidents = Get-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName | Where-Object {
    $_.CreatedTimeUtc -ge $startDateFormatted -and $_.CreatedTimeUtc -lt $endDateFormatted
}

# Close incidents with specific classification, status, and title
foreach ($incident in $incidents) {
    $incidentID = $incident.Name
    $title = "Close-By-Automation"  # Replace with the desired title
    $severity = "Informational"  # Set the desired severity level
    
    # Close the incident with specific classification, status, severity, and title
    Update-AzSentinelIncident -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName -IncidentID $incidentID -Classification Undetermined -Status 'Closed' -Severity $severity -Title $title

    Write-Host "Executed command to close incident $incidentID with Classification 'Undetermined', Status 'Closed', Severity '$severity', and Title '$title'"
}
```

#### Once the powershell script is set, click `save` and `publish`
<img width="1768" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0447ab10-d40c-426f-a286-e942601dc195">


### 9. Configure workflow in logic app

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/12a9efeb-7d5a-41e9-9423-62c48e120611)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1531b4d0-2af1-4fac-a2a8-c5d271d9121f)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/3ac174a4-bfda-4193-84cc-c5c4f27a3792)

You can also set Recurrence in logic app so that you can close the old incidents regularly <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/35984e39-99ee-43c8-812a-fd2a37f1cf4c)

# Bulk delete IOC (Authenticate with service principal)
### 1. App registration
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a446cd46-dacb-41b3-a219-4cc22e32cd1e) 

Fill in the required fields and register the App <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a8b03187-0482-46e1-870c-22467ebd525e)

Create the secret and copy the value to notepad, we need it later <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b086d558-595d-4766-a95a-1ffa72f6d28b)

Copy the Client id and tenant id to notepad, we need it later <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/940cbae4-73df-4cf7-8517-14cf005008d6)

### 2. Assign API permissions to this app
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/18f1594b-9845-4992-9667-ac8c98725314)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1d59d824-8f43-44c0-9625-5f5348a0f8da)

Confirm the assignment <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e9cac915-3bcc-4749-af9b-4069847e9414)

### 3. Assign `Sentinel contributor role` to this app
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1288be4b-9f32-44be-bbf0-4f8d81899bf1)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dcbd6761-c9c5-4b44-af91-896f8d406080)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/7e2382f3-bcb3-4ba2-b6ff-28ed812881d4)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c42c5f7c-2ad2-4ad5-bd5a-3408c3115bf0)

Confirm the assignment <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/556dbba1-f144-4c67-917b-57c893303080)

Confirm that the assignment succeeds <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a8a2a384-6322-4dbd-8d1c-1af87c60f2fe)


### 4. Run the script to remove existing threat indicators

Still under testing ....
```powershell
$applicationid = "<client id>"
$clientSecret = "<client secret>"
$tenantId = "<tenant id>"
$subscription = "<subscription id>"
$resourcegroup = "<resource group name>"
$workspacename = "<workspace name>"

# Function to get a valid access token
function Get-AzureAccessToken($clientId, $clientSecret, $tenantId) {
    $tokenUrl = "https://login.microsoftonline.com/$tenantId/oauth2/token"
    $tokenParams = @{
        "grant_type"    = "client_credentials"
        "client_id"     = $clientId
        "client_secret" = $clientSecret
        "resource"      = "https://management.azure.com/"
    }

    $tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method Post -ContentType "application/x-www-form-urlencoded" -Body $tokenParams

    return $tokenResponse.access_token
}

do {
    # Get a valid access token
    $rawtoken = Get-AzureAccessToken -clientId $applicationid -clientSecret $clientSecret -tenantId $tenantId

    # Check if the access token is empty or null
    if ([string]::IsNullOrWhiteSpace($rawtoken)) {
        Write-Host "Failed to obtain a valid access token. Script will exit."
        break
    }

    # set request headers
    $requestheader = @{
        "Authorization" = "Bearer $rawtoken"
        "Content-Type" = "application/json"
    }

    # set query api endpoint and get list of indicators
    $uri = "https://management.azure.com/subscriptions/$subscription/resourcegroups/$resourcegroup/providers/microsoft.operationalinsights/workspaces/$workspacename/providers/microsoft.securityinsights/threatintelligence/main/queryindicators?api-version=2023-02-01"
    $requestbody = @{
        "pagesize" = "1000"
        "minconfidence" = "0"
        "maxconfidence" = "100"
    }

    # loop through each batch of 1000 indicators and delete them
    $skip = 0

    do {
        Write-Host "Querying the security API to get the list of indicators..."
        $requestbody.skip = $skip
        $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $requestheader -Body ($requestbody | ConvertTo-Json)

        if ($response -and $response.value -is [array]) {
            $indicators = $response.value

            Write-Host "Starting to delete indicators in this batch..."
            $totalIndicators = $indicators.Count
            $indicatorsDeleted = 0

            foreach ($indicator in $indicators) {
                $name = $indicator.name
                Write-Host "Deleting indicator $name..."
                $deleteuri = "https://management.azure.com/subscriptions/$subscription/resourcegroups/$resourcegroup/providers/microsoft.operationalinsights/workspaces/$workspacename/providers/microsoft.securityinsights/threatintelligence/main/indicators/$name/?api-version=2023-03-01-preview"
                Invoke-RestMethod -Uri $deleteuri -Method Delete -Headers $requestheader
                $indicatorsDeleted++
                $percentage = ($indicatorsDeleted / $totalIndicators) * 100
                Write-Progress -Activity "Deleting Indicators..." -PercentComplete $percentage
            }

            Write-Host "Finished deleting indicators in this batch."
        }

        # delay for 10 seconds before running the script again
        Start-Sleep -Seconds 10

        # move on to the next batch of indicators
        $skip += 1000
    } while ($indicators.Count -eq $requestbody.pagesize)

    # script execution complete
    Write-Host "Script execution complete."

} while ($true)
```

Working one
```powershell
$applicationid = "<App id>"
$key = ConvertTo-SecureString -String "<client secret>" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($applicationid, $key)
Connect-AzAccount -Credential $Credential -Tenant "<tenant id>" -ServicePrincipal
do {
    # set request headers
    $requestheader = @{
        "authorization" = "bearer " + $rawtoken
        "content-type" = "application/json"
    }
 
    # set resource group and workspace name
    $subscription = "<subscription id>"
    $resourcegroup = "<resource group name>"
    $workspacename = "<workspace name>"
 
    # set query api endpoint and get list of indicators
    $uri = "https://management.azure.com/subscriptions/$subscription/resourcegroups/$resourcegroup/providers/microsoft.operationalinsights/workspaces/$workspacename/providers/microsoft.securityinsights/threatintelligence/main/queryindicators?api-version=2023-02-01"
    $requestbody = @{
        "pagesize" = "300"
        "minconfidence" = "0"
        "maxconfidence" = "100"
    }
 
    # loop through each batch of 1000 indicators and delete them
    $skip = 0
 
    do {
        #get and refresh access token
        Write-Host "getting azure access token..."
        $accesstoken = get-azaccesstoken 
        $rawtoken = $accesstoken.token
        echo $rawtoken
        Write-Host "querying the security api to get the list of indicators..."
        $requestbody.skip = $skip
        $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $requestheader -Body ($requestbody | ConvertTo-Json)
        $indicator = $response.value.name
 
        # check if there are any indicators to delete
        if ($indicator) {
            Write-Host "Starting to delete indicators in this batch..."
            $totalIndicators = $indicator.Count
            $indicatorsDeleted = 0
 
            # delete each indicator in this batch
            foreach ($name in $indicator) {
                Write-Host "deleting indicator $name ..."
                $deleteuri = "https://management.azure.com/subscriptions/$subscription/resourcegroups/$resourcegroup/providers/microsoft.operationalinsights/workspaces/$workspacename/providers/microsoft.securityinsights/threatintelligence/main/indicators/$name/?api-version=2023-03-01-preview"
                Invoke-RestMethod -uri $deleteuri -method delete -headers $requestheader
 
                $indicatorsDeleted++
                $percentage = ($indicatorsDeleted / $totalIndicators) * 100
                Write-Progress -Activity "Deleting Indicators..." -PercentComplete $percentage
            }
 
            Write-Host "Finished deleting indicators in this batch."
        }
        # delay for 10 seconds before running the script again
        Start-Sleep -Seconds 10
        # refresh token
        Disconnect-AzAccount
       $applicationid = "<App id>"
       $key = ConvertTo-SecureString -String "<client secret>" -AsPlainText -Force
       $Credential = New-Object System.Management.Automation.PSCredential($applicationid, $key)
        Connect-AzAccount -Credential $Credential -Tenant "<tenant id>" -ServicePrincipal
        # move on to the next batch of indicators
        $skip += 300
    } while ($indicator.length -eq $requestbody.pagesize)
 
    # script execution complete
    Write-Host "script execution complete."
    
} while ($true)
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b920b443-14cc-4aaa-a091-77b954a61e38)

