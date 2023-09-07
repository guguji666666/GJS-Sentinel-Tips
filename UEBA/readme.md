# UEBA in Sentinel

## Solution installed on the workspace after enabling UEBA
<img width="1010" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0e3f89ec-f0a0-4bb4-bf09-88f85ebdfca6">

## Manually install the solution if it is missing

The user should have the write permission on the workspace level

### 1. Get postman and user token
##### 1. Download postman from [Download Postman](https://www.postman.com/downloads/) and launch it.
##### 2. [Get user token](https://github.com/guguji666666/GJS-MDC-Tips/tree/main/API%20Basic)
##### 3. Insert the user token here in postman
![image](https://user-images.githubusercontent.com/96930989/210289242-15003c92-1406-4289-9cfd-a08e5cd7260f.png)
##### 4. Set the `request URL`, `Body` (below is sample)
![image](https://user-images.githubusercontent.com/96930989/210707768-4979d7d8-4a3e-4b8d-821e-3234f2704be5.png)

### Binding : PUT
### URL
```
https://management.azure.com:443/subscriptions/{SUBSCRIPTION_ID}/resourceGroups/{RESOURCE_GROUP}/providers/Microsoft.OperationsManagement/solutions/BehaviorAnalyticsInsights({WORKSPACE_NAME})?api-version=2015-11-01-preview 
```
### Body
```
{"location": "uksouth",
"properties": {
"workspaceResourceId": "/subscriptions/{SUBSCRIPTION}/resourceGroups/{RESOURCE_GROUP}/providers/microsoft.operationalinsights/workspaces/{WORKSPACE_NAME}"
  },
  "plan": {
    "name": "BehaviorAnalyticsInsights(WORKSPACE_NAME)",
    "publisher": "Microsoft",
    "product": "OMSGallery/BehaviorAnalyticsInsights",
    "promotionCode": ""
  }
}
```

Before we install the solution <br>
<img width="838" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/76fdf870-7a8d-46e2-b0dc-c915eb215c0f">

After we manually install the solution <br>
