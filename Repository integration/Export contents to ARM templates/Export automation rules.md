## Deploy automation rules via ARM template

If we used the template mentioned in [Creates a new Microsoft Sentinel Automation Rule](https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/sentinel-automation-rule/), then we will see the page where we can interactively input the parameters required
![image](https://user-images.githubusercontent.com/96930989/212603290-b99748ec-255a-4424-86eb-d74d6ac2befa.png)
```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "existingWorkspaceName": {
            "type": "string",
            "metadata": {
                "description": "The name of the Sentinel workspace where the automation rule will be deployed"
            }
        },
        "automationRuleName": {
            "type": "string",
            "metadata": {
                "description": "The name of the automation rule that will be deployed"
            }
        },
        "existingRuleId": {
            "type": "string",
            "metadata": {
                "description": "The analytics rule GUID that is used in the triggering conditions. Feel free to remove the condition below if you don't need it."
            }
        }
    },
    "variables": {
        "automationRuleGuid": "[uniqueString(parameters('automationRuleName'))]" 
    },
    "resources": [
        {
            "type": "Microsoft.SecurityInsights/automationRules",
            "name": "[variables('automationRuleGuid')]",
            "scope": "[concat('Microsoft.OperationalInsights/workspaces/', parameters('existingWorkspaceName'))]",
            "apiVersion": "2019-01-01-preview",
            "properties": {
                "displayName": "[parameters('automationRuleName')]",
                "order": 2,
                "triggeringLogic": {
                    "isEnabled": true,
                    "expirationTimeUtc": null,
                    "triggersOn": "Incidents",
                    "triggersWhen": "Created",
                    "conditions": [
                            {
                                "conditionType": "Property",
                                "conditionProperties": {
                                    "propertyName": "IncidentRelatedAnalyticRuleIds",
                                    "operator": "Contains",
                                    "propertyValues": [
                                        "[resourceId('Microsoft.OperationalInsights/workspaces/providers/alertRules',parameters('existingWorkspaceName'),'Microsoft.SecurityInsights',parameters('existingRuleId'))]"
                                    ]
                                }
                            },
                            {
                                "conditionType": "Property",
                                "conditionProperties": {
                                    "propertyName": "IncidentSeverity",
                                    "operator": "Equals",
                                    "propertyValues": [
                                        "High"
                                    ]
                                }
                            },
                            {
                                "conditionType": "Property",
                                "conditionProperties": {
                                    "propertyName": "IncidentTactics",
                                    "operator": "Contains",
                                    "propertyValues": [
                                        "InitialAccess",
                                        "Execution"
                                    ]
                                }
                            },
                            {
                                "conditionType": "Property",
                                "conditionProperties": {
                                    "propertyName": "IncidentTitle",
                                    "operator": "Contains",
                                    "propertyValues": [
                                        "urgent"
                                    ]
                                }
                            }


                    ]
                },
                "actions": [
                    {
                        "order": 2,
                        "actionType": "ModifyProperties",
                        "actionConfiguration": {
                            "status": "Closed",
                            "classification": "Undetermined",
                            "classificationReason": null
                        }
                    },
                    {
                        "order": 3, 
                        "actionType": "ModifyProperties", 
                        "actionConfiguration": {
                            "labels": [
                                {
                                    "labelName": "tag"
                                }
                            ]
                        }
                    }
                ]
            }
        }
    ],
    "outputs": {}
}
```

But if we deplot the automation rules via github/devops repository pipeline, the process will run in `backend` and we'll not see this page

We could get the existing automation rule using [Automation Rules - Get](https://learn.microsoft.com/en-us/rest/api/securityinsights/preview/automation-rules/get?tabs=HTTP)

The Format of ARM template used in github/devops repository pipeline
```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "workspace": {
            "type": "String"
        }
    },
    "resources": [
        {
            "id": "[concat(resourceId('Microsoft.OperationalInsights/workspaces/providers', parameters('workspace'), 'Microsoft.SecurityInsights'),'/automationRules/85f2eac9-43f1-480e-b8ad-473375c195c0')]",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/85f2eac9-43f1-480e-b8ad-473375c195c0')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/automationRules",
            "kind": "Scheduled",
            "apiVersion": "2019-01-01-preview",
            "properties": {
                "displayName": "Repositories automation rule 1",
                "order": 1,
                "triggeringLogic": {
                    "isEnabled": true,
                    "expirationTimeUtc": null,
                    "triggersOn": "Incidents",
                    "triggersWhen": "Created",
                    "conditions": [
                        {
                            "conditionType": "Property",
                            "conditionProperties": {
                                "propertyName": "IncidentTactics",
                                "operator": "Contains",
                                "propertyValues": [
                                    "Persistence"
                                ]
                            }
                        }
                    ]
                },
                "actions": [
                    {
                        "order": 1,
                        "actionType": "ModifyProperties",
                        "actionConfiguration": {
                            "owner": {
                                "objectId": "b18ef471-be11-439d-9279-5ce4e18b976e",
                                "email": "SampleEmail@Contoso.com",
                                "userPrincipalName": "SampleUser@Contoso.com"
                            }
                        }
                    }
                ]
            }
        }
    ]
}
```




You can generate your own guid by powershell command `new-guid` and then fill it in the parts below accordingly
![image](https://user-images.githubusercontent.com/96930989/212597866-c0cc7596-3747-43f6-8b84-0a43392b4e5d.png)
