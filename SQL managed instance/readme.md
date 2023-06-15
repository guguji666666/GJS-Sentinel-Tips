## Connect SQL managed instance to sentinel

For SQL managed instance, we could follow the doc [Configure streaming export of Azure SQL Database and SQL Managed Instance diagnostic telemetry](https://learn.microsoft.com/en-us/azure/azure-sql/database/metrics-diagnostic-telemetry-logging-streaming-export-configure?view=azuresql&tabs=azure-portal)to export the logs to workspace via diagnostic settings. 
Once the logs are ingested to the workspace, we can then test on the analytics rule.

Similarly, we also have built-in templates in analytics rule. <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/61deedce-807c-4be2-b90d-752bca0be5b2)
