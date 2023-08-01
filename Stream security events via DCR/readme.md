## Stream security events to workspaces using DCR 

### 1. Create data collection rule to collect security events in sentinel portal
[Windows Security Events via AMA connector for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors/windows-security-events-via-ama)

Deploy the solutions from Sentinel > Content hub to enable data connectors <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e58dcfba-49b9-4f76-bf8c-a87b6d04677d)

Find the data connector here <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5d84d0a2-f00a-433b-9f9f-9873c60a5929)

Create the data collection rule to stream security events <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ca9128cb-80b4-47a8-bafd-bb86c6b45938)

Add the resources that you want to assign the DCR <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/cbd38b1b-f4a1-42a6-8b26-de5dc5006515)

Define the level of the events you want to collect <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c10902a2-4900-4670-b19a-742eb33d442a)

Review the configuration and confirm creation <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ca064f89-c8b3-418a-841b-e18ca1739d89)

### 2. Get the resource id of the DCR you created, this will be used later <br>

Navigate to Monitor > Data Collection rules <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d223185c-2d91-4a1c-811c-aedad79f9fbd)

You can find the resource id of the DCR here <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/20c1f6e3-60b2-4a4e-8a2e-d11a78d269a6) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/eb9d4141-6f51-456c-b8bf-29c54004f78b)

### 3. Assign the DCR via Azure policy so that all selected VMs will be associated with this DCR to stream securit

Navigate to Policy > Definitions, find the initiatives here <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/88dd8ddb-f7b5-4369-9cf9-979519498635)

In this scenario, we want to stream windows security events to the workspace <br>
Review the policies included in the initiative, it also covers Azure Arc machines <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/8c7f5802-1cb4-4552-b5b8-d02bfa6dabbe)

Assign the initiative to the subscription level <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a0e251ed-fd13-41ba-a2ac-8325a8b31b10) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2e83c57c-eda7-410c-aac1-b1d378a6edfc) <br>
Uncheck the box here and paste the resource id of the DCR found in the previous steps <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/65eb9b3c-8ec2-4d45-bd9d-9118cc6c6596) <br>
Create remediation task here so that existing VMs will also be associated to this DCR <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/48ec6d21-c641-450b-9fc4-0cb2abe43c9c)

Review the configuration and confirm creation <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/6efa72f9-2bff-425c-88e7-7432dd2b0b28)

Then you can monitor to see if the VMs are associated to the DCR you want <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/84f4786c-f206-4d4d-9c79-e1412d124035)


                                                                                                                   
                                                                                               
