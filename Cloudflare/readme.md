# Stream Cloudflare events to Sentinel workspace
* [Integrate Cloudflare with Microsoft Sentinel](https://www.cloudflare.com/partners/technology-partners/microsoft/azure-sentinel/)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/fa4ba6ca-9f10-4bd8-91e3-bbb77805fab1)

* [Cloudflare (Preview) (using Azure Functions) connector for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors/cloudflare-using-azure-functions)

## Deployment

### [Prerequisite to configure Logpush](https://developers.cloudflare.com/logs/about/)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/3e77448f-2424-42c2-bcef-96cea0f96142)

### 1. [Setup Cloudflare Logpush to Microsoft Azure](https://developers.cloudflare.com/logs/get-started/enable-destinations/)

Sample : stream to Azure storage account <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ade729af-0654-4f3a-aa04-e54d88509746)

Log in to the Cloudflare dashboard. <br>
Select the Enterprise account or domain you want to use with Logpush.<br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5d3cd9ba-2d47-414f-b33f-7cacdd7850a0)

Go to `Analytics & Logs > Logs`. <br>


Select Add Logpush job.

In Select data set, choose the dataset to push to a storage service, and select Next.

In Select data fields:

Select the data fields to include in your logs. Add or remove fields later by modifying your settings in Logs > Logpush.
In Advanced Settings, you can change the Timestamp format (RFC3339(default),Unix, or UnixNano), Sampling rate and enable redaction for CVE-2021-44228.
Under Filters you can select the events to include and/or remove from your logs. For more information, refer to Filters. Not all datasets have this option available.
In Select a destination, choose Microsoft Azure.

Enter or select the following destination information:

SAS URL
Blob container subpath (optional)
Daily subfolders
Select Validate access.

Enter the Ownership token (included in a file or log Cloudflare sends to your provider) and select Prove ownership. To find the ownership token, select Open in the Overview tab of the ownership challenge file.

Select Save and Start Pushing to finish enabling Logpush.

Once connected, Cloudflare lists Microsoft Azure as a connected service under Logs > Logpush. Edit or remove connected services from here.

## ARM template offered to deploy resources
```json
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "FunctionName": {
            "defaultValue": "Cloudflare",
            "type": "string",
            "minLength": 1,
            "maxLength": 30
        },
        "AzureBlobStorageContainerName": {
            "type": "string",
            "defaultValue": ""
        },
        "AzureBlobStorageConnectionString": {
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
        "SimultaneouslyProcessingFiles": {
            "type": "int",
            "defaultValue": 20,
            "metadata": {
                "description": "Defines how many files can be processed simultaneously. Higher value means higher processing speed and higher memory consumption. If log files are bigger than 50 Mb, it is recommended to use value not higher than 20. If files are smaller, value can be higher."
            }
        },
        "EventsBucketSize": {
            "type": "int",
            "defaultValue": 2000,
            "metadata": {
                "description": "Defines max number of events that can be sent in one request to Microsoft Sentinel. Higher value means higher processing speed and higher memory consumption."
            }
        }
    },
    "variables": {
        "FunctionName": "[concat(toLower(parameters('FunctionName')), uniqueString(resourceGroup().id))]",
        "StorageSuffix": "[environment().suffixes.storage]",
        "LogAnaltyicsUri": "[replace(environment().portal, 'https://portal', concat('https://', toLower(parameters('AzureSentinelWorkspaceId')), '.ods.opinsights'))]"
    },
    "resources": [
        {
            "type": "Microsoft.Insights/components",
            "apiVersion": "2015-05-01",
            "name": "[variables('FunctionName')]",
            "location": "[resourceGroup().location]",
            "kind": "web",
            "properties": {
                "Application_Type": "web",
                "ApplicationId": "[variables('FunctionName')]"
            }
        },
        {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2019-06-01",
            "name": "[tolower(variables('FunctionName'))]",
            "location": "[resourceGroup().location]",
            "sku": {
                "name": "Standard_LRS",
                "tier": "Standard"
            },
            "kind": "StorageV2",
            "properties": {
                "networkAcls": {
                    "bypass": "AzureServices",
                    "virtualNetworkRules": [],
                    "ipRules": [],
                    "defaultAction": "Allow"
                },
                "supportsHttpsTrafficOnly": true,
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
                }
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
                    "corsRules": []
                },
                "deleteRetentionPolicy": {
                    "enabled": false
                }
            }
        },
        {
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
                    "corsRules": []
                }
            }
        },
        {
            "type": "Microsoft.Web/sites",
            "apiVersion": "2018-11-01",
            "name": "[variables('FunctionName')]",
            "location": "[resourceGroup().location]",
            "dependsOn": [
                "[resourceId('Microsoft.Storage/storageAccounts', tolower(variables('FunctionName')))]",
                "[resourceId('Microsoft.Insights/components', variables('FunctionName'))]"
            ],
            "kind": "functionapp,linux",
            "identity": {
                "type": "SystemAssigned"
            },
            "properties": {
                "name": "[variables('FunctionName')]",
                "httpsOnly": true,
                "clientAffinityEnabled": true,
                "alwaysOn": true,
                "reserved": true,
                "siteConfig": {
                    "linuxFxVersion": "python|3.8"
                }
            },

            "resources": [
                {
                    "apiVersion": "2018-11-01",
                    "type": "config",
                    "name": "appsettings",
                    "dependsOn": [
                        "[concat('Microsoft.Web/sites/', variables('FunctionName'))]"
                    ],
                    "properties": {
                        "FUNCTIONS_EXTENSION_VERSION": "~4",
                        "FUNCTIONS_WORKER_RUNTIME": "python",
                        "APPINSIGHTS_INSTRUMENTATIONKEY": "[reference(resourceId('Microsoft.insights/components', variables('FunctionName')), '2015-05-01').InstrumentationKey]",
                        "APPLICATIONINSIGHTS_CONNECTION_STRING": "[reference(resourceId('microsoft.insights/components', variables('FunctionName')), '2015-05-01').ConnectionString]",
						"CONTAINER_NAME": "[parameters('AzureBlobStorageContainerName')]",
                        "AZURE_STORAGE_CONNECTION_STRING": "[parameters('AzureBlobStorageConnectionString')]",
                        "AzureWebJobsStorage": "[concat('DefaultEndpointsProtocol=https;AccountName=', toLower(variables('FunctionName')),';AccountKey=',listKeys(resourceId('Microsoft.Storage/storageAccounts', toLower(variables('FunctionName'))), '2019-06-01').keys[0].value, ';EndpointSuffix=',toLower(variables('StorageSuffix')))]",                      
                        "WORKSPACE_ID": "[parameters('AzureSentinelWorkspaceId')]",
                        "SHARED_KEY": "[parameters('AzureSentinelSharedKey')]",
                        "MAX_CONCURRENT_PROCESSING_FILES": "[parameters('SimultaneouslyProcessingFiles')]",
                        "MAX_BUCKET_SIZE": "[parameters('EventsBucketSize')]",
                        "logAnalyticsUri": "[variables('LogAnaltyicsUri')]",
                        "WEBSITE_RUN_FROM_PACKAGE": "https://aka.ms/sentinel-CloudflareDataConnector-functionapp",
                        "lineSeparator": "[\\n\\r\\x0b\\v\\x0c\\f\\x1c\\x1d\\x85\\x1e\\u2028\\u2029]+"
                    }
                }
            ]
        },
        {
            "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default/azure-webjobs-hosts')]",
            "dependsOn": [
                "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('FunctionName'), 'default')]",
                "[resourceId('Microsoft.Storage/storageAccounts', variables('FunctionName'))]"
            ],
            "properties": {
                "publicAccess": "None"
            }
        },
        {
            "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default/azure-webjobs-secrets')]",
            "dependsOn": [
                "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('FunctionName'), 'default')]",
                "[resourceId('Microsoft.Storage/storageAccounts', variables('FunctionName'))]"
            ],
            "properties": {
                "publicAccess": "None"
            }
        },
        {
            "type": "Microsoft.Storage/storageAccounts/fileServices/shares",
            "apiVersion": "2019-06-01",
            "name": "[concat(variables('FunctionName'), '/default/', tolower(variables('FunctionName')))]",
            "dependsOn": [
                "[resourceId('Microsoft.Storage/storageAccounts/fileServices', variables('FunctionName'), 'default')]",
                "[resourceId('Microsoft.Storage/storageAccounts', variables('FunctionName'))]"
            ],
            "properties": {
                "shareQuota": 5120
            }
        }
    ]
}
```
