# Ingest ADX data to sentinel workspace

## 1.Register Entra ID application
### 1.Follow the steps in [Quickstart: Register an application with the Microsoft identity platform](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app?tabs=certificate)

### 2.Add API permission below following doc [Create a Microsoft Entra application registration in Azure Data Explorer](https://learn.microsoft.com/en-us/azure/data-explorer/provision-entra-id-app?tabs=portal)
![image](https://github.com/user-attachments/assets/24460f3a-3fee-4baa-a9b8-8c3c93456884)

![image](https://github.com/user-attachments/assets/1d2d5fc1-5f3b-409b-9c53-c59fa5362fdd)

### 3.Follow doc to create client secret [Create client secret](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal#option-3-create-a-new-client-secret)

### 4.Grant access to ADX database using the app we just createad[Grant app access to the database](https://learn.microsoft.com/en-us/azure/data-explorer/provision-entra-id-app?tabs=portal#grant-a-service-principal-access-to-the-database)

### 4.Collect the information below
* Tenant id/Directory id
* Client id/Application id
* Client secret
![image](https://github.com/user-attachments/assets/296e1a19-e98c-4182-8410-d8da2cbb7390)


## 2.Create ADX cluster and database
### 1.Follow doc [Quickstart: Create an Azure Data Explorer cluster and database](https://learn.microsoft.com/en-us/azure/data-explorer/create-cluster-and-database?tabs=free)

### 2.


## 3.Create table in ADX table



## 4.Prepare empty ARM template for CCP deployment


## 5.Run query against ADX table to get sample API response

## 6.Create custom table and DCR in UI


## 7.Get json of DCR and custom table schema


## 8.Fill in ARM template for CCP deployment

## 9.Connect data connector in sentinel

## 10.Verify connection
