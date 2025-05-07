# 🔧 Installing `microsoft-sentinel-log-analytics-logstash-output-plugin` for Logstash

This guide helps you:

* ✅ Install **Logstash**
* ✅ Fetch only the Microsoft Sentinel output plugin (no full repo needed)
* ✅ Install the plugin into Logstash
* ✅ Use it in a working config

---

## ✅ Prerequisites

* Root or `sudo` access
* Internet access from the machine
* `java`, `git`, and `ruby` installed
* Logstash version 7.x or 8.x supported

---

## 🏗 Step 1: Install Logstash

### 🔹 For RHEL / CentOS / Rocky Linux

```bash
# Import Elastic GPG key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Create repo file
sudo tee /etc/yum.repos.d/logstash.repo <<EOF
[logstash]
name=Elastic repository for Logstash
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
enabled=1
autorefresh=1
type=rpm-md
EOF

# Install Logstash
sudo yum install logstash -y
```

---

### 🔹 For Ubuntu / Debian

```bash
# Install dependencies
sudo apt-get update && sudo apt-get install apt-transport-https gnupg -y

# Add Elastic GPG key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Add Logstash APT repo
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list

# Install Logstash
sudo apt-get update && sudo apt-get install logstash -y
```

![image](https://github.com/user-attachments/assets/b7ad2873-047e-47f0-b2dd-eb5845e2dfb1)

---

### 🔹 Verify Logstash Installed
Try to find the installed location:
```bash
dpkg -L logstash | grep bin/logstash
```
```bash
/usr/share/logstash/bin/logstash --version
```
![image](https://github.com/user-attachments/assets/b8353069-0afb-426f-bf55-4028bd9b0192)

---


### 🔹Start Logstash service
```sh
systemctl enable logstash
```

```sh
systemctl start logstash
```

Check the service state again
```sh
systemctl status logstash
```
![image](https://github.com/user-attachments/assets/bce10737-29cc-41f0-93ab-79dfc2b6491d)

---


## 🛠 Step 2: Install the Plugin

Installation
```bash
/usr/share/logstash/bin/logstash-plugin install microsoft-sentinel-log-analytics-logstash-output-plugin
```
![image](https://github.com/user-attachments/assets/9651ab79-fd1d-4b32-adac-c868bcecb417)


## ✅ Step 3: Verify Plugin Installation

```bash
/usr/share/logstash/bin/logstash-plugin list --verbose | grep sentinel
```
![image](https://github.com/user-attachments/assets/c075fb27-be35-47c8-bbf4-dd70d732c070)

---

## 📄 Step 4: Example Logstash Configuration 
```
cd /etc/logstash/conf.d
```
```
cat > pipeline.conf
```
copy the content below to pipeline.conf

```
input {
    generator {
          lines => [
               "This is a test log message from demo"
          ]
         count => 10
    }
}
output {
 microsoft-sentinel-log-analytics-logstash-output-plugin {
    create_sample_file => true
    sample_file_path => "/tmp" #for example: "c:\\temp" (for windows) or "/tmp" for Linux. 
  }
}
```
![image](https://github.com/user-attachments/assets/1604595e-6d7d-469c-b210-f9e267aeaade)

Verify if the pipeline configuration works as expected
```
systemctl restart logstash
```

```
cd /tmp && ls -al
``` 
You should see the new sample files generated, `download` one of the them, we need it later
![image](https://github.com/user-attachments/assets/b2a530a9-d004-4d1f-948b-581ce991947b)


Sample context
```json
[
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 7
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393961364Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 3
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.392715439Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 1
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.391903723Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 0
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.387581635Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 4
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393050546Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 6
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393661758Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 8
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.394569976Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 9
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.394891583Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 5
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393312451Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 2
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.392338331Z",
        "ls_version": "1"
    }
]
```
---


## ✅ Step 4: Create DCR, DCE and custom table

[Create DCR resources for ingestion into a custom table](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules#create-dcr-resources-for-ingestion-into-a-custom-table)

### 1. [Configure the application](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#configure-the-application)
##### Collect the information:
* tenant id
* app name
* app id (client id)
* client secret


### 2. [Create data collection endpoint](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#create-a-data-collection-endpoint)
##### Collect the information:
* DCE name
* DCE Log ingestion URI
![image](https://user-images.githubusercontent.com/96930989/217995625-8a16f928-2aad-4ef4-9b6b-b5a4b8c7cf7b.png)



### 3. Create a custom table in the workspace 
#### [Parse and filter sample data](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#parse-and-filter-sample-data)
![image](https://user-images.githubusercontent.com/96930989/217976554-c7fcf066-8d80-4299-99c7-13db378fcb4f.png)
![image](https://user-images.githubusercontent.com/96930989/217976584-99ad21cb-6608-45dc-8f75-665ba077455e.png)

Modify the KQL query
```kusto
source
| extend TimeGenerated = ls_timestamp
```
![image](https://user-images.githubusercontent.com/96930989/217982753-7ae92e05-efca-441a-92c6-394147e37f97.png)
![image](https://user-images.githubusercontent.com/96930989/217982769-d31c11f7-4e37-4c78-b1cf-76b08805bead.png)
Then save the results

![image](https://user-images.githubusercontent.com/96930989/217982794-109104b1-be56-4333-9d71-7cf70b050d80.png)

### 4. [Collect information from DCR](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#collect-information-from-the-dcr)
* DCR name
* DCR immutableId
* DCR stream name
![image](https://user-images.githubusercontent.com/96930989/217995923-f3c9c9da-6347-4136-bf09-c049b0851874.png)

### 5. Assign permission to DCR
```
This step is to give the application permission to use the DCR. Any application that uses the correct application ID and application key can now send data to the new DCE and DCR.
```
![image](https://user-images.githubusercontent.com/96930989/217984174-1ee6f384-6ad8-45ee-ad6f-95725bdcd9cc.png)
Skip the Send sample data step.

### 6. Assign new DCR to the VM
![image](https://user-images.githubusercontent.com/96930989/217984223-fe06060e-1d9f-4e7c-b375-e2876caf7ef4.png)


## ✅ Step 5: Configure full logstash configuration file

[Configure Logstash configuration file](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules#configure-logstash-configuration-file)

#### Information required
* Tenant id
* App id (client id)
* client secret
* DCE Logs ingestion URI
* DCR immutable ID
* DCR stream name

Run the commands below
```
cd /etc/logstash/conf.d
```

```
rm pipeline.conf
```

```
cat > pipeline1.conf
```

New pipeline configuration file should be in the format below

```
input {
    generator {
          lines => [
               "This is a test log message from demo"
          ]
         count => 10
    }
}
output {
  microsoft-sentinel-log-analytics-logstash-output-plugin {
    client_app_Id => "<enter your client_app_id value here>"
    client_app_secret => "<enter your client_app_secret value here>"
    tenant_id => "<enter your tenant id here> "
    data_collection_endpoint => "<enter your DCE logsIngestion URI here> "
    dcr_immutable_id => "<enter your DCR immutableId here> "
    dcr_stream_name => "<enter your stream name here> "
    create_sample_file=> false
    sample_file_path => "/tmp"
  }
}
```

bash
```
systemctl restart logstash
``` 

Then wait for 10 mins and check the results in the workspace. If the configuration is correct you will see the output:
![image](https://user-images.githubusercontent.com/96930989/217994591-d8d67409-11c5-44f1-b275-6ebdc0aea3b8.png)


---

## ✅ TSG steps
If cx fails to find the incoming log in the custom table, we could then follow the steps below
1. Check if DCR is assigne to the VM and DCE is selected
![image](https://user-images.githubusercontent.com/96930989/221455738-e43af103-4b5b-4278-b426-047b52ab9b46.png)

2. Check if the desination is the custom table in the workspace with sentinel enabled
![image](https://user-images.githubusercontent.com/96930989/221455636-0bbd3c78-9cd5-4029-80ef-62e4cba063dd.png)

3. Check the schema of the custom table (we may need it if we want to invole the Azure monitoring team later)
![image](https://user-images.githubusercontent.com/96930989/221455924-a64d3ce8-9135-4320-8a40-8184ef1f3e13.png)
![image](https://user-images.githubusercontent.com/96930989/221455946-88d7e80b-248f-4481-8f1d-7dd60d5ff684.png)

We can also check the transfrom KQL in DCR > json view <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e1f70af5-a07b-4d28-941f-55a50cc19ccd)

4. Check the state of logstash service on VM
Run command
```sh
systemctl status logstash
```
![image](https://user-images.githubusercontent.com/96930989/213091935-d89b3f36-995c-4559-a49e-bf9e66d4d9fb.png)

Reinstall logstash running commmands
```sh
apt-get install logstash

systemctl enable logstash

systemctl start logstash
```
* If the logstash service could run successfully after reinstallation, we continue troubleshooting
* If the logstash service can't run successfully, we'd suggest cx to involve the enginner from logstash team

5. Check the parameters configured in the pipeline file
* Tenant id
* App id (client id)
* client secret
* DCE Logs ingestion URI
* DCR immutable ID
* DCR stream name

6. Create a backup of the current pipeline file, remove it and create a test piepeline file
```
input {
    generator {
          lines => [
               "This is a test log message from demo"
          ]
         count => 10
    }
}
output {
  microsoft-sentinel-log-analytics-logstash-output-plugin {
    create_sample_file => true
    sample_file_path => "/tmp" #for example: "c:\\temp" (for windows) or "/tmp" for Linux. 
  }
}
```
Then run the command and see if the sample logs could be generated 
```
systemctl restart logstash
```
* If the sample logs couldn't be generated, we'd suggest cx to involve the enginner from logstash team since the logstash service is not working properly
* If the sample logs could be generated and the parameters in the pipeline configuration file are verified, we'd suggest to involve Azure monitoring team for further investigation

## 🔗 References

* [Microsoft Sentinel Plugin](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin)
* [Logstash Plugin Dev Guide](https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html)
* [DownGit (Download GitHub folder)](https://minhaskamal.github.io/DownGit/)

---
