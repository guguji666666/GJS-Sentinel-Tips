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
      "AppInsightsWorkspaceResourceID": {
        "type": "string",
        "metadata": {
          "description": "Migrate Classic Application Insights to Log Analytic Workspace which is retiring by 29 February 2024. Use 'Log Analytic Workspace-->Properties' blade having 'Resource ID' property value. This is a fully qualified resourceId which is in format '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}'"
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
        "apiVersion": "2020-02-02",
        "name": "[variables('FunctionName')]",
        "location": "[resourceGroup().location]",
        "kind": "web",
        "properties": {
          "Application_Type": "web",
          "ApplicationId": "[variables('FunctionName')]",
          "WorkspaceResourceId": "[parameters('AppInsightsWorkspaceResourceID')]"
        }
      },
      {
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
          "networkAcls": {
            "bypass": "AzureServices",
            "virtualNetworkRules": [],
            "ipRules": [],
            "defaultAction": "Deny"
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
          },
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
        "apiVersion": "2021-02-01",
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
            "linuxFxVersion": "python|3.11",
            "ipSecurityRestrictions": [
              {
                "ipAddress": "10.0.0.0/8", // Replace with your internal IP range
                "action": "Allow",
                "priority": 100,
                "name": "AllowedInternal"
              },
              {
                "ipAddress": "0.0.0.0/0",
                "action": "Deny",
                "priority": 200,
                "name": "DenyAll"
              }
            ]
          }
        },
        "resources": [
          {
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
              "LogType": "alert, audit"
            }
          }
        ]
      },
      {
        "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
        "apiVersion": "2019-06-01",
        "name": "[concat(variables('FunctionName'), '/default/azure-webjobs-hosts')]",
        "dependsOn": [
          "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('FunctionName'), 'default')]"
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
          "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('FunctionName'), 'default')]"
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
          "[resourceId('Microsoft.Storage/storageAccounts/fileServices', variables('FunctionName'), 'default')]"
        ],
        "properties": {
          "shareQuota": 5120
        }
      }
    ]
  }
```
