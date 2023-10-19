# Stream sysmon logs to workspace using DCR

## Install sysmon packages
## 1. Install [sysmon](https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon)
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/07a32dc2-1793-4df7-bee7-6a0caf901a84)

```sh
cd <path where you installed sysmon
```

```sh
sysmon64 -i
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/bd462e5d-08ab-4960-8a58-c66e42423d0b)

```sh
sysmon64 -m
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/6c722b2d-a717-44ea-bec5-e17ce63b734e)

## 2. Reboot the server
## 3. Check the logs under `Applications and Services Logs > Microsoft > Windows > Sysmon` in event viewer.
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/91e89f9b-3e56-4858-b10b-6e34a649f312)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/4f8caf2f-e983-4778-9109-d8a663b33aaa)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/7fa8a860-19ba-4109-b589-a99caf329d83)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/566be5eb-d8a1-460e-a968-da48d70afa77)

```
<QueryList>
  <Query Id="0" Path="Microsoft-Windows-Sysmon/Operational">
    <Select Path="Microsoft-Windows-Sysmon/Operational">*[System[(Level=1  or Level=2 or Level=3 or Level=4 or Level=0 or Level=5)]]</Select>
  </Query>
</QueryList>
```

## 4. Verify log path before configuring DCR
```powershell
$XPath = '*[System[(Level=1  or Level=2 or Level=3 or Level=4 or Level=0 or Level=5)]]' 
Get-WinEvent -LogName 'Microsoft-Windows-Sysmon/Operational' -FilterXPath $Xpath
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f01de778-d0f5-4dd4-a663-4c6cdedbf8e2)

Once the log path is verified to be valid, add it to DCR, format `LogName!XPathQuery`

## Configure DCR
DCR of sysmon log would be 
```
Microsoft-Windows-Sysmon/Operational!*[System[(Level=1  or Level=2 or Level=3 or Level=4 or Level=0 or Level=5)]]
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5eaf4453-ff2a-4b03-9439-177bb9eb05be)

## Verify the data ingestion

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/bbd0530e-9b4d-4188-a0d0-3ad95242ad29)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ea4f5224-fad3-43eb-9660-a44c5e30d50b)




