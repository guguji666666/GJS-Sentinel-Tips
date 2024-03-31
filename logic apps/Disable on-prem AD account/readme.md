# Disable on-prem AD account

As we know, we can ingest securityevents from windows machines with MMA or AMA installed. With the data ingested we can create analytics rules to fire relating alerts/incidents in sentinel. What if we want to disable AD account when the specified scenario is detected? For example, someone tried to RDP to the machine but failed 10 times in 5 mintutes. We want to block the account used for RDP.

Actaully the doc [Automatically disable On-prem AD User using a Playbook triggered in Azure - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/automatically-disable-on-prem-ad-user-using-a-playbook-triggered/ba-p/2098272), but some steps are different during the deployment. This doc will list the steps with details.


Many organizations have an on-premises Active Directory infrastructure that is synced to Azure AD in the cloud. However, given that the on-prem side is the authoritative source of truth, any changes, such as disabling a user in the cloud (Azure AD), are overridden by the setting defined in the on-prem AD during the next sync. This presents challenges when you want to orchestrate a user property change from Azure that needs to persist even after the sync happens.  To address the problem, this solution leverages the Automation Accounts and Hybrid Worker features across on-prem Windows resources & Azure . Automation Accounts can be used to perform cloud-based automation across Azure and non-Azure environments, including on Linux and Windows servers sitting in AWS, and GCP clouds so long as those machines have the Log Analytics agent installed.


## Solution Overview

A typical use-case for this solution would flow as below:

i. Existing Microsoft Sentinel Analytics rule generates an incident requiring a user to be blocked from further domain access.

ii. The incident has the playbook attached to kick off the actions needed to block user access both on the cloud and on on-prem AD 

iii. The playbook includes the "create hybrid automation job" action, which executes a PowerShell script against the on-prem DC to block the user. 

iv. User blocked in iii. above remains blocked even after subsequent `Azure AD connect` syncs with Azure cloud.


## Deployment Steps 

Before you begin to review the pre-requisites of deploying a Hybrid Runbook Worker here: Deploy a Windows Hybrid Runbook Worker in Azure Automation | Microsoft Docs

i. Create Automation Account

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/15b62a40-fe22-48de-9386-adddb44adfa8)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/7a71ea31-11fc-47ff-9771-0dbe105cc406)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2b68cf1f-1f1e-4b4c-b3a2-9323989459a1)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a895d981-a920-4b3e-ae08-0ecd5c3551d2)


ii. Deploy the Automation Hybrid Worker solution from the Azure Market place

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/cdb8e973-b891-4dd4-a2e5-a42666d4bb78)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0b650527-7350-4c00-94aa-7aa0a16f6e26)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/28a49c62-17be-49a8-acd6-1098494a666c)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/6d81c4b5-cc6e-4cfc-842d-9944a4bfd6c1)


iii. Create a Hybrid Worker Group

Navigate to the automation account we just created, select `Hybrid worker groups` <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/bcc06d0d-854f-416c-bea4-00d6b46a8912)

Name it with domain name so that we can recognize easily <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/fab1bc98-f8e3-4a4e-a665-949cf661f958)

Leave it, we will add the worker later <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/333016c4-f688-4c0f-a21d-8bfefff687d1)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5b2cb77e-f620-499d-aabe-fe29a7858a3d)


iv. Create a new PowerShell Runbook.

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/4488923e-5174-4494-94d2-3c4fbe31f198)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c8307427-74c5-4bd7-900a-279b867e6d7a)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0ca1c073-75e4-4731-ad01-30d4fa4720a3)

Edit powershell runbook, paste the script below and save <br>
```powershell
Param (

[string] $SAMAccountName

)

if (Get-Module -ListAvailable -Name ActiveDirectory) {
    Write-Output "ActiveDirectory PowerShell module already exists on host."
} 
else {
    Write-Output "ActiveDirectory PowerShell module does not exist on host. Installing..."
    try {
        Import-Module ActiveDirectory
    }
    catch{
        Write-Error "Error installing ActiveDirectory PowerShell module."
        throw $_
        break
    }

    Write-Output "ActiveDirectory PowerShell module installed."
}

Write-Output "Finding and disabling user $SAMAccountName"
try {
    Get-ADUser -Identity $SAMAccountName | Disable-ADAccount
}
catch {
    Write-Error "Error disabling user account $SAMAccountName"
    throw $_
    break
}
Write-Output "Successfully disabled user account $SAMAccountName"
```

The script takes in a **SAMAccountName** parameter which it uses to find the appropriate user and disable the account. This script can be modified to do various other tasks, such as password resets, adding/removing users to/from groups, etc.

v. Register the Hybrid Worker with Azure

Connect the domain controller in your on-prem AD to Azure Arc via the steps in [Connect hybrid machines to Azure using a deployment script](https://learn.microsoft.com/en-us/azure/azure-arc/servers/onboard-portal#generate-the-installation-script-from-the-azure-portal)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ab36e054-a7a3-490e-8c13-2eaf6af0b7c7)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dfa83de8-feb7-4064-8cd8-9af494ce41e4)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/920ac605-5298-44a7-962d-9be7be88d16d)

Run the powershell script you get in this page on the on-prem machine <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/9431cea3-9023-4d0a-a951-528b3d9265dd)

Wait for 15 mins, the on-prem machine should then be found in Azure Arc <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c290c842-3e86-4cf5-a713-53bc72965488)


Then go back to automation account, click the hybrid worker group you just created <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/cc0666b5-019f-4d90-9ca5-8d74add1c6a4)

Click the `Add` button <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1dbcad76-eacf-4212-8f78-e37202fd40e0)

Search for the domain controller you just onboard to Azure Arc <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c20034b5-f7a9-41d0-bdc5-8a6aef8ff5d4)

Wait for the process completes <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/fd4da2e0-f4cc-4e7f-aa16-2581c2c9bbc9)


vi. Test the Runbook.

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/66fd74bc-5e93-43c5-a291-5befff25832e)

Click `Start` button <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/06348909-1ad4-41c8-a4b0-00e7c6ba6b38)

* For **SAMAccountName**, just input accountname. For example if the account is `Zero\testing`, then just input `testing` here.
* For **Run Settings**, select the group where the domain controller locates.

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/cac7f561-9dff-47b9-b711-34a9ba5ea9e6)

Then start the job, wait for 1-2 mins.The logs will show the results <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/8ed503a1-3365-47c8-ac5c-37db93fa8854)

You can also verify if the AD Account is disabled indeed on the domain controller. Just run the powershell scripts below on the domain controller.
```powershell
# Get user accounts in the domain whose UPN contains "<account name>"
$users = Get-ADUser -Filter {UserPrincipalName -like "*test*"} -Properties SamAccountName, UserPrincipalName, Enabled

# Create a custom object for each user with required properties
$userList = foreach ($user in $users) {
    [PSCustomObject]@{
        "Account Name (SAM)" = $user.SamAccountName
        "Account UPN" = $user.UserPrincipalName
        "Status" = if ($user.Enabled) { "Enabled" } else { "Disabled" }
    }
}

# Display results in a table
$userList | Format-Table -AutoSize
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/398c961a-b10a-43d6-a397-4e485540d6f3)

vii. Deploy/build the Playbook.

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/af9a4fc1-eb12-44fd-bf98-cb52da1e2c93)




viii. Attach the Playbook to the relevant Analytics rule in Azure Sentinel.

Create analytics rule in sentinel <br>




