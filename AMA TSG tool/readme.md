# Capture AMA logs using troubleshooter tool

### 1. Download the troubleshooter bundle
```sh
mkdir AMATOOL
```
```sh
cd AMATOOL
```
```sh
wget  https://github.com/Azure/azure-linux-extensions/raw/master/AzureMonitorAgent/ama_tst/ama_tst.tgz
```
<img width="148" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/91762c90-97eb-4d84-8b43-cd7971effabf">

### 2. Unpack the bundle

```sh
tar -xzvf ama_tst.tgz
```

<img width="361" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/56fc5827-b186-46ab-aab6-16067e72b2b7">

### 3. Run the troubleshooter
```sh
sudo sh ama_troubleshooter.sh
```
<img width="545" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/465c918a-b5e0-466c-8984-797ad4f9839a"> <br>

<img width="412" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/02375707-c7b1-420f-afa6-5890cf75febb">
