## Capture AMA logs for troubleshooting

### 1. Log in the machine where the AMA is installed
### 2. launch `Task Manager` and verify if the below 5 processes are running.

<img width="374" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/aabc1e70-cb7b-4e62-ade5-17d76d59c795">

### 3. Run the PS script `CollectAMALogs.ps1` to capture AMA logs from the VM. The tool is installed by default with the agent under path
```
C:\Packages\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\<AMA_version_ installed>
```
  
Sample <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/3eb584e3-7d64-4e4a-8f54-5477c35af76f)

#### 1. launch powershell as administrator, then run the commands below:
```powershell
cd “C:\Packages\Plugins\Microsoft.Azure.Monitor.AzureMonitorWindowsAgent\<AMA_version_ installed>”
```
```powershell
. \CollectAMALogs.ps1
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a3e3030d-a3d8-400c-ad90-6e338548821b)

#### 2. Check the position of log file from the last row in the output. Normally, it will collect logs/files into `AMAFiles.zip` and save on your desktop as below.
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/451d5159-166f-4d77-81da-33f3ee465395)

#### 3. Please also share the log below with us

Azure VM 
```
C:\WindowsAzure\Resources
```
Sample <br>
<img width="777" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e6823fe5-9116-4a16-be81-b767f7e57b96">

Arc VM
```
C:\Resources\Directory\AMADataStore.****
```
Sample <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/3c52c2f3-01a3-45bc-95c8-325da99e31ba)
