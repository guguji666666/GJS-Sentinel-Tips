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
