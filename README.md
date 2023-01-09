## Azure Sentinel FAQ

#### 1. When we try to open the data connectors page in sentinel, we get the error below.
![image](https://user-images.githubusercontent.com/96930989/211318356-9e6403e3-6856-4a7a-a71f-322d63cfb356.png)

Each time you open the data connectors page, sentinel runs backend queries for all the connectors configured, if something wrong happens in the query, then it is expected that you got the error in UI.

Though this error shows, but your data connectors are still sending the data to your workspace, normally the error in UI `will not` affect your production environment.

Possible reasons:
1. The volume of incoming data from specified data source is too high
2. Query timeout due to high volume of incoming data
3. Query fails due to wrong parameter defined

Troubleshooting steps:
1. Capture the `HAR` log when `refreshing` the data connector page
![image](https://user-images.githubusercontent.com/96930989/211319057-e6e73958-4476-4441-985e-f03d01a2c7fb.png)
2. In HAR log, look for the event whose `response` is "400"
3. Check the data connector mentioned in the "400" error separately and see if we meet the issue when running the query for this data source alone
4. Check the incoming volume of logs from the affected data source found in the HAR log
5. Check the time it takes to perform the query

