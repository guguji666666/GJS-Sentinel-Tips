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




Replace the GUID in $MI_ID = "XXXXXXXXXXX" with the GUID of your Managed Identity.


