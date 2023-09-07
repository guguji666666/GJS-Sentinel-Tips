# UEBA in Sentinel

## Solution installed on the workspace after enabling UEBA
<img width="1010" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0e3f89ec-f0a0-4bb4-bf09-88f85ebdfca6">

## Manually install the solution if it is missing

The user should have the write permission on the workspace level

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
