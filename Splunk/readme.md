## Connect Splunk to Sentinel

### Reference [How to export data from Splunk to Azure Sentinel](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/how-to-export-data-from-splunk-to-azure-sentinel/ba-p/1891237)

## Start Deployment
#### 1. Deploy Splunk Enterprise
We can choose to [Install on Linux](https://docs.splunk.com/Documentation/Splunk/9.0.4/Installation/InstallonLinux) or [Deploy and run Splunk Enterprise inside a Docker container](https://docs.splunk.com/Documentation/Splunk/8.0.5/Installation/DeployandrunSplunkEnterpriseinsideDockercontainers)

#### 2. If you run Splunk in the docker, we can verify it by running command `docker ps`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/40873131-6552-4f40-aa8e-cd0ed3ed5218)

#### 3. Enter the splunk server by typing [IP of your splunk server]:(Expose port you set in docker container)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/6b1db5fd-8711-4f6a-88f9-5cf74872b120)

#### 4. Install Sentinel Add-On
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/999a3550-4ca9-4eee-9db0-f8ff25bc4c73)

#### 5. Configure sending alerts to sentinel
Input `index="_audit"`here, this query to to check the audit logs in Splunk
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e6772e32-1bec-4d0c-b22f-13fafad440c7)

Save as Alerts <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1c9f1785-c7fd-49fa-bb8b-575c8d3673a5)

Specify the following values for the fields in the Save As Alert dialog box.
* Title: Audit logs in the last 24 hours
* Alert type: Scheduled
* Time Range: Run every hour (you can also customized the frequency)
* Trigger condition: Number of Results is greater than 0
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/fd27c067-14d9-46d6-a725-35e62cdcc376)

Select the Send to Microsoft Sentinel alert action <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/00f236a6-02fc-493f-9c47-9b861cc2a964)

Fill in the required parameters as shown in the diagram below
* Customer_id: Azure Sentinel Log Analytics Workspace ID
* Shared_key: Azure Sentinel Log Analytics Primary Key
* Log_Type: Azure Sentinel custom log name : `Splunk_Audit_Events`

Wait for 3 hours, then verify the logs are received in the workspace table `Splunk_Audit_Events_CL`
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/883e056e-0fc6-4bec-bdc5-51f0b98c3b3c)

#### 6. Then you can create scheduled analytics rule to trigger incidents in Sentinel
For example, KQL query used in the analytics rule <br>
```kusto
Splunk_Audit_Events_CL
| where action_s contains "PASSWORD"
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a727e113-cb12-404a-8aa6-b81c88ffc58e)
