# Solution for duplicated ingestion of syslog

## Symptom
You found CEF logs in the syslog table as well.


## Solution

1. Export existing **DCR used to collect syslog** to ARM template. Copy the json file to your clipboard, we need it later
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/85d927a1-3e26-470c-a64b-477352710bba)


2. In this json file, find the section `"dataFlows"`, add the part i highlighted **"transformKql": "source \r\n| where ProcessName !contains \"CEF\""**
 
Below is my sample:
```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "dataCollectionRules_syslog_AMA_name": {
            "defaultValue": "syslog-AMA-AvoidCEF",
            "type": "String"
        },
        "workspaces_gjsms400_sentinel1_externalid": {
            "defaultValue": "/subscriptions/dxxxxxxxxxxxxxxx/resourceGroups/gjs-sentinel/providers/Microsoft.OperationalInsights/workspaces/gjsms400-sentinel1",
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Insights/dataCollectionRules",
            "apiVersion": "2022-06-01",
            "name": "[parameters('dataCollectionRules_syslog_AMA_name')]",
            "location": "eastasia",
            "kind": "Linux",
            "properties": {
                "dataSources": {
                    "syslog": [
                        {
                            "streams": [
                                "Microsoft-Syslog"
                            ],
                            "facilityNames": [
                                "auth",
                                "authpriv",
                                "cron",
                                "daemon",
                                "mark",
                                "kern",
                                "local0",
                                "local1",
                                "local2",
                                "local3",
                                "local4",
                                "local5",
                                "local6",
                                "local7",
                                "lpr",
                                "mail",
                                "news",
                                "syslog",
                                "user",
                                "uucp"
                            ],
                            "logLevels": [
                                "Debug",
                                "Info",
                                "Notice",
                                "Warning",
                                "Error",
                                "Critical",
                                "Alert",
                                "Emergency"
                            ],
                            "name": "sysLogsDataSource-1688419672"
                        }
                    ]
                },
                "destinations": {
                    "logAnalytics": [
                        {
                            "workspaceResourceId": "[parameters('workspaces_gjsms400_sentinel1_externalid')]",
                            "name": "la-871196239"
                        }
                    ]
                },
                "dataFlows": [
                    {
                        "streams": [
                            "Microsoft-Syslog"
                        ],
                        "destinations": [
                            "la-871196239"
                        ],
                        "transformKql": "source \r\n| where ProcessName !contains \"CEF\""
                    }
                ]
            }
        }
    ]
}
```


3. Save the json file we modified

4. Deploy new DCR using the ARM template (the json file) we just configured.
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dcc5f95c-9cb6-4f30-8424-3949f5ee7aa0)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/14d4e5c2-1efb-426b-b8bb-49a78ffbc2fe)


Replace with the complete json we modified and save <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/cf83d912-9f51-4520-a1cb-7e93c2702a61)


Modify the name of new DCR <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c4248c88-0548-45bf-85aa-e0c1cddeef38)


5. Assign the new DCR to the forwarder server after deployment. Reboot the forwarder server to refresh the DCR assigned to it.

6. Then check if the duplicated ingestion issue still persists.
