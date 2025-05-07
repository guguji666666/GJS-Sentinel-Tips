## 1. Workflow of logstash
![image](https://user-images.githubusercontent.com/96930989/213092655-8c7f49d1-aec3-4876-a76a-d2a1c2385f67.png)
* The logstash pipeline conguration file consists of three parts: inputs, filters, and outputs.
* Logstash checks the pipeline configuration files under path `/etc/logstash/conf.d/`, then handles the incoming data.


## 2. Deployment on Azure VM
* OS : Ubuntu 2204 LTS
* RAM 3G+ (recommended)
* Recommend `Standard B2s`

Note
```
You can keep the auto-provisioning setting on in the defender for cloud since mutiple DCR could be assigned to a single VM.
```

### Switch to root 
```sh
sudo su root
cd ~
```

### 1. Check current java version
```sh
java -version
```
![image](https://user-images.githubusercontent.com/96930989/213087596-73cd7809-a52b-4b6f-ab2d-ec434aba9b0b.png)

### 2. Install Java
```sh
apt install default-jre
```
Check java version again
```sh
java -version
```
![image](https://user-images.githubusercontent.com/96930989/213089641-47a075fc-b5f2-4b87-b99f-ef43d4eba729.png)


### 3. Add the GPG key to install signed packages
In order to make sure that you are getting official versions of Logstash, you have to download the public signing key and you have to install it.
```sh
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```
Install the apt-transport-https package
```sh
apt-get install apt-transport-https
```
Add the Elastic package repository to your own repository list
```sh
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
```

### 4. Install Logstash
```sh
apt-get update
```
```sh
apt-get install logstash
```

This directive will :
```
create a logstash user
create a logstash group
create a dedicated service file for Logstash
```

### 5. Check Logstash service health and start the service
```sh
systemctl status logstash
```
![image](https://user-images.githubusercontent.com/96930989/213091846-3b70fa00-cc8b-461a-8d8c-237769633a49.png)

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
![image](https://user-images.githubusercontent.com/96930989/213091935-d89b3f36-995c-4559-a49e-bf9e66d4d9fb.png)


### 6. Install `microsoft-sentinel-logstash-output-plugin`
```
In this step the RAM used may up to 2.6G
```
```
/usr/share/logstash/bin/logstash-plugin install microsoft-sentinel-logstash-output-plugin
```
![image](https://user-images.githubusercontent.com/96930989/217975482-2b3c7087-8e3b-4c04-9d74-274b46e40801.png)


### 7. Create sample file to ingest logs into the Custom table
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
  microsoft-sentinel-logstash-output-plugin {
    create_sample_file => true
    sample_file_path => "/tmp" #for example: "c:\\temp" (for windows) or "/tmp" for Linux. 
  }
}
```

### 8. Verify if the pipeline configuration works as expected
```
systemctl restart logstash
```
```
cd /tmp
```
```
ll
``` 
You should see the new sample files generated, `download` this file
![image](https://user-images.githubusercontent.com/96930989/217975380-35ff9cf2-61a3-4324-80d0-d8ddad7913a7.png)

Check this sample file
![image](https://user-images.githubusercontent.com/96930989/217975602-8ad51192-88d9-403c-a97a-cc88bcdbf0a0.png)
![image](https://user-images.githubusercontent.com/96930989/217975608-a8d73c10-9c27-4788-8bca-58430054f6a7.png)

### 9. [Create DCR resources for ingestion into a custom table](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules#create-dcr-resources-for-ingestion-into-a-custom-table)
#### 1. [Configure the application](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#configure-the-application)
##### Collect the information:
* tenant id
* app name
* app id (client id)
* client secret
#### 2. [Create data collection endpoint](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#create-a-data-collection-endpoint)
##### Collect the information:
* DCE name
* DCE Log ingestion URI
![image](https://user-images.githubusercontent.com/96930989/217995625-8a16f928-2aad-4ef4-9b6b-b5a4b8c7cf7b.png)

#### 3. Create a custom table in the workspace 
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

#### 4. [Collect information from DCR](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#collect-information-from-the-dcr)
* DCR name
* DCR immutableId
* DCR stream name
![image](https://user-images.githubusercontent.com/96930989/217995923-f3c9c9da-6347-4136-bf09-c049b0851874.png)

#### 5. Assign permission to DCR
```
This step is to give the application permission to use the DCR. Any application that uses the correct application ID and application key can now send data to the new DCE and DCR.
```
![image](https://user-images.githubusercontent.com/96930989/217984174-1ee6f384-6ad8-45ee-ad6f-95725bdcd9cc.png)
Skip the Send sample data step.

#### 6. Assign new DCR to the VM
![image](https://user-images.githubusercontent.com/96930989/217984223-fe06060e-1d9f-4e7c-b375-e2876caf7ef4.png)


### 10. [Configure Logstash configuration file](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules#configure-logstash-configuration-file)

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
  microsoft-sentinel-logstash-output-plugin {
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

```
systemctl restart logstash
``` 

Then wait for 10 mins and check the results in the workspace. If the configuration is correct you will see the output:
![image](https://user-images.githubusercontent.com/96930989/217994591-d8d67409-11c5-44f1-b275-6ebdc0aea3b8.png)


## 3. TSG steps
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
  microsoft-sentinel-logstash-output-plugin {
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

## 4. Other reference
### MS Doc
* [Use Logstash to stream logs with pipeline transformations via DCR-based API](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules)
* [Using Azure Sentinel with Logstash](https://www.youtube.com/watch?v=JnG1EvFmWkU)
* [microsoft-sentinel-logstash-output-plugin](https://github.com/guguji666666/MS-Sentinel-builtin-parsers/tree/master/DataConnectors/microsoft-sentinel-logstash-output-plugin)
* [microsoft-logstash-output-azure-loganalytics](https://github.com/guguji666666/MS-Sentinel-builtin-parsers/tree/master/DataConnectors/microsoft-logstash-output-azure-loganalytics)

### Install logstash
* [Use Logstash to stream logs with pipeline transformations via DCR-based API](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules)
* [How To Install Logstash on Ubuntu 18.04 and Debian 9](https://devconnected.com/how-to-install-logstash-on-ubuntu-18-04-and-debian-9/)
* [Elastic doc:Installing Logstash ](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html#_yum)


### Path of logstash config file

* Standard configuration files, that configures Logstash itself.
```
/etc/logstash/logstash.yml
```
* Pipeline configuration files
```
/etc/logstash/conf.d
```
* Create your own pipeline configuration file, we will fill the content later
```sh
cd /etc/logstash/conf.d/
```
```sh
cat > pipeline1.conf
```

### Lists all installed logstash plugins
```sh
cd ~
```
```sh
/usr/share/logstash/bin/logstash-plugin list 
```

You can also list installed plugins with version information
```sh
bin/logstash-plugin list --verbose
```

Updates all installed plugins
```sh
/usr/share/logstash/bin/logstash-plugin update
```

You can also update only the plugin you specify
```sh
/usr/share/logstash/bin/logstash-plugin update <name of plugin>
```

