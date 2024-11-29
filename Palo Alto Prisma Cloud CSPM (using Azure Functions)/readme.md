# Palo Alto Prisma Cloud CSPM (using Azure Functions)

## ARM template for deployment
### Create storage account and function app with public access disabled
```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "FunctionName": {
            "defaultValue": "PrismaCloud",
            "type": "string",
            "minLength": 1,
            "maxLength": 11
        },
        "PrismaCloudAPIUrl": {
            "type": "string",
            "defaultValue": ""
        },
        "PrismaCloudAccessKeyID": {
            "type": "string",
            "defaultValue": ""
        },
        "PrismaCloudSecretKey": {
            "type": "securestring",
            "defaultValue": ""
        },
        "AzureSentinelWorkspaceId": {
            "type": "string",
            "defaultValue": ""
        },
        "AzureSentinelSharedKey": {
            "type": "securestring",
            "defaultValue": ""
        },
        // Parameter for the Application Insights workspace resource ID.
        "AppInsightsWorkspaceResourceID": {
          "type": "string",
          "metadata": {
            "description": "Migrate Classic Application Insights to Log Analytic Workspace which is retiring by 29 February 2024. Use 'Log Analytic Workspace-->Properties' blade having 'Resource ID' property value. This is a fully qualified resourceId which is in format '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}'"
          }
        }
    },
    "variables": {
        // Unique function name derived from parameter and resource group ID
        "FunctionName": "[concat(toLower(parameters('FunctionName')), uniqueString(resourceGroup().id))]",
        // Suffix for storage accounts based on environment
        "StorageSuffix": "[environment().suffixes.storage]",
        // Constructing the Log Analytics URI based on the workspace ID provided
        "LogAnaltyicsUri": "[replace(environment().portal, 'https://portal', concat('https://', toLower(parameters('AzureSentinelWorkspaceId')), '.ods.opinsights'))]"
    },
    "resources": [
        {
            "type": "Microsoft.Insights/components",
            "apiVersion": "2020-02-02",
            "name": "[variables('FunctionName')]",
            "location": "[resourceGroup().location]",
            "kind": "web",
            "properties": {
                // Specify the type of application being monitored
                "Application_Type": "web",
                "ApplicationId": "[variables('FunctionName')]",
                "WorkspaceResourceId": "[parameters('AppInsightsWorkspaceResourceID')]"
            }
        },
        {
            // Creates a storage account for serverless function
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2021-09-01",
            "name": "[tolower(variables('FunctionName'))]",
            "location": "[resourceGroup().location]",
            "sku": {
                "name": "Standard_LRS",
                "tier": "Standard"
            },
            "kind": "StorageV2",
            "properties": {
                // Network Access Control List (ACL) for the storage account
                "networkAcls": {
                    "bypass": "AzureServices", // Allows Azure services to access the storage account
                    "virtualNetworkRules": [], // No virtual network rules specified
                    "ipRules": [], // No IP address rules specified
                    "defaultAction": "Deny" // Denies access by default; needs rules to allow access
                },
                "supportsHttpsTrafficOnly": true, // Enforces HTTPS traffic only
                // Enables encryption for data at rest in blob and file services
                "encryption": {
                    "services": {
                        "file": {
                            "keyType": "Account",
                            "enabled": true
                        },
                        "blob": {
                            "keyType": "Account",
                            "enabled": true
                        }
                    },
                    "keySource": "Microsoft.Storage"
                },
                // Disabling public network access to enhance security
                "publicNetworkAccess": "Disabled"
            }
        },
        {
            "type": "Microsoft.Storage/storageAccounts/blobServices",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default')]",
            "dependsOn": [
              "[resourceId('Microsoft.Storage/storageAccounts', tolower(variables('FunctionName')))]"
            ],
            "sku": {
              "name": "Standard_LRS",
              "tier": "Standard"
            },
            "properties": {
              "cors": {
                "corsRules": [] // No CORS rules defined
              },
              // No delete retention policy currently in place
              "deleteRetentionPolicy": {
                "enabled": false
              }
            }
        },
        {
            // Setting up a file service for the storage account
            "type": "Microsoft.Storage/storageAccounts/fileServices",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default')]",
            "dependsOn": [
              "[resourceId('Microsoft.Storage/storageAccounts', tolower(variables('FunctionName')))]"
            ],
            "sku": {
                "name": "Standard_LRS",
                "tier": "Standard"
            },
            "properties": {
                "cors": {
                    "corsRules": [] // No CORS rules defined
                }
            }
        },
        {
            // Creates a function app that operates within this configuration
            "type": "Microsoft.Web/sites",
            "apiVersion": "2021-02-01",
            "name": "[variables('FunctionName')]",
            "location": "[resourceGroup().location]",
            "dependsOn": [
              "[resourceId('Microsoft.Storage/storageAccounts', tolower(variables('FunctionName')))]",
              "[resourceId('Microsoft.Insights/components', variables('FunctionName'))]"
            ],
            "kind": "functionapp,linux",
            "identity": {
              "type": "SystemAssigned" // Enables identity for the function app to access other Azure resources
            },
            "properties": {
                "name": "[variables('FunctionName')]",
                "httpsOnly": true, // Only allow HTTPS traffic
                "clientAffinityEnabled": true, // Enables client affinity
                "alwaysOn": true, // Keeps the function app running always
                "reserved": true, // Indicates that the app service is for Linux
                "siteConfig": {
                    // Configuration for security restrictions based on IP
                    "linuxFxVersion": "python|3.11",
                    "ipSecurityRestrictions": [
                        {
                            // Allows traffic from internal IP range
                            "ipAddress": "10.0.0.0/8", // NOTE: Replace with your internal IP range
                            "action": "Allow", // Action to take for this rule
                            "priority": 100, // Priority of this rule
                            "name": "AllowedInternal" // Rule name
                        },
                        {
                            // Denies traffic from all other IP addresses
                            "ipAddress": "0.0.0.0/0",
                            "action": "Deny", // Action to take for this rule
                            "priority": 200, // Higher priority number means a lower priority
                            "name": "DenyAll" // Rule name
                        }
                    ]
                }
            },
            "resources": [
                {
                    // Setting application settings for the function app
                    "apiVersion": "2021-02-01",
                    "type": "config",
                    "name": "appsettings",
                    "dependsOn": [
                      "[concat('Microsoft.Web/sites/', variables('FunctionName'))]"
                    ],
                    "properties": {
                        "FUNCTIONS_EXTENSION_VERSION": "~4",
                        "FUNCTIONS_WORKER_RUNTIME": "python",
                        "APPINSIGHTS_INSTRUMENTATIONKEY": "[reference(resourceId('Microsoft.Insights/components', variables('FunctionName')), '2020-02-02').InstrumentationKey]",
                        "APPLICATIONINSIGHTS_CONNECTION_STRING": "[reference(resourceId('Microsoft.Insights/components', variables('FunctionName')), '2020-02-02').ConnectionString]",
                        "AzureWebJobsStorage": "[concat('DefaultEndpointsProtocol=https;AccountName=', toLower(variables('FunctionName')),';AccountKey=',listKeys(resourceId('Microsoft.Storage/storageAccounts', tolower(variables('FunctionName'))), '2021-09-01').keys[0].value, ';EndpointSuffix=',toLower(variables('StorageSuffix')))]",
                        "PrismaCloudAPIUrl": "[parameters('PrismaCloudAPIUrl')]",
                        "PrismaCloudSecretKey": "[parameters('PrismaCloudSecretKey')]",
                        "PrismaCloudAccessKeyID": "[parameters('PrismaCloudAccessKeyID')]",
                        "AzureSentinelWorkspaceId": "[parameters('AzureSentinelWorkspaceId')]",
                        "AzureSentinelSharedKey": "[parameters('AzureSentinelSharedKey')]",
                        "logAnalyticsUri": "[variables('LogAnaltyicsUri')]",
                        "WEBSITE_RUN_FROM_PACKAGE": "https://aka.ms/sentinel-PaloAltoPrismaCloud-functionapp",
                        "LogType": "alert, audit" // Setting the log type
                    }
                }
            ]
        },
        {
            // Create container for hosting Azure WebJobs
            "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default/azure-webjobs-hosts')]",
            "dependsOn": [
              "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('FunctionName'), 'default')]"
            ],
            "properties": {
                "publicAccess": "None" // No public access to this container for security
            }
        },
        {
            // Create another container for storing secrets for Azure WebJobs
            "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default/azure-webjobs-secrets')]",
            "dependsOn": [
              "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('FunctionName'), 'default')]"
            ],
            "properties": {
                "publicAccess": "None" // No public access to this container for security
            }
        },
        {
            // Create a file share within the file service
            "type": "Microsoft.Storage/storageAccounts/fileServices/shares",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default/', tolower(variables('FunctionName')))]",
            "dependsOn": [
              "[resourceId('Microsoft.Storage/storageAccounts/fileServices', variables('FunctionName'), 'default')]"
            ],
            "properties": {
                "shareQuota": 5120 // Quota set for the file share in MB
            }
        }
    ]
}
```

### Key Networking Aspects Explained
Network Access Control Lists (networkAcls):
* Bypass: Specifies that Azure services can access the storage account, bypassing any configured firewall rules.
* Virtual Network Rules and IP Rules: Both are empty, meaning no virtual networks or specific IP ranges are allowed; this restricts access to the storage account to only Azure services (due to bypass set).
* Default Action: Set to "Deny", meaning any access not explicitly allowed will be blocked, enhancing security.


Function App Security:
* IP Security Restrictions:
An internal IP range (10.0.0.0/8) is allowed to access the function app, while everything else is denied. This means only designated hosts within this IP range can interact with the function app, providing a secure environment.


Public Network Access:
* The public network access for the storage account is disabled, ensuring that the storage account cannot be accessed over the internet.

App Service Configuration:
* The function app is set to allow HTTPS traffic only, ensuring data in transit is secure.
* The property "clientAffinityEnabled" ensures that subsequent requests from the same client can be routed to the same instance of the function app if it is hosted in a multi-instance environment.

### Deployment with custom template following [Quickstart: Create and deploy ARM templates by using the Azure portal](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/quickstart-create-templates-use-the-portal)


### Verify resources created
#### Storage account
![image](https://github.com/user-attachments/assets/eb13ef88-2ec6-48d3-b666-f6311966ae32)

#### Function app
![image](https://github.com/user-attachments/assets/71d69b34-18da-4d41-945b-0a2a33a94db4)


