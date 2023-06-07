## Use Sentinel with Azure lighthouse

### [Manage Microsoft Sentinel workspaces at scale](https://learn.microsoft.com/en-us/azure/lighthouse/how-to/manage-sentinel-workspaces)
### [Manage multiple tenants in Microsoft Sentinel as an MSSP](https://learn.microsoft.com/en-us/azure/sentinel/multiple-tenants-service-providers)
### [Azure Lighthouse - Step by step guidance - Onboard customer to Lighthouse using sample template](https://techcommunity.microsoft.com/t5/azure-paas-blog/azure-lighthouse-step-by-step-guidance-onboard-customer-to/ba-p/1793055)

## Start deployment
Suppose the central tenant is `tenant A` (where you want to manage the Sentinel contents <br>
Now you want to add the cx's tenant `tenant B` <br>
Your account has the `contributor role` on the subscription where sentinel is enabled in tenant A <br>
Your account is invited to tenant B and has the `contributor role` on the subscription you want to mananged in tenant B <br>

### 1. Get the `tenant id` of tenant B
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d8c65642-3d3a-4fbc-8f2f-9a0982b02940)

### 2. Get the `object id` of the account in tenant B
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0409b2a0-1fd7-45de-9d96-4fd987439dc2)

### 3. Get the role id of RBAC role assigned to your account in subscription in tenant B
We can refer to the doc [Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) <br>
In this sample, the RBAC role assigned is contributor, so the role id would be `Azure built-in roles` <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e093901d-5cbf-4f0a-a8e3-142aa173ec45)

### 4. Use your account and switch to the directory (cx's tenant) 


###.Select the ARM template for deployment[Onboard Microsoft Azure Lighthouse](https://github.com/Azure/Azure-Lighthouse-samples#deploy-to-azure-buttons)
