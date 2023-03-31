# Export analytics rules to ARM template
### 1. Navigate to `Sentinel > Analytics`, check the box of the rule you want to export, click `export`
![image](https://user-images.githubusercontent.com/96930989/212596696-08040048-72c8-4697-a704-5279adf61da6.png)
### 2. The rule will be exported to `json` file
![image](https://user-images.githubusercontent.com/96930989/212595919-1cc852fc-cea4-4db5-bf08-2602a51efb98.png)
### 3. Check the Json file
![image](https://user-images.githubusercontent.com/96930989/217117828-11ac8048-a071-48eb-a93a-d9f4680bbb40.png)

* GUID behind `alertRules`
> You can generate your own guid by powershell command new-guid and then fill it in the parts below accordingly
* displayName
> Modify the name displayed in sentinel portal

* Query

We may need the tool [JSON Escape / Unescape](https://www.freeformatter.com/json-escape.html#before-output) to fill the `query` part

Suppose your kql query is 
```kusto
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeASimAuditEvent') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);
let BuiltInDisabled=toscalar('ExcludeASimAuditEventBuiltIn' in (DisabledParsers) or 'Any' in (DisabledParsers)); 
union isfuzzy=true
  vimAuditEventEmpty, 
  ASimAuditEventMicrosoftExchangeAdmin365  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftExchangeAdmin365' in (DisabledParsers))),
  ASimAuditEventMicrosoftWindowsEvents  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftWindowsEvents' in (DisabledParsers))),
  ASimAuditEventAzureActivity  (BuiltInDisabled or ('ExcludeASimAuditEventAzureActivity' in (DisabledParsers)))
```

For existing KQL query, after `Escape` in the tool, the query would be
```
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeASimAuditEvent') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);\r\nlet BuiltInDisabled=toscalar('ExcludeASimAuditEventBuiltIn' in (DisabledParsers) or 'Any' in (DisabledParsers)); \r\nunion isfuzzy=true\r\n  vimAuditEventEmpty, \r\n  ASimAuditEventMicrosoftExchangeAdmin365  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftExchangeAdmin365' in (DisabledParsers))),\r\n  ASimAuditEventMicrosoftWindowsEvents  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftWindowsEvents' in (DisabledParsers))),\r\n  ASimAuditEventAzureActivity  (BuiltInDisabled or ('ExcludeASimAuditEventAzureActivity' in (DisabledParsers)))
```
![image](https://user-images.githubusercontent.com/96930989/212622538-a5f1ad6a-68d8-479e-9e7e-02c72c3cc225.png)

Then paste it into query part

For parameters "queryFrequency", "queryPeriod", "triggerOperator", "triggerThreshold", we can refer to

![image](https://user-images.githubusercontent.com/96930989/217118810-fbdd609e-3dc1-468e-b317-d6902d76409d.png)

Sample ARM template in my lab
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
            "id": "[concat(resourceId('Microsoft.OperationalInsights/workspaces/providers', parameters('workspace'), 'Microsoft.SecurityInsights'),'/alertRules/dea422bf-5ccc-4d77-b75d-5ba650da442e')]",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/dea422bf-5ccc-4d77-b75d-5ba650da442e')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "kind": "Scheduled",
            "apiVersion": "2022-11-01-preview",
            "properties": {
                "displayName": "Sentinel Alerts-test1",
                "description": "",
                "severity": "Medium",
                "enabled": true,
                "query": "Heartbeat \r\n| extend HostCustomEntity = Computer \r\n| extend IPCustomEntity = ComputerIP",
                "queryFrequency": "PT1H",
                "queryPeriod": "PT2H",
                "triggerOperator": "GreaterThan",
                "triggerThreshold": 0,
                "suppressionDuration": "PT5H",
                "suppressionEnabled": false,
                "tactics": [],
                "techniques": [],
                "alertRuleTemplateName": null,
                "incidentConfiguration": {
                    "createIncident": true,
                    "groupingConfiguration": {
                        "enabled": true,
                        "reopenClosedIncident": false,
                        "lookbackDuration": "PT5H",
                        "matchingMethod": "Selected",
                        "groupByEntities": [
                            "Host"
                        ],
                        "groupByAlertDetails": [],
                        "groupByCustomDetails": []
                    }
                },
                "eventGroupingSettings": {
                    "aggregationKind": "SingleAlert"
                },
                "alertDetailsOverride": null,
                "customDetails": null,
                "entityMappings": [
                    {
                        "entityType": "Host",
                        "fieldMappings": [
                            {
                                "identifier": "FullName",
                                "columnName": "HostCustomEntity"
                            }
                        ]
                    },
                    {
                        "entityType": "IP",
                        "fieldMappings": [
                            {
                                "identifier": "Address",
                                "columnName": "IPCustomEntity"
                            }
                        ]
                    }
                ],
                "sentinelEntitiesMappings": null
            }
        }
    ]
}
```

## (Optional) Use powershell to import ARM template

The commands are listed [here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-powershell#deployment-scope)

```powershell
Set-PSRepository PSGallery -InstallationPolicy Trusted
Set-ExecutionPolicy RemoteSigned
Install-Module Az
```

```powershell
Connect-AzAccount -TenantId <your tenant id>
Set-AzContext -Subscription <subscription id>
```

```powershell
New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateFile <path-to-template>
```

We need to import the template to resource group, you will be required to offer workspace when running the command

Please notice we need avoid the `^[-\w\._\(\)]+$` in TemplateFile, or we will meet the error

![image](https://user-images.githubusercontent.com/96930989/229139485-6455f0f9-3198-4411-856e-4993517e7a55.png)

Once the deployment succeeds, you will see the result

![image](https://user-images.githubusercontent.com/96930989/229139654-f764733c-0849-4b3f-b0fc-0ac012bd5b1e.png)

In my Lab, i export the existing analytics rule that contains entity mapping, custom details, alert details

![image](https://user-images.githubusercontent.com/96930989/229141669-1b2b6899-6144-4ab9-83ae-bcbd5d930c2b.png)

The exported json file looks like

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
            "id": "[concat(resourceId('Microsoft.OperationalInsights/workspaces/providers', parameters('workspace'), 'Microsoft.SecurityInsights'),'/alertRules/78ed052f-5779-4422-b34a-b568c3d7ed65')]",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/78ed052f-5779-4422-b34a-b568c3d7ed65')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "kind": "Scheduled",
            "apiVersion": "2022-09-01-preview",
            "properties": {
                "displayName": "heartbeatAR1",
                "description": "",
                "severity": "Medium",
                "enabled": true,
                "query": "Heartbeat\r\n| take 30",
                "queryFrequency": "PT5M",
                "queryPeriod": "PT5H",
                "triggerOperator": "GreaterThan",
                "triggerThreshold": 0,
                "suppressionDuration": "PT5H",
                "suppressionEnabled": false,
                "startTimeUtc": null,
                "tactics": [],
                "techniques": [],
                "alertRuleTemplateName": null,
                "incidentConfiguration": {
                    "createIncident": true,
                    "groupingConfiguration": {
                        "enabled": false,
                        "reopenClosedIncident": false,
                        "lookbackDuration": "PT5H",
                        "matchingMethod": "AllEntities",
                        "groupByEntities": [],
                        "groupByAlertDetails": [],
                        "groupByCustomDetails": []
                    }
                },
                "eventGroupingSettings": {
                    "aggregationKind": "SingleAlert"
                },
                "alertDetailsOverride": {
                    "alertDisplayNameFormat": "TestHeartbeatTitle",
                    "alertDescriptionFormat": "TestHeartbeatDescription",
                    "alertDynamicProperties": [
                        {
                            "alertProperty": "ConfidenceLevel",
                            "value": "Version"
                        },
                        {
                            "alertProperty": "ProductName",
                            "value": "Computer"
                        },
                        {
                            "alertProperty": "ProviderName",
                            "value": "OSName"
                        }
                    ]
                },
                "customDetails": {
                    "customdetails1": "Resource",
                    "customdetails2": "OSName",
                    "customdetails3": "OSType"
                },
                "entityMappings": [
                    {
                        "entityType": "Host",
                        "fieldMappings": [
                            {
                                "identifier": "HostName",
                                "columnName": "Computer"
                            }
                        ]
                    },
                    {
                        "entityType": "IP",
                        "fieldMappings": [
                            {
                                "identifier": "Address",
                                "columnName": "ComputerIP"
                            }
                        ]
                    },
                    {
                        "entityType": "Process",
                        "fieldMappings": [
                            {
                                "identifier": "CommandLine",
                                "columnName": "ResourceId"
                            }
                        ]
                    }
                ],
                "sentinelEntitiesMappings": null,
                "templateVersion": null
            }
        }
    ]
}
```

Then i modify the parametes below:
* Replace the GUID with the result generated from powershell command `new-guid`
* Change the **displayname** to `CustomARFromARM`
* Change the **query** to `Heartbeat\r\n| take 10`
* Change **alertDisplayNameFormat** to `CustomHeartbeatTitleFromARM`
* Change **ConfidenceLevel** to `Severity`
![image](https://user-images.githubusercontent.com/96930989/229144309-3269400c-7753-4168-ad31-ade436c932f5.png)
* Then i save it in a new json file named `CustomhearbeatARwithAllDetailsFromARM`

New json file looks like
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
            "id": "[concat(resourceId('Microsoft.OperationalInsights/workspaces/providers', parameters('workspace'), 'Microsoft.SecurityInsights'),'/alertRules/0a823c21-2a36-44ae-8139-7ab078197afe')]",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/0a823c21-2a36-44ae-8139-7ab078197afe')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "kind": "Scheduled",
            "apiVersion": "2022-09-01-preview",
            "properties": {
                "displayName": "CustomARFromARM",
                "description": "",
                "severity": "Medium",
                "enabled": true,
                "query": "Heartbeat\r\n| take 10",
                "queryFrequency": "PT5M",
                "queryPeriod": "PT5H",
                "triggerOperator": "GreaterThan",
                "triggerThreshold": 0,
                "suppressionDuration": "PT5H",
                "suppressionEnabled": false,
                "startTimeUtc": null,
                "tactics": [],
                "techniques": [],
                "alertRuleTemplateName": null,
                "incidentConfiguration": {
                    "createIncident": true,
                    "groupingConfiguration": {
                        "enabled": false,
                        "reopenClosedIncident": false,
                        "lookbackDuration": "PT5H",
                        "matchingMethod": "AllEntities",
                        "groupByEntities": [],
                        "groupByAlertDetails": [],
                        "groupByCustomDetails": []
                    }
                },
                "eventGroupingSettings": {
                    "aggregationKind": "SingleAlert"
                },
                "alertDetailsOverride": {
                    "alertDisplayNameFormat": "CustomHeartbeatTitle",
                    "alertDescriptionFormat": "TestHeartbeatDescription",
                    "alertDynamicProperties": [
                        {
                            "alertProperty": "Severity",
                            "value": "Version"
                        },
                        {
                            "alertProperty": "ProductName",
                            "value": "Computer"
                        },
                        {
                            "alertProperty": "ProviderName",
                            "value": "OSName"
                        }
                    ]
                },
                "customDetails": {
                    "customdetails1": "Resource",
                    "customdetails2": "OSName",
                    "customdetails3": "OSType"
                },
                "entityMappings": [
                    {
                        "entityType": "Host",
                        "fieldMappings": [
                            {
                                "identifier": "HostName",
                                "columnName": "Computer"
                            }
                        ]
                    },
                    {
                        "entityType": "IP",
                        "fieldMappings": [
                            {
                                "identifier": "Address",
                                "columnName": "ComputerIP"
                            }
                        ]
                    },
                    {
                        "entityType": "Process",
                        "fieldMappings": [
                            {
                                "identifier": "CommandLine",
                                "columnName": "ResourceId"
                            }
                        ]
                    }
                ],
                "sentinelEntitiesMappings": null,
                "templateVersion": null
            }
        }
    ]
}
```

Then we run the powershell commands below
```powershell
Set-PSRepository PSGallery -InstallationPolicy Trusted
Set-ExecutionPolicy RemoteSigned
Install-Module Az
```

```powershell
Connect-AzAccount -TenantId <your tenant id>
Set-AzContext -Subscription <subscription id>
```

```powershell
New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateFile <path-to-template>
```

```powershell
New-AzResourceGroupDeployment -ResourceGroupName TestARM -TemplateFile 'C:\temp\CustomhearbeatARwithAllDetailsFromARM.json'
```

The output shows the deployment is succeeded

![image](https://user-images.githubusercontent.com/96930989/229148532-924525fe-c712-4899-ad02-0b590a58555a.png)

Then we check the new analytics rule in the portal

![image](https://user-images.githubusercontent.com/96930989/229148822-cadff4c5-fe28-4568-9050-abea4450113b.png)

![image](https://user-images.githubusercontent.com/96930989/229148958-7cc64ded-137a-42a0-81c2-fcf13c173839.png)

It seems the alert details aren't modified

![image](https://user-images.githubusercontent.com/96930989/229150257-e2c80a6a-4ecd-4e77-9c72-f2f4187cc1c8.png)
