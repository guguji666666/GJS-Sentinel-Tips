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

