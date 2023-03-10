## Microsoft Sentinel FAQ

#### Must read before you enable sentinel
* [Best practices for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/best-practices)
* [Best practices for designing a Microsoft Sentinel or Azure Defender for Cloud workspace](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/best-practices-for-designing-a-microsoft-sentinel-or-azure/ba-p/832574)
* [What’s New: 250+ Solutions in Microsoft Sentinel Content hub!](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/what-s-new-250-solutions-in-microsoft-sentinel-content-hub/ba-p/3692881)

#### 1. When we try to open the data connectors page in sentinel, we get the `"Unexpected error"`
![image](https://user-images.githubusercontent.com/96930989/211318356-9e6403e3-6856-4a7a-a71f-322d63cfb356.png)

Each time you open the data connectors page, sentinel runs backend queries for all the connectors configured, if something wrong happens in the query, then it is expected that you got the error in UI.

Context in the query
[backend query.txt](https://github.com/guguji666666/GJS-Sentinel-Tips/files/10422343/backend.query.txt)


Though this error shows, your data connectors are still sending the data to your workspace, normally the error in UI `will not` affect your production environment.

Possible reasons:
1. The volume of incoming data from specified data source is too high
2. Query timeout due to high volume of incoming data
3. Query fails due to wrong parameter defined
4. Custom parsers failed

Troubleshooting steps:
1. Capture the `HAR` log following the steps [Capture HAR logs in Edge/Chrome](https://github.com/guguji666666/Logs-tracing#capture-har-logs-in-edgechrome) when `refreshing` the data connector page
![image](https://user-images.githubusercontent.com/96930989/211319057-e6e73958-4476-4441-985e-f03d01a2c7fb.png)
2. In HAR log, look for the event whose `response` is "400"
![image](https://user-images.githubusercontent.com/96930989/211438200-4f3d2f62-e365-45b4-854a-8c9d43007ae2.png)
3. Check the data connector mentioned in the "400" error separately and see if we meet the issue when running the query for this data source `alone`
4. Check the `volume` of incoming logs from the affected data source found in the HAR log
5. Check the `time` it takes to perform the query


#### 2. When uninstalling the solution from content hub, will the contents be removed as well?
NO, only the solution is removed, the contents deployed by it will not be removed

Sample for `CrowdStrike Falcon Endpoint Protection`
![image](https://user-images.githubusercontent.com/96930989/212284641-77218147-2ecb-4067-a08d-2c944895bfad.png)

## API reference:
* [List workspaces under subscription](https://learn.microsoft.com/en-us/rest/api/loganalytics/workspaces/list?tabs=HTTP)
* [Saved Searches - List By Workspace](https://learn.microsoft.com/en-us/rest/api/loganalytics/saved-searches/list-by-workspace?tabs=HTTP)
* [Saved Searches - Get](https://learn.microsoft.com/en-us/rest/api/loganalytics/saved-searches/get?tabs=HTTP)
* [Saved Searches - Delete](https://learn.microsoft.com/en-us/rest/api/loganalytics/saved-searches/delete?tabs=HTTP#code-try-0)

Please notice that the `savedSearchId` is the name here
![image](https://user-images.githubusercontent.com/96930989/212293144-47c00d16-40ae-408f-a798-c03f18bf5fa9.png)

#### 3. How to check the expiration time of Sentinel free trial?
As mentioned in the doc [Sentinel free trial](https://learn.microsoft.com/en-us/azure/sentinel/billing?tabs=free-data-meters#free-trial), the expiration time could be found under `News & guides > Free trial` tab in Microsoft Sentinel.

![image](https://user-images.githubusercontent.com/96930989/212594442-78ac7919-8634-41db-9d50-099278938fd2.png)

