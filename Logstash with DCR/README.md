# Logstash with DCR configuration

Link for reference:

https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules

https://www.youtube.com/watch?v=JnG1EvFmWkU


## microsoft-sentinel-logstash-output-plugin
https://github.com/guguji666666/MS-Sentinel-builtin-parsers/tree/master/DataConnectors/microsoft-sentinel-logstash-output-plugin

## microsoft-logstash-output-azure-loganalytics
https://github.com/guguji666666/MS-Sentinel-builtin-parsers/tree/master/DataConnectors/microsoft-logstash-output-azure-loganalytics

## Install logstash
https://devconnected.com/how-to-install-logstash-on-ubuntu-18-04-and-debian-9/
https://www.elastic.co/guide/en/logstash/current/installing-logstash.html#_yum

## 1. Check java version
```sh
java -version
```
![image](https://user-images.githubusercontent.com/96930989/210304941-0cb6d6fa-8867-49a0-9179-a56538c60a76.png)

## 2. Install Java

```sh
sudo apt-get install default-jre
```

## 3. Add the GPG key to install signed packages

```sh
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```
```sh
sudo apt-get install apt-transport-https
```
```sh
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
```
![image](https://user-images.githubusercontent.com/96930989/210305007-6b825902-d188-4285-bee5-79ca822b2f9f.png)

## 4. Install Logstash with apt
```sh
sudo apt-get update
sudo apt-get install logstash
```
![image](https://user-images.githubusercontent.com/96930989/210305033-38cc80e6-310e-41d4-b41f-7e8ce1faeec9.png)

```
This directive will :
create a logstash user
create a logstash group
create a dedicated service file for Logstash
```

## 5. Check Logstash service health and start the service
```sh
sudo systemctl status logstash
```
![image](https://user-images.githubusercontent.com/96930989/210305092-b87aed4a-77fa-423d-9b7e-283dd9bcd32c.png)

```sh
sudo systemctl enable logstash
```

```sh
sudo systemctl start logstash
```
![image](https://user-images.githubusercontent.com/96930989/210305107-bdc66df1-bbc5-4bb6-b9db-761b767dc059.png)

Check the service state again
```sh
sudo systemctl status logstash
```
![image](https://user-images.githubusercontent.com/96930989/210305119-4fdec2d4-2e38-4210-8278-ca5be29f68c6.png)

## 6. Check if Logstash is actually listening on its default port 5044.
```sh
sudo lsof -i -P -n | grep logstash
```

## 7. Check logstash config file
* Standard configuration files, that configures Logstash itself.
```
/etc/logstash/logstash.yml
```
* Writing your own pipeline configuration file
```sh
cd /etc/logstash/conf.d/
```
```sh
sudo vi syslog.conf
```

* Pipeline configuration files
```
/etc/logstash/conf.d directory
```

## 8. Install microsoft-sentinel-logstash-output-plugin
https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html

* Lists all installed plugins
```sh
sudo /usr/share/logstash/bin/logstash-plugin list 
```

* Lists installed plugins with version information
```sh
bin/logstash-plugin list --verbose
```

* Updates all installed plugins
```sh
sudo /usr/share/logstash/bin/logstash-plugin update
```

* Updates only the plugin you specify
```sh
sudo /usr/share/logstash/bin/logstash-plugin update <name of plugin>
```

* Install microsoft-sentinel-logstash-output-plugin
```sh
sudo /usr/share/logstash/bin/logstash-plugin install microsoft-sentinel-logstash-output-plugin
```
![image](https://user-images.githubusercontent.com/96930989/210309117-af8ebd3c-c9f1-4a15-9423-497bece59cc3.png)

## 9. Create sample pipeline conf

```
https://www.elastic.co/guide/en/logstash/current/config-setting-files.html
You create pipeline configuration files when you define the stages of your Logstash processing pipeline. 
On deb and rpm, you place the pipeline configuration files in the /etc/logstash/conf.d directory. 
Logstash tries to load only files with .conf extension in the /etc/logstash/conf.d directory and ignores all other files.
```

```sh
cd /etc/logstash/conf.d
```

```sh
sudo vi pipeline1.conf
```

Paste the context below to pipeline1.conf
```
input {
      generator {
            lines => [
                 "This is a test log message from gjs"
            ]
           count => 20
      }
}

output {
    microsoft-sentinel-logstash-output-plugin {
      create_sample_file => true
      sample_file_path => "/tmp" #for example: "c:\\temp" (for windows) or "/tmp" for Linux. 
    }
}
```
![image](https://user-images.githubusercontent.com/96930989/210313503-7b7833d1-f4de-4516-a8c9-8672d99de05e.png)


* The following sample file will be generated under var/log

```sh
sudo systemctl restart logstash
```

```
[
	{
		"host": "logstashMachine",
		"sequence": 0,
		"message": "This is a test log message from gjs",
		"ls_timestamp": "2023-10-29T13:19:28.116Z",
		"ls_version": "1"
	},
	...
]
```
