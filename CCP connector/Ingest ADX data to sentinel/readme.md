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
### Doc we refer to
* [REST API overview](https://learn.microsoft.com/en-us/kusto/api/rest/?view=microsoft-fabric)
* [Get an access token for a service principal using the Azure CLI](https://learn.microsoft.com/en-us/kusto/api/rest/authentication?view=microsoft-fabric#get-an-access-token-for-a-service-principal-using-the-azure-cli)
![image](https://github.com/user-attachments/assets/3c306471-f80a-49ad-ba49-53ea49c1452c)

## 6.Create custom table and DCR in UI


## 7.Get json of DCR and custom table schema


## 8.Fill in ARM template for CCP deployment

## 9.Connect data connector in sentinel

## 10.Verify connection
