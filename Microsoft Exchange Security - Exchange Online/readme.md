## Microsoft Exchange Security - Exchange Online

### 1. Install the soluton `Microsoft Exchange Security for Exchange Online`  from content hub in sentinel
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b77641c7-0123-4caf-aa9b-c19f5434b87b)

In this solution we can see the data connector `Exchange Security Insights Online Collector (using Azure Functions)` 

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/6fc388d5-da9e-44f3-af98-12359ce834d9)


### 2, Configure the data connector `Exchange Security Insights Online Collector (using Azure Functions)` 

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/be040010-2a75-4d9b-bd97-1d787a086943)


#### STEP 1 - Parsers deployment

Parser deployment (When using Microsoft Exchange Security Solution, Parsers are automatically deployed). We can verify it

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/8ffebbd7-3298-4750-974e-254d669be73d)


#### STEP 2 - Choose ONE from the following two deployment options to deploy the connector and the associated Azure Automation

We recommend to use ARM template for deployment <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/327adb39-b05c-4414-8fc6-6b31f0c29446)


Sample <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a1b71779-1769-4f01-8bba-55294dd6f3e7)


Azure AD tenant name could be found here <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/44612575-663f-4c60-bf2b-1516a67dc436)


The resources below would be deployed <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/9406eb9f-e0f8-492e-89ff-c71ad69471e0)


#### STEP 3 - Assign Microsoft Graph Permission and Exchange Online Permission to Managed Identity Account

##### A. Download powershell script from [ExchangeOnlinePermSetup.ps1](https://github.com/nlepagnez/ESI-PublicContent/blob/main/Solutions/ESICollector/OnlineDeployment/ExchangeOnlinePermSetup.ps1)

##### B. Retrieve the Azure Automation Managed Identity GUID and insert it in the downloaded script

Go to your Automation Account, in the Identity Section. You can find the Guid of your Managed Identity. <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1f362780-7a23-4c02-917f-141518a5022a)


Go the script we just downloaded, replace the GUID in `$MI_ID = "XXXXXXXXXXX"` with the GUID of your Managed Identity. Save it. <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5df98958-7ea9-460f-ac49-1b6293d37e83)


##### C. Launch the script `ExchangeOnlinePermSetup.ps1` with a **Global-Administrator** account

Attention this script requires MSGraph Modules and Admin Consent to access to your tenant with Microsoft Graph.

The script will add 3 permissions to the Managed identity:
* Exchange Online ManageAsApp permission
* User.Read.All on Microsoft Graph API
* Group.Read.All on Microsoft Graph API

```powershell

## Enable TLS 1.2 in powershell session
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


## Install powershell module required
Install-Module Microsoft.Graph


## Connect to get token
Connect-MgGraph -TenantId <your tenant id>
```

Then
```powershell
cd <path you save ExchangeOnlinePermSetup.ps1 with managed identity id filled>

.\ExchangeOnlinePermSetup.ps1
```

Wait until script completes <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/278bbcce-b3d1-491a-a713-25b0b5005ba6)


To verify the permissions assigned to the automation account, we can follow the steps below <br>

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c7bf6dd7-695b-4c2b-b2e6-2ae34cbba956)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/4cd33e7c-9749-4a34-8c9f-b6b753c1b0c6)


##### D. Exchange Online Role Assignment (Performed by global administrator)
1. As a Global Administrator, go to Roles and Administrators.
2. Select Global Readers role and click to 'Add assignments'.
3. Click on 'No member selected' and search your Managed Identity account Name beginning by the name of your automation account like 'ESI-Collector'. Select it and click on 'Select'.
4. Click Next and validate the assignment by clicking Assign.

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d0ba9f1f-1760-4385-a83d-9d6895fa7a04)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a493e688-6702-473f-a6aa-7ea0150be3ce)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/36851cb5-eb74-4e34-9439-03ba1d0b6d26)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/aab57d7b-111e-47ea-987f-a2f4a8801293)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b95e6cc5-779b-48c6-b6d0-52e9f8a7f460)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f30a535e-f5bb-4c31-a4d2-cdb7e954fee8)


### 3. Trigger runbook in Automation account to retrive logs and ingest into sentinel workspace

Search for `automation account` on the top <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d655cf63-3b80-427d-8c21-adfff2bf43ff)

You will find the new automation account we just created <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/036788a8-9f12-4749-9a68-11431f5c212a)

Find the runbook and click it <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b70de20b-c912-4b99-bd0c-fcda6a6984f3)

Start the job <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0408cc8d-0477-4cd6-90a9-e3b030398e0b)

It may take several minutes to finish, check if you get any error from the logs <br>

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/84b98d7d-ad1b-485a-8db3-8037c81e30d7)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/025b651b-a5a9-40e3-9d34-dc129c5bee30)


Wait for an hour and go back to data connector, you should 
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e27a41c0-8f01-496f-adeb-9f3aeaf71905)





