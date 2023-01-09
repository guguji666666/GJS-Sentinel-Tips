## Connect Intune to Sentinel

#### 1. Navigate to [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/) 

#### 2. Navigate to `Reports` menu, then `Diagnostic Settings`.
![image](https://user-images.githubusercontent.com/96930989/211248117-7b55378d-b785-4a01-945f-2aa572199832.png)

#### 3. Create a new Diagnostic Setting similar to the picture below,ensure that your `own Subscription` and `Log Analytics Workspace` (where Azure Sentinel enbaled) is selected
![image](https://user-images.githubusercontent.com/96930989/211248229-190cce7d-5c3c-4feb-a94d-3f5f78760010.png)

#### 4. Once the Diagnostic Setting is created, saved, and enabled, as long as there is activity being recorded in the Intune tenant, the new data will be stored in the tables below

`Tables` to store Intune logs:
```
IntuneAuditLogs
IntuneDeviceComplianceOrg
IntuneOperationalLogs
IntuneDevices 
```
#### 5. Query in the workspace
IntuneOperationalLogs

![image](https://user-images.githubusercontent.com/96930989/211248752-bc756c0c-f673-4d59-9291-3313e5794f9c.png)

IntuneDevices (updated every 24 hours)


#### 6. [Useful Intune-specific Workbooks](https://github.com/rod-trent/SentinelWorkbooks)
