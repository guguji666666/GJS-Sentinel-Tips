# Codeless data connector templates

## Data connector with DCR and DCE

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "string",
            "minLength": 1,
            "defaultValue": "<your location>",
            "metadata": {
                "description": "Not used, but needed to pass the arm-ttk test, 'Location-Should-Not-Be-Hardcoded'. Instead the `workspace-location` derived from the log analytics workspace is used."
            }
        },
        "workspace-location": {
            "type": "string",
            "defaultValue": "<your location>",
            "metadata": {
                "description": "[concat('Region to deploy solution resources -- separate from location selection',parameters('location'))]"
            }
        },
        "subscription": {
            "type": "string",
            "defaultValue": "<subscription id>",
            "metadata": {
                "description": "subscription id where Microsoft Sentinel is configured"
            }
        },
        "resourceGroupName": {
            "type": "string",
            "defaultValue": "<your resourcegroup name>",
            "metadata": {
                "description": "resource group name where Microsoft Sentinel is configured"
            }
        },
        "workspace": {
            "defaultValue": "<your workspace name>",
            "type": "string",
            "metadata": {
                "description": "the log analytics workspace enabled for Microsoft Sentinel"
            }
        }
    },
    "variables": {
        "workspaceResourceId": "[resourceId('microsoft.OperationalInsights/Workspaces', parameters('workspace'))]",
        "_solutionName": "TestCodelessDCRDCE2024061201",
        "_solutionVersion": "3.0.0",
        "_solutionAuthor": "Contoso",
        "_packageIcon": "<img src=\"{LogoLink}\" width=\"75px\" height=\"75px\">", // Enter the http link for the logo. NOTE: This field is only recommended for Azure Global Cloud.
        "_solutionId": "azuresentinel.azure-sentinel-solution-azuresentinel.azure-sentinel-MySolution",
        "dataConnectorVersionConnectorDefinition": "1.0.0",
        "dataConnectorVersionConnections": "1.0.0",
        "_solutionTier": "Community",
        "_dataConnectorContentIdConnectorDefinition": "MySolutionTestCodelessDCRDCE2024061201TemplateConnectorDefinition",
        "dataConnectorTemplateNameConnectorDefinition": "[concat(parameters('workspace'),'-dc-',uniquestring(variables('_dataConnectorContentIdConnectorDefinition')))]",
        "_dataConnectorContentIdConnections": "MySolutionTestCodelessDCRDCE2024061201TemplateConnections",
        "_logAnalyticsTableId1": "ExampleConnectorAlerts_CL",  // Enter the custom table name - not needed if you are ingesting data into standard tables
        "dataConnectorTemplateNameConnections": "[concat(parameters('workspace'),'-dc-',uniquestring(variables('_dataConnectorContentIdConnections')))]"
    },
    "resources": [
        {
            "type": "Microsoft.OperationalInsights/workspaces/providers/contentTemplates",
            "apiVersion": "2023-04-01-preview",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/', variables('dataConnectorTemplateNameConnectorDefinition'), variables('dataConnectorVersionConnectorDefinition'))]",
            "location": "[parameters('workspace-location')]",
            "dependsOn": [
                "[extensionResourceId(resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspace')), 'Microsoft.SecurityInsights/contentPackages', variables('_solutionId'))]"
            ],
            "properties": {
                "contentId": "[variables('_dataConnectorContentIdConnectorDefinition')]",
                "displayName": "[concat(variables('_solutionName'), variables('dataConnectorTemplateNameConnectorDefinition'))]",
                "contentKind": "DataConnector",
                "mainTemplate": {
                    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                    "contentVersion": "[variables('dataConnectorVersionConnectorDefinition')]",
                    "parameters": {},
                    "variables": {},
                    "resources": [
                        {
                            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/',concat('DataConnector-', variables('_dataConnectorContentIdConnectorDefinition')))]",
                            "apiVersion": "2022-01-01-preview",
                            "type": "Microsoft.OperationalInsights/workspaces/providers/metadata",
                            "properties": {
                                "parentId": "[extensionResourceId(resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspace')), 'Microsoft.SecurityInsights/dataConnectorDefinitions', variables('_dataConnectorContentIdConnectorDefinition'))]",
                                "contentId": "[variables('_dataConnectorContentIdConnectorDefinition')]",
                                "kind": "DataConnector",
                                "version": "[variables('dataConnectorVersionConnectorDefinition')]",
                                "source": {
                                    "sourceId": "[variables('_solutionId')]",
                                    "name": "[variables('_solutionName')]",
                                    "kind": "Solution"
                                },
                                "author": {
                                    "name": "[variables('_solutionAuthor')]"
                                },
                                "support": {
                                    "name": "[variables('_solutionAuthor')]",
                                    "tier": "[variables('_solutionTier')]"
                                },
                                "dependencies": {
                                    "criteria": [
                                        {
                                            "version": "[variables('dataConnectorVersionConnections')]",
                                            "contentId": "[variables('_dataConnectorContentIdConnections')]",
                                            "kind": "ResourcesDataConnector"
                                        }
                                    ]
                                }
                            }
                        },
                        {
                            "name": "<type your DCR name>",  // Enter your DCR name
                            "apiVersion": "2021-09-01-preview",
                            "type": "Microsoft.Insights/dataCollectionRules",
                            "location": "[parameters('workspace-location')]",
                            "kind": null,
                            "properties": {
                                "dataCollectionEndpointId": "<type your DCE resource id>"
                            }
                        },
                        {
                            "name": "[variables('_logAnalyticsTableId1')]",
                            "apiVersion": "2022-10-01",
                            "type": "Microsoft.OperationalInsights/workspaces/tables",
                            "location": "[parameters('workspace-location')]",
                            "kind": null,
                            "properties": {
                                "name": "[variables('_logAnalyticsTableId1')]"
                            }
                        }
                    ]
                },
                "packageKind": "Solution",
                "packageVersion": "[variables('_solutionVersion')]",
                "packageName": "[variables('_solutionName')]",
                "contentProductId": "[concat(substring(variables('_solutionId'), 0, 50),'-','dc','-', uniqueString(concat(variables('_solutionId'),'-','DataConnector','-',variables('_dataConnectorContentIdConnectorDefinition'),'-', variables('dataConnectorVersionConnectorDefinition'))))]",
                "packageId": "[variables('_solutionId')]",
                "contentSchemaVersion": "3.0.0",
                "version": "[variables('_solutionVersion')]"
            }
        },
        {
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/',variables('_dataConnectorContentIdConnectorDefinition'))]",
            "apiVersion": "2022-09-01-preview",
            "type": "Microsoft.OperationalInsights/workspaces/providers/dataConnectorDefinitions",
            "location": "[parameters('workspace-location')]",
            "kind": "Customizable",
            "properties": {
                "connectorUiConfig": {
                    "title": "<type your title>",
                    "publisher": "<type your publisher name>",
                    "descriptionMarkdown": "Place holder for the descriton",
                    "graphQueries": [
                        {
                            "metricName": "Total events received",
                            "legend": "ADX SigninLogs Ingestion",
                            "baseQuery": "SigninLogs"
                        }
                    ],
                    "sampleQueries": [
                        {
                            "description": "All SigninLogs events",
                            "query": "SigninLogs\n| sort by TimeGenerated desc"
                        }
                    ],
                    "dataTypes": [
                        {
                            "name": "SigninLogs",
                            "lastDataReceivedQuery": "SigninLogs \n            | summarize Time = max(TimeGenerated)\n            | where isnotempty(Time)"
                        }
                    ],
                    "connectivityCriteria": [
                        {
                            "type": "IsConnectedQuery",
                            "value": [
                                "SigninLogs \n | summarize LastLogReceived = max(TimeGenerated)\n | project IsConnected = LastLogReceived > ago(30d)"
                            ]
                        }
                    ],
                    "availability": {
                        "status": 1,
                        "isPreview": false
                    },
                    "permissions": {
                        "resourceProvider": [
                            {
                                "provider": "Microsoft.OperationalInsights/workspaces",
                                "permissionsDisplayText": "read and write permissions are required.",
                                "providerDisplayName": "Workspace",
                                "scope": "Workspace",
                                "requiredPermissions": {
                                    "write": true,
                                    "read": false,
                                    "delete": false,
                                    "action": false
                                }
                            }
                        ]
                    },
                    "instructionSteps": [
                        {
                            "title": "Placeholder for the titile",
                            "description": "Placeholder for the description",
                            "instructions": [
                                {
                                    "type": "OAuthForm",
                                    "parameters": {
                                        "clientIdLabel": "Client ID",
                                        "clientSecretLabel": "Client Secret",
                                        "connectButtonLabel": "Connect",
                                        "disconnectButtonLabel": "Disconnect"
                                    }
                                }
                            ]
                        }
                    ]
                }
            }
        },
        {
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/',concat('DataConnector-', variables('_dataConnectorContentIdConnectorDefinition')))]",
            "apiVersion": "2022-01-01-preview",
            "type": "Microsoft.OperationalInsights/workspaces/providers/metadata",
            "properties": {
                "parentId": "[extensionResourceId(resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspace')), 'Microsoft.SecurityInsights/dataConnectorDefinitions', variables('_dataConnectorContentIdConnectorDefinition'))]",
                "contentId": "[variables('_dataConnectorContentIdConnectorDefinition')]",
                "kind": "DataConnector",
                "version": "[variables('dataConnectorVersionConnectorDefinition')]",
                "source": {
                    "sourceId": "[variables('_solutionId')]",
                    "name": "[variables('_solutionName')]",
                    "kind": "Solution"
                },
                "author": {
                    "name": "[variables('_solutionAuthor')]"
                },
                "support": {
                    "name": "[variables('_solutionAuthor')]",
                    "tier": "[variables('_solutionTier')]"
                },
                "dependencies": {
                    "criteria": [
                        {
                            "version": "[variables('dataConnectorVersionConnections')]",
                            "contentId": "[variables('_dataConnectorContentIdConnections')]",
                            "kind": "ResourcesDataConnector"
                        }
                    ]
                }
            }
        },
        {
            "type": "Microsoft.OperationalInsights/workspaces/providers/contentTemplates",
            "apiVersion": "2023-04-01-preview",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/', variables('dataConnectorTemplateNameConnections'), variables('dataConnectorVersionConnections'))]",
            "location": "[parameters('workspace-location')]",
            "dependsOn": [
                "[extensionResourceId(resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspace')), 'Microsoft.SecurityInsights/contentPackages', variables('_solutionId'))]"
            ],
            "properties": {
                "contentId": "[variables('_dataConnectorContentIdConnections')]",
                "displayName": "[concat(variables('_solutionName'), variables('dataConnectorTemplateNameConnections'))]",
                "contentKind": "ResourcesDataConnector",
                "mainTemplate": {
                    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                    "contentVersion": "[variables('dataConnectorVersionConnections')]",
                    "parameters":
                    // These parameters are used by the data connector primarily as properties for the administrator to enter in the UI when configuring the connector
                    {
                        "connectorDefinitionName": {
                            "defaultValue": "connectorDefinitionName",
                            "type": "string",
                            "minLength": 1
                        },
                        "workspace": {
                            "defaultValue": "[parameters('workspace')]",
                            "type": "string"
                        },
                        "dcrConfig": {
                            "defaultValue": {
                                "dataCollectionEndpoint": "data collection Endpoint",
                                "dataCollectionRuleImmutableId": "data collection rule immutableId"
                            },
                            "type": "object"
                        }
                    },
                    "variables": {
                        "_dataConnectorContentIdConnections": "[variables('_dataConnectorContentIdConnections')]"
                    },
                    "resources": [
                        {
                            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/',concat('DataConnector-', variables('_dataConnectorContentIdConnections')))]",
                            "apiVersion": "2022-01-01-preview",
                            "type": "Microsoft.OperationalInsights/workspaces/providers/metadata",
                            "properties": {
                                "parentId": "[extensionResourceId(resourceId('Microsoft.OperationalInsights/workspaces', parameters('workspace')), 'Microsoft.SecurityInsights/dataConnectors', variables('_dataConnectorContentIdConnections'))]",
                                "contentId": "[variables('_dataConnectorContentIdConnections')]",
                                "kind": "ResourcesDataConnector",
                                "version": "[variables('dataConnectorVersionConnections')]",
                                "source": {
                                    "sourceId": "[variables('_solutionId')]",
                                    "name": "[variables('_solutionName')]",
                                    "kind": "Solution"
                                },
                                "author": {
                                    "name": "[variables('_solutionAuthor')]"
                                },
                                "support": {
                                    "name": "[variables('_solutionAuthor')]",
                                    "tier": "[variables('_solutionTier')]"
                                }
                            }
                        },
                        {
                            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/', 'MyDataConnector')]",
                            "apiVersion": "2022-12-01-preview",
                            "type": "Microsoft.OperationalInsights/workspaces/providers/dataConnectors",
                            "location": "[parameters('workspace-location')]",
                            "kind": "RestApiPoller",
                            "properties": {
                                "dataType": "My product security event API",
                                "response": {
                                    "eventsJsonPaths": [
                                        "$"
                                    ],
                                    "format": "json"
                                },
                                "paging": {
                                    "pagingType": "LinkHeader"
                                },
                                "connectorDefinitionName": "[[parameters('connectorDefinitionName')]",
                                "auth": {
                                    "type": "OAuth2",
                                    "ClientSecret": "[[parameters('Password')]",
                                    "ClientId": "[[parameters('Username')]",
                                    "GrantType": "client_credentials",
                                    "TokenEndpoint": "https://login.microsoftonline.com/53a8b0d9-d900-48cc-9d7e-5935dc8d5b17/oauth2/token",
                                    "TokenEndpointHeaders": {
                                        "Content-Type": "application/x-www-form-urlencoded"
                                    },
                                    "TokenEndpointQueryParameters": {
                                        "grant_type": "client_credentials"
                                    }
                                },
                                "request": {
                                    "apiEndpoint": "https://csddadx01prod.eastus.kusto.windows.net//v2/rest/query",
                                    "rateLimitQPS": 10,
                                    "queryWindowInMin": 5,
                                    "httpMethod": "GET",
                                    "retryCount": 3,
                                    "timeoutInSeconds": 60,
                                    "headers": {
                                        "Accept": "application/json",
                                        "Content-Type": "application/json",
                                        "Host": "csddadx01prod.eastus.kusto.windows.net"
                                    },
                                    "startTimeAttributeName": "since",
                                    "endTimeAttributeName": "until"
                                },
                                "dcrConfig": {
                                    "dataCollectionEndpoint": "[[parameters('dcrConfig').dataCollectionEndpoint]",
                                    "dataCollectionRuleImmutableId": "[[parameters('dcrConfig').dataCollectionRuleImmutableId]",
                                    "streamName": "Custom-ExampleConnectorAlerts_CL"
                                },
                                "isActive": true
                            }
                        }
                    ]
                },
                "packageKind": "Solution",
                "packageVersion": "[variables('_solutionVersion')]",
                "packageName": "[variables('_solutionName')]",
                "contentProductId": "[concat(substring(variables('_solutionId'), 0, 50),'-','rdc','-', uniqueString(concat(variables('_solutionId'),'-','ResourcesDataConnector','-',variables('_dataConnectorContentIdConnections'),'-', variables('dataConnectorVersionConnections'))))]",
                "packageId": "[variables('_solutionId')]",
                "contentSchemaVersion": "3.0.0",
                "version": "[variables('_solutionVersion')]"
            }
        },
        {
            "type": "Microsoft.OperationalInsights/workspaces/providers/contentPackages",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/', variables('_solutionId'))]",
            "location": "[parameters('workspace-location')]",
            "apiVersion": "2023-04-01-preview",
            "properties": {
                "version": "[variables('_solutionVersion')]",
                "kind": "Solution",
                "contentSchemaVersion": "3.0.0",
                "contentId": "[variables('_solutionId')]",
                "source": {
                    "kind": "Solution",
                    "name": "[variables('_solutionName')]",
                    "sourceId": "[variables('_solutionId')]"
                },
                "author": {
                    "name": "[variables('_solutionAuthor')]"
                },
                "support": {
                    "name": "[variables('_solutionAuthor')]"
                },
                "dependencies": {
                    "operator": "AND",
                    "criteria": [
                        {
                            "kind": "DataConnector",
                            "contentId": "[variables('dataConnectorVersionConnectorDefinition')]",
                            "version": "[variables('_dataConnectorContentIdConnectorDefinition')]"
                        }
                    ]
                },
                "firstPublishDate": "2023-12-05",
                "providers": [
                    "[variables('_solutionAuthor')]"
                ],
                "contentKind": "Solution",
                "packageId": "[variables('_solutionId')]",
                "contentProductId": "[concat(substring(variables('_solutionId'), 0, 50),'-','sl','-', uniqueString(concat(variables('_solutionId'),'-','Solution','-',variables('_solutionId'),'-', variables('_solutionVersion'))))]",
                "displayName": "[variables('_solutionName')]",
                "publisherDisplayName": "[variables('_solutionId')]",
                "descriptionHtml": "test",
                "icon": "[variables('_packageIcon')]"
            }
        }
    ]
}
```
