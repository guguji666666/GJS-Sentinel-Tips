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




iv. Create a new PowerShell Runbook.

v. Register the Hybrid Worker with Azure

vi. Test the Runbook.

vii. Deploy/build the Playbook.

viii. Attach the Playbook to the relevant Analytics rule in Azure Sentinel.
