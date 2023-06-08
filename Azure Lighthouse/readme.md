# Sentinel with Azure lighthouse

### [Manage Microsoft Sentinel workspaces at scale](https://learn.microsoft.com/en-us/azure/lighthouse/how-to/manage-sentinel-workspaces)
### [Manage multiple tenants in Microsoft Sentinel as an MSSP](https://learn.microsoft.com/en-us/azure/sentinel/multiple-tenants-service-providers)
### [Onboard a customer to Azure Lighthouse](https://learn.microsoft.com/en-us/azure/lighthouse/how-to/onboard-customer)
### [Azure Lighthouse - Step by step guidance - Onboard customer to Lighthouse using sample template](https://techcommunity.microsoft.com/t5/azure-paas-blog/azure-lighthouse-step-by-step-guidance-onboard-customer-to/ba-p/1793055)
### [Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)

## Concepts

* Service Provider: the one to manage delegated resources. (the tenant where you want to manage the sentinel overview panel)

* Customer : the delegated resources (subscription and/or resources group) can be accessed and managed through service provider’s Azure Active Directory tenant. ( the tenants mananged by your tenant where the sentinel overview panel locates)

## Start deployment
Suppose the Service Provider is `tenant A` (where you want to manage the Sentinel contents) <br>
Now you want to add the cx's tenant `tenant B` <br>
Your account is invited to tenant B and has the `contributor role` on the subscription in tenant B <br>

### 1. Get the `tenant id` of tenant A 
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d8c65642-3d3a-4fbc-8f2f-9a0982b02940)

### 2. Get the `object id` of the account in tenant A (the user could be assigned with permissions to manage cx's subscription)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/0409b2a0-1fd7-45de-9d96-4fd987439dc2)

### 3. Get the role id of RBAC role that you want to assign to the user in step 2
We can refer to the doc [Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) <br>
In this sample, we chose contributor, so the role id would be `Azure built-in roles` <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e093901d-5cbf-4f0a-a8e3-142aa173ec45)

### 4. Make sure that the resource providers below are registered in the subscription in tenant B
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2679dff8-08dd-464e-8893-53b640cf8d45)

### 5. Cx should sign in their own teanant using `non-guest` user with `owner` role on the subscription to be onboarded
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/aca02f5b-1fa3-42f1-bb16-13f8ce444a23) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/732b982f-d26d-4846-99d4-ce1aace4c60c) <br>

### 6. Select the ARM template for deployment [Onboard Microsoft Azure Lighthouse](https://github.com/Azure/Azure-Lighthouse-samples#deploy-to-azure-buttons)

ARM template to onboard subscription
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


Edit parameters <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c24d3dd0-9468-4c0d-9d5e-41da6e74ffc1) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/bd0b0b6f-737a-44b4-8fe5-c99db7e166a0) <br>
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
      "value": "72xxxxxxxxxxxxxxxxxxxxxxxx7"
    },
    "authorizations": {
      "value":[
		{
			"principalId": "7exxxxxxxxxxxxxxxxxxxxxxxxxxxx1",
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


