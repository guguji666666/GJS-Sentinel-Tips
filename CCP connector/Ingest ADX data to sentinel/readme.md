# Ingest ADX data to sentinel workspace

## 1.Create ADX cluster and database
### Follow doc [Quickstart: Create an Azure Data Explorer cluster and database](https://learn.microsoft.com/en-us/azure/data-explorer/create-cluster-and-database?tabs=free)

## 2.Register Entra ID application
### 1.Follow the steps in [Quickstart: Register an application with the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app?tabs=certificate)

### 2.Add API permission below following doc [Create a Microsoft Entra application registration in Azure Data Explorer](https://learn.microsoft.com/en-us/azure/data-explorer/provision-entra-id-app?tabs=portal)
![image](https://github.com/user-attachments/assets/24460f3a-3fee-4baa-a9b8-8c3c93456884)

![image](https://github.com/user-attachments/assets/1d2d5fc1-5f3b-409b-9c53-c59fa5362fdd)

### 3.Follow doc to create client secret [Create client secret](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal#option-3-create-a-new-client-secret)

### 4.Grant access to ADX database using the app we just createad[Grant app access to the database](https://learn.microsoft.com/en-us/azure/data-explorer/provision-entra-id-app?tabs=portal#grant-a-service-principal-access-to-the-database)

### 5.Collect the information below
* Tenant id/Directory id
* Client id/Application id
* Client secret
![image](https://github.com/user-attachments/assets/296e1a19-e98c-4182-8410-d8da2cbb7390)


## 3.Create table in ADX table
### Follow doc [Create a table in Azure Data Explorer](https://learn.microsoft.com/en-us/azure/data-explorer/create-table-wizard)


## 4.Prepare empty ARM template for CCP deployment
### Download the empty template [here](https://github.com/guguji666666/GJS-Sentinel-Tips/blob/main/CCP%20connector/Empty%20ARM%20template%20for%20CCP%20connector.json) and open it in vscode


## 5.Run query against ADX table to get sample API response
### 1.Doc we refer to
* [REST API overview](https://learn.microsoft.com/en-us/kusto/api/rest/?view=microsoft-fabric)
* [Get an access token for a service principal using the Azure CLI](https://learn.microsoft.com/en-us/kusto/api/rest/authentication?view=microsoft-fabric#get-an-access-token-for-a-service-principal-using-the-azure-cli)
![image](https://github.com/user-attachments/assets/3c306471-f80a-49ad-ba49-53ea49c1452c)

### 2.Download [postman](https://www.postman.com/downloads/) or [bruno](https://www.usebruno.com/downloads)

### 3.Run query agains ADX table via REST API

#### Get token first
```sh
curl -X POST https://login.microsoftonline.com/<tenantId>/oauth2/token -F grant_type=client_credentials -F client_id=<appId> -F client_secret=<password> -F resource=https://api.kusto.windows.net
```

#### Run in Bruno
* Methond: `POST`
* API endpoint: `https://(your adx clsuter url)/v2/rest/query`
* Body
```json
{
    "db": "<ADX database>",
    "csl": "<table name in ADX database | <KQL query> >",
    "properties": {
        "Options": {
            "servertimeout": "00:04:00",
            "queryconsistency": "strongconsistency",
            "query_language": "csl",
            "request_readonly": false,
            "request_readonly_hardline": false
        }
    }
}
```

#### Sample response
![image](https://github.com/user-attachments/assets/0ad2c6c0-86a2-407e-99e8-888a4cab0352)


### 4.Save sample response as `adx_api_response.json`, we need it later.

## 6.Create custom table and DCR in UI
![image](https://github.com/user-attachments/assets/1eb4a1bd-bb13-4884-9593-cc651c61caf1)

Fill in custom table name, new DCR name, DCE name <br>
![image](https://github.com/user-attachments/assets/a061d077-43d5-48a9-9d79-fc44a23fa204)

Upload the `adx_api_response.json` we collected <br>
![image](https://github.com/user-attachments/assets/22329e93-568e-4f08-99d4-481437e4a268)

Modify `Transformation editor` here <br>
![image](https://github.com/user-attachments/assets/9e963903-09f3-4997-8b6b-28b3439dd143)

Smaple KQL
```kusto
source | extend TimeGenerated = now()
```
![image](https://github.com/user-attachments/assets/3881a9ea-30e1-4875-b670-8dc7dde55f8e)

Go ahead and complete deployment of custom table and DCR

## 7.Get json of DCR and custom table schema
#### 1.Refer to doc [Tables - Get](https://learn.microsoft.com/en-us/rest/api/loganalytics/tables/get?view=rest-loganalytics-2023-09-01&tabs=HTTP)
#### 2.Save API response to `Custom_Table_Schema.json`

## 8.Fill in ARM template for CCP deployment
#### Downdload ARM template for CCP with ADX integration [here](https://github.com/guguji666666/GJS-Sentinel-Tips/blob/main/CCP%20connector/Ingest%20ADX%20data%20to%20sentinel/ARM_ADX_Template.json), i add the comments to the parts we shoukd pay attention to.

## 9.Connect data connector in sentinel
![image](https://github.com/user-attachments/assets/089440f0-ec73-4e14-83c6-4420d2303dc7)

## 10.Verify connection
![image](https://github.com/user-attachments/assets/f70c38cf-65b8-4d0b-8fb0-3c5b536b0df8)

