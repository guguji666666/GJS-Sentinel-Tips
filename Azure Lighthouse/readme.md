# Sentinel with Azure lighthouse

### [Manage Microsoft Sentinel workspaces at scale](https://learn.microsoft.com/en-us/azure/lighthouse/how-to/manage-sentinel-workspaces)
### [Manage multiple tenants in Microsoft Sentinel as an MSSP](https://learn.microsoft.com/en-us/azure/sentinel/multiple-tenants-service-providers)
### [Onboard a customer to Azure Lighthouse](https://learn.microsoft.com/en-us/azure/lighthouse/how-to/onboard-customer)
### [Azure Lighthouse - Step by step guidance - Onboard customer to Lighthouse using sample template](https://techcommunity.microsoft.com/t5/azure-paas-blog/azure-lighthouse-step-by-step-guidance-onboard-customer-to/ba-p/1793055)
### [Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
### [RBAC Role support for Azure Lighthouse](https://learn.microsoft.com/en-us/azure/lighthouse/concepts/tenants-users-roles#role-support-for-azure-lighthouse)

## Concepts

* Service Provider: the one to manage delegated resources. (the tenant where you want to manage the sentinel contents across tenants)

* Customer : the delegated resources (subscription and/or resources group) can be accessed and managed through service provider’s Azure Active Directory tenant. ( the tenants mananged by yourown tenant)

## Start deployment
Suppose the Service Provider is `tenant A` (where you want to manage the Sentinel contents) <br>
Now you want to onboard the customer's tenant `tenant B` <br>

### 1. Get the `tenant id` of tenant A (Service provider)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d8c65642-3d3a-4fbc-8f2f-9a0982b02940)

### 2. Get the `object id` of the user account in tenant A (Service provider)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0409b2a0-1fd7-45de-9d96-4fd987439dc2)

### 3. As a service provider, you may want to perform multiple tasks for a single customer, requiring different access for different scopes. You can define as many authorizations as you need in order to assign the appropriate role-based access control (RBAC) built-in roles to users in your tenant. 
We can refer to the doc [Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) and [Role support for Azure Lighthouse](https://learn.microsoft.com/en-us/azure/lighthouse/concepts/tenants-users-roles#role-support-for-azure-lighthouse) <br>
In this sample, since the owner role is not supported for lighthouse, we chose contributor, so the role id would be `b24988ac-6180-42a0-ab88-20f7382dd24c` <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2b84dd67-4280-455b-8972-ec9a5a26f566) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e093901d-5cbf-4f0a-a8e3-142aa173ec45)

### 4. Make sure that the resource providers below are registered in the subscription in tenant B (customer)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2679dff8-08dd-464e-8893-53b640cf8d45)

### 5. Customer should log in their own tenant using `non-guest` user with `owner` role on the subscription to be onboarded

### 6. Select the ARM template for deployment [Onboard Microsoft Azure Lighthouse](https://github.com/Azure/Azure-Lighthouse-samples#deploy-to-azure-buttons)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/21b3a2f1-8ac5-426f-bfb7-537ec04ec4a0) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1e20684d-df98-4c6a-ba31-98e4080cd900)

Replace the json file here with the template below <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/7f3ddd9b-1aa3-4b40-9782-115a97d4ef98)

ARM template used to onboard customer's `subscription`
```json
{
    "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "mspOfferName": {
            "type": "string",
            "metadata": {
                "description": "Specify a unique name for your offer"
            }
        },
        "mspOfferDescription": {
            "type": "string",
            "metadata": {
                "description": "Name of the Managed Service Provider offering"
            }
        },
        "managedByTenantId": {
            "type": "string",
            "metadata": {
                "description": "Specify the tenant id of the Managed Service Provider"
            }
        },
        "authorizations": {
            "type": "array",
            "metadata": {
                "description": "Specify an array of objects, containing tuples of Azure Active Directory principalId, a Azure roleDefinitionId, and an optional principalIdDisplayName. The roleDefinition specified is granted to the principalId in the provider's Active Directory and the principalIdDisplayName is visible to customers."
            }
        }              
    },
    "variables": {
        "mspRegistrationName": "[guid(parameters('mspOfferName'))]",
        "mspAssignmentName": "[guid(parameters('mspOfferName'))]"
    },
    "resources": [
        {
            "type": "Microsoft.ManagedServices/registrationDefinitions",
            "apiVersion": "2019-09-01",
            "name": "[variables('mspRegistrationName')]",
            "properties": {
                "registrationDefinitionName": "[parameters('mspOfferName')]",
                "description": "[parameters('mspOfferDescription')]",
                "managedByTenantId": "[parameters('managedByTenantId')]",
                "authorizations": "[parameters('authorizations')]"
            }
        },
        {
            "type": "Microsoft.ManagedServices/registrationAssignments",
            "apiVersion": "2019-09-01",
            "name": "[variables('mspAssignmentName')]",
            "dependsOn": [
                "[resourceId('Microsoft.ManagedServices/registrationDefinitions/', variables('mspRegistrationName'))]"
            ],
            "properties": {
                "registrationDefinitionId": "[resourceId('Microsoft.ManagedServices/registrationDefinitions/', variables('mspRegistrationName'))]"
            }
        }
    ],
    "outputs": {
        "mspOfferName": {
            "type": "string",
            "value": "[concat('Managed by', ' ', parameters('mspOfferName'))]"
        },
        "authorizations": {
            "type": "array",
            "value": "[parameters('authorizations')]"
        }
    }
}
```


Edit parameters following the format below <br>
* managedByTenantId : the service provider tenant
* principalId : the object id of your user account in service provider tenant
* roleDefinitionId : role id of the RBAC role you defined
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c24d3dd0-9468-4c0d-9d5e-41da6e74ffc1) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/19e06097-769d-47c8-b3ae-ad40e4bc010b) <br>

Sample in my lab
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "mspOfferName": {
      "value": "Ultraman-VS150"
    },
    "mspOfferDescription": {
      "value": "Manage VS 150 sub in ultraman tenant"
    },
    "managedByTenantId": {
      "value": "72f988bf-xxx1-xxxf-xxxx-xxxxxxxxdb47"
    },
    "authorizations": {
      "value":[
		{
			"principalId": "63eb6675-6666-4666-a888-24c53rdf1f1",
			"roleDefinitionId": "b24988ac-6180-42a0-ab88-20f7382dd24c",
			"principalIdDisplayName" : "gjs-contributor"
	  }
	  ]
    }
  }
}
```

Review the information and confirm deployment <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b0c74757-c822-42b7-b228-f227d89160d2)

Wait until the deployment succeeds <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/9207fc87-6e64-445a-9483-8ffa124d7783)

To verify, go to customer's tenant, search `service provider` on the top <br>
Click the `service provider offers` on the left, we can see the lastest one we just deployed <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a183edb1-a739-47fc-b19f-f671cab8a31c)

If we click it, then we can see more details <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2d195243-cd74-4f07-acd0-e3c59029b321)

Then we go to the tenant where you want to manage the sentinel contents, search `My customers` on the top <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a2b5e9e0-ceb3-4ae5-98d3-39dbf1d8d655)

You can find the entry showing that the customer's subscription is onboarded <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e41d79b5-ef29-4707-be29-f01d43601e2a)

Then go to sentinel in service provider's tenant, now you can see the workspaces with sentinel enabled from customer's tenants <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/717b021d-9122-4990-aff5-4e0bb9a80c45)


