# Configure CEF forwareder or raw syslog forwarder connectors in Sentinel

### 1. Check if the rsyslog configuration file is good before restating service/server

```sh
cd /etc/rsyslog.d

sudo rsyslogd -N 5
```
You will see the result below if the configuration is good
![image](https://user-images.githubusercontent.com/96930989/211128391-aecf8090-f270-4452-a817-8092f5f0ed7f.png)

After that,
```sh
sudo service rsyslog restart
```
