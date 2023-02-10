# Configure Logstash plugin and collect the logs via AMA
Links for reference:
* [Use Logstash to stream logs with pipeline transformations via DCR-based API](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules)
* [Using Azure Sentinel with Logstash](https://www.youtube.com/watch?v=JnG1EvFmWkU)
* [microsoft-sentinel-logstash-output-plugin](https://github.com/guguji666666/MS-Sentinel-builtin-parsers/tree/master/DataConnectors/microsoft-sentinel-logstash-output-plugin)
* [microsoft-logstash-output-azure-loganalytics](https://github.com/guguji666666/MS-Sentinel-builtin-parsers/tree/master/DataConnectors/microsoft-logstash-output-azure-loganalytics)

## Install logstash (must read)
* [Use Logstash to stream logs with pipeline transformations via DCR-based API](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules)
* [How To Install Logstash on Ubuntu 18.04 and Debian 9](https://devconnected.com/how-to-install-logstash-on-ubuntu-18-04-and-debian-9/)
* [Elastic doc:Installing Logstash ](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html#_yum)

Note
```
You can keep the auto-provisioning setting on in the defender for cloud since mutiple DCR could be assigned to a single VM.
```

## Deployment on Azure VM running Ubuntu 2204 LTS
* RAM 3G+
* recommend `Standard B2s`

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

```
This directive will :
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


### Path of logstash config file
* Workflow of logstash
  ![image](https://user-images.githubusercontent.com/96930989/213092655-8c7f49d1-aec3-4876-a76a-d2a1c2385f67.png)

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

### Lists all installed plugins
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
* app od
* client secret
#### 2. [Create data collection endpoint](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#create-a-data-collection-endpoint)
##### Collect the information:
* DCE name
* Log ingestion URI
#### 3. Create a custom table in the workspace 
#### [Parse and filter sample data](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#parse-and-filter-sample-data)
![image](https://user-images.githubusercontent.com/96930989/217976554-c7fcf066-8d80-4299-99c7-13db378fcb4f.png)
![image](https://user-images.githubusercontent.com/96930989/217976584-99ad21cb-6608-45dc-8f75-665ba077455e.png)


#### 4. 

