## Deploy automation rules via ARM template and additional work
### Deploy automation rules using ARM template and input the parameters interactively
If we use the template mentioned in [Creates a new Microsoft Sentinel Automation Rule](https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/sentinel-automation-rule/), then we will see the page where we can interactively input the parameters required
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

## But if we deploy the automation rules via `github/devops` repository pipeline, the process will run in `backend` and we'll not see this page

### Deploy automation rules using ARM template `without` typing the parameters interactively

We could get the existing automation rule using
* [Automation Rules - List](https://learn.microsoft.com/en-us/rest/api/securityinsights/preview/automation-rules/list?tabs=HTTP)
* [Automation Rules - Get](https://learn.microsoft.com/en-us/rest/api/securityinsights/preview/automation-rules/get?tabs=HTTP)

Sample in the lab:

List the all existing automation rules with details, type name of resourcegroup where the `workspace` belongs to
![image](https://user-images.githubusercontent.com/96930989/212606125-3bf4e0f2-a177-415f-ab2e-5aea8cb2c722.png)

I define all the actions in the test automation rule
![image](https://user-images.githubusercontent.com/96930989/212612370-7da240c4-fdaa-4762-bc36-40f083d53a2a.png)

With the reference from the existing automation rules, the format of ARM template used in github/devops repository pipeline should follow:
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
            "id": "[concat(resourceId('Microsoft.OperationalInsights/workspaces/providers', parameters('workspace'), 'Microsoft.SecurityInsights'),'/automationRules/2f8aa7b1-ff94-4251-8c71-44a63e468bd4')]",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/2f8aa7b1-ff94-4251-8c71-44a63e468bd4')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/automationRules",
            "kind": "Scheduled",
            "apiVersion": "2019-01-01-preview",
            "properties": {
                "displayName": "GJS Test Repositories automation rule 1",
                "order": 77,
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
                            "severity": null,
                            "status": null,
                            "classification": null,
                            "classificationReason": null,
                            "classificationComment": null,
                            "owner": null,
                            "labels": [
                              {
                                "labelName": "test tag",
                                "labelType": "User"
                            }
                        ]
                        }
                    },
                    {
                        "order": 3,
                        "actionType": "ModifyProperties",
                        "actionConfiguration": {
                          "severity": null,
                          "status": null,
                          "classification": null,
                          "classificationReason": null,
                          "classificationComment": null,
                          "owner": {
                            "objectId": "e19f5a08-b9aa-3d10-a084-d1e6e9a6e441",
                            "email": "gjs@ultramanorb.onmicrosoft.com",
                            "assignedTo": "ultramangjs",
                            "userPrincipalName": "gjs@ultramanorb.onmicrosoft.com"
                          },
                          "labels": null
                        }
                    }
                ]
            }
        }
    ]
}
```
You can also add more actions if required in the automation rule

You can generate your own guid by powershell command `new-guid` and then fill it in the parts below accordingly
![image](https://user-images.githubusercontent.com/96930989/212597866-c0cc7596-3747-43f6-8b84-0a43392b4e5d.png)

Sample with successful deployment
![image](https://user-images.githubusercontent.com/96930989/212619200-45f3afac-61c6-4ecb-aa19-3959475f22ed.png)

