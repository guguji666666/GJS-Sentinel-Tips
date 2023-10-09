# Stream Cloudflare events to Sentinel workspace
* [Integrate Cloudflare with Microsoft Sentinel](https://www.cloudflare.com/partners/technology-partners/microsoft/azure-sentinel/)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/fa4ba6ca-9f10-4bd8-91e3-bbb77805fab1)

* [Cloudflare (Preview) (using Azure Functions) connector for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/data-connectors/cloudflare-using-azure-functions)

## Deployment

### [Prerequisite to configure Logpush](https://developers.cloudflare.com/logs/about/)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/3e77448f-2424-42c2-bcef-96cea0f96142)

### 1. [Setup Cloudflare Logpush to Microsoft Azure](https://developers.cloudflare.com/logs/get-started/enable-destinations/)

Sample : stream to Azure storage account <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ade729af-0654-4f3a-aa04-e54d88509746)

Log in to the Cloudflare dashboard. <br>
Select the Enterprise account or domain you want to use with Logpush.<br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5d3cd9ba-2d47-414f-b33f-7cacdd7850a0)

Go to `Analytics & Logs > Logs`. <br>


Select Add Logpush job.

In Select data set, choose the dataset to push to a storage service, and select Next.

In Select data fields:

Select the data fields to include in your logs. Add or remove fields later by modifying your settings in Logs > Logpush.
In Advanced Settings, you can change the Timestamp format (RFC3339(default),Unix, or UnixNano), Sampling rate and enable redaction for CVE-2021-44228.
Under Filters you can select the events to include and/or remove from your logs. For more information, refer to Filters. Not all datasets have this option available.
In Select a destination, choose Microsoft Azure.

Enter or select the following destination information:

SAS URL
Blob container subpath (optional)
Daily subfolders
Select Validate access.

Enter the Ownership token (included in a file or log Cloudflare sends to your provider) and select Prove ownership. To find the ownership token, select Open in the Overview tab of the ownership challenge file.

Select Save and Start Pushing to finish enabling Logpush.

Once connected, Cloudflare lists Microsoft Azure as a connected service under Logs > Logpush. Edit or remove connected services from here.
