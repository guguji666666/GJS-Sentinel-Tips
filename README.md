# 📘 Microsoft Sentinel Data Integration & Troubleshooting Guide

## 🔍 1. [Find Your Microsoft Sentinel Data Connectors and Tables](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors-reference#how-to-use-this-guide)

---

## 🔌 2. Connect Data Sources to Microsoft Sentinel

Before using analytics, ensure your logs are properly exported to the workspace. The following sources and connectors are commonly used:

### 🔷 Data Source Configuration Links

* [Configure Big Data Analytics for Azure Synapse](https://learn.microsoft.com/en-us/azure/sentinel/notebooks-with-synapse)
* [Send Azure Databricks Logs to Azure Monitor](https://learn.microsoft.com/en-us/azure/architecture/databricks-monitoring/application-logs)
* [Azure Storage Account Connector](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors/azure-storage-account)
* [Stream Microsoft Purview Logs](https://learn.microsoft.com/en-us/azure/sentinel/connect-microsoft-purview)
* [Enable Azure Functions Streaming Logs](https://learn.microsoft.com/en-us/azure/azure-functions/streaming-logs)
* [Stream Azure API Management Logs](https://techcommunity.microsoft.com/t5/microsoft-sentinel/azure-api-management-in-sentinel/m-p/952112)
* [Monitor Azure Logic Apps Workflows](https://learn.microsoft.com/en-us/azure/logic-apps/monitor-workflows-collect-diagnostic-data?tabs=consumption)
* [Monitor Azure Service Bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/monitor-service-bus-reference)
* [Monitor Azure Event Hubs](https://learn.microsoft.com/en-us/azure/event-hubs/monitor-event-hubs-reference)
* [Network Security Groups Connector](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors/network-security-groups)
* [Dynamics 365 Connector](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors/dynamics-365)
* [Monitor Azure SQL Managed Instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/monitoring-sql-managed-instance-azure-monitor?view=azuresql)
* [Analytics Rules Templates in GitHub](https://github.com/Azure/Azure-Sentinel/tree/master/Solutions)

---

## ❓ 3. Microsoft Sentinel FAQs

### 📌 Must-Reads Before Enabling Sentinel

* [Best Practices for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/best-practices)
* [Designing Sentinel or Defender for Cloud Workspace](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/best-practices-for-designing-a-microsoft-sentinel-or-azure/ba-p/832574)
* [What’s New: 250+ Solutions in Content Hub](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/what-s-new-250-solutions-in-microsoft-sentinel-content-hub/ba-p/3692881)

---

### ❓ Does Removing a Solution from Content Hub Also Remove Its Contents?

**No** — removing a solution only removes the solution entry itself. All deployed content (workbooks, rules, connectors) will remain in your workspace.

**Example: CrowdStrike Falcon Endpoint Protection**
![image](https://user-images.githubusercontent.com/96930989/212284641-77218147-2ecb-4067-a08d-2c944895bfad.png)

---

### 📊 [Microsoft Sentinel Service Limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#microsoft-sentinel-limits)

![image](https://user-images.githubusercontent.com/96930989/228762240-eb61c1af-c136-49d0-8397-0fd2fcadccdf.png)
![image](https://user-images.githubusercontent.com/96930989/228762265-28e9fce4-eceb-446f-bef8-a2d11a88a9db.png)

---

### 📈 [How to Check Free Trial Expiration](https://learn.microsoft.com/en-us/azure/sentinel/billing?tabs=free-data-meters#free-trial)

You can find this under `News & guides > Free trial` tab in the Sentinel portal:

![image](https://user-images.githubusercontent.com/96930989/212594442-78ac7919-8634-41db-9d50-099278938fd2.png)

---

## 📡 4. Troubleshooting Data Connector Errors

### ❗ UI Shows `"Unexpected error"` When Opening Data Connector Page

![image](https://user-images.githubusercontent.com/96930989/211318356-9e6403e3-6856-4a7a-a71f-322d63cfb356.png)

> Sentinel runs backend queries for all configured connectors when loading the page. If any query fails, this error may appear.

🔍 [View sample backend query](https://github.com/guguji666666/GJS-Sentinel-Tips/files/10422343/backend.query.txt)

**Note:** This UI error **does not** typically affect actual data ingestion.

### 🔍 Common Root Causes

1. High volume of incoming data
2. Query timeout
3. Misconfigured query parameters
4. Custom parser failures

### 🛠️ Troubleshooting Steps

1. Capture a [HAR log in Edge/Chrome](https://github.com/guguji666666/Logs-tracing#capture-har-logs-in-edgechrome) while refreshing the page
   ![image](https://user-images.githubusercontent.com/96930989/211319057-e6e73958-4476-4441-985e-f03d01a2c7fb.png)
2. Look for events with a `400` response
   ![image](https://user-images.githubusercontent.com/96930989/211438200-4f3d2f62-e365-45b4-854a-8c9d43007ae2.png)
3. Run the failing connector query in isolation
4. Examine the log volume from the data source
5. Measure query execution time for possible timeout

---

## 📚 API Reference

### Workspace and Saved Search APIs

* [🔹 List Workspaces](https://learn.microsoft.com/en-us/rest/api/loganalytics/workspaces/list?tabs=HTTP)
* [🔹 List Saved Searches by Workspace](https://learn.microsoft.com/en-us/rest/api/loganalytics/saved-searches/list-by-workspace?tabs=HTTP)
* [🔹 Get Saved Search](https://learn.microsoft.com/en-us/rest/api/loganalytics/saved-searches/get?tabs=HTTP)
* [🔹 Delete Saved Search](https://learn.microsoft.com/en-us/rest/api/loganalytics/saved-searches/delete?tabs=HTTP#code-try-0)

**Note:** `savedSearchId` refers to the **name** of the saved search.
![image](https://user-images.githubusercontent.com/96930989/212293144-47c00d16-40ae-408f-a798-c03f18bf5fa9.png)

---
