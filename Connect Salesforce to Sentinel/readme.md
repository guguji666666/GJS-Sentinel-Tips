## Salesforce Service Cloud (using Azure Function) connector for Microsoft Sentinel

### Reference
* [Connect Salesforece service cloud to Sentinel using Azure function app](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors/salesforce-service-cloud-using-azure-function)

* [Quick start from salesforce](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/quickstart.htm)

#### From salesforce
1. [Step One: Sign up for Salesforce Developer Edition](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/quickstart_dev_org.htm)

2. [Step Two: Set Up Authentication](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/quickstart_oauth.htm)

[Install Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.242.0.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm)

[Get an Access Token with Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/quickstart_oauth.htm)

Run powershell command
```powershell
sfdx auth:web:login
```
