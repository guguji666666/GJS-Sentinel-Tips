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
## Deployment on on-prem VM running Ubuntu 2204 LTS
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

### 6. Check if Logstash is actually listening on its default port 5044.
```sh
lsof -i -P -n | grep logstash
```
```sh
lsof -i -P -n
```
![image](https://user-images.githubusercontent.com/96930989/213092524-3c73fafe-9002-41ab-87b4-fcf0bf45ac93.png)

### 7. Check logstash config file
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


### 8. Install `microsoft-sentinel-logstash-output-plugin`
https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html

1. Lists all installed plugins
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

2. Updates all installed plugins
```sh
/usr/share/logstash/bin/logstash-plugin update
```

You can also update only the plugin you specify
```sh
/usr/share/logstash/bin/logstash-plugin update <name of plugin>
```

3. Install microsoft-sentinel-logstash-output-plugin
```sh
/usr/share/logstash/bin/logstash-plugin install microsoft-sentinel-logstash-output-plugin
```
![image](https://user-images.githubusercontent.com/96930989/213118865-6754a9fd-d1b5-4f3e-91a5-31319cef8df4.png)

### 9. Create pipeline conf for custom log (we will need it later when configuring DCR)
* [Elastic doc:Logstash configuration files](https://www.elastic.co/guide/en/logstash/current/config-setting-files.html)
* [Sample for complete pipeline file](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-logstash-output-plugin#complete-example)
```
You create pipeline configuration files when you define the stages of your Logstash processing pipeline. 
On deb and rpm, you place the pipeline configuration files in the /etc/logstash/conf.d directory. 
Logstash tries to load only files with .conf extension in the /etc/logstash/conf.d directory and ignores all other files.
```

```sh
cd /etc/logstash/conf.d
```

```sh
vi pipeline1.conf
```

Paste the context below to pipeline1.conf
```sh
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
![image](https://user-images.githubusercontent.com/96930989/213140070-4c6c8314-07d7-41dd-a85a-386d6c00eb42.png)

### 10. Verify if the pipeline works as expected
Restart the service to load the new pipline config file
```sh
systemctl restart logstash
```
The following sample file will be generated under `/tmp`

```sh
cd /tmp
```
```sh
ll
```
![image](https://user-images.githubusercontent.com/96930989/213141866-432c8732-c89c-4834-90da-4b6685a85652.png)

If we check the sample file inside
![image](https://user-images.githubusercontent.com/96930989/213159563-66949058-cd53-4285-856f-32e6a05b835b.png)

### 11. Create DCR related resources for ingestion into a `custom` table
[Create the required DCR resources](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules#create-the-required-dcr-resources)
* Configure the application
* Create a data collection endpoint
* Add a custom log table
* Parse and filter sample data using the sample file you created in the previous section
* Collect information from the DCR
* Assign permissions to the DCR


Replace the content in `pipeline1.conf` following the format

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
### 12. Connect your on-prem VM to Arc
[Generate the script and run it on your VM](https://learn.microsoft.com/en-us/azure/azure-arc/servers/learn/quick-enable-hybrid-vm#generate-installation-script)

![image](https://user-images.githubusercontent.com/96930989/213164283-31309c9a-66cd-4110-8500-9220f38dd548.png)

### 13. Restart logstesh service and check the logs ingestion
```sh
systemctl restart logstash
```
The name of the custom table i created is `customlogstash_CL`
![image](https://user-images.githubusercontent.com/96930989/213165872-6b71d1fe-e520-4ec7-8b6b-80f274dd7a93.png)

Check if the AMA has been installed successfully and heartbeat
![image](https://user-images.githubusercontent.com/96930989/213171055-2579d00d-2be4-4fab-9c96-411277e8abf6.png)

Assign the new DCR and DCE we created to the new Arc-enabled VM
![image](https://user-images.githubusercontent.com/96930989/213172622-c45ef747-8ad3-4648-850a-e4f36ae9d9d3.png)

