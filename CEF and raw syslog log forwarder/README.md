# Configure CEF/raw syslog forwarder connectors in Sentinel

### 1. Check if the rsyslog configuration file is good before restating service/server

```sh
cd /etc/rsyslog.d
```

```sh
sudo rsyslogd -N 5
```
You will see the result below if the configuration is good
![image](https://user-images.githubusercontent.com/96930989/211128391-aecf8090-f270-4452-a817-8092f5f0ed7f.png)

After that,
```sh
sudo service rsyslog restart
```

### 2. Avoid duplicated syslog and CEF log with same facilities

#### 1. Navigate to the path where config files locate

```sh
cd /etc/rsyslog.d 
```

#### 2. Rename the `security-config-omsagent.conf`

```sh
mv security-config-omsagent.conf 94-security-config-omsagent.conf
```
or
```sh
mv security-config-omsagent.conf 1-security-config-omsagent.conf
```

#### 3. edit the 94-security-config-omsagent.conf and '& stop' after the filter
```sh
nano 94-security-config-omsagent.conf
```

```
if $rawmsg contains "CEF:" or $rawmsg contains "ASA-" then @@127.0.0.1:25226
& stop
```

#### 4. Disable the synchronization of the agent with the Syslog configuration in Microsoft Sentinel as mentioned in [Using the same machine to forward both plain Syslog and CEF messages](https://learn.microsoft.com/en-us/azure/sentinel/connect-syslog#using-the-same-machine-to-forward-both-plain-syslog-and-cef-messages)
```sh
sudo -u omsagent python /opt/microsoft/omsconfig/Scripts/OMS_MetaConfigHelper.py --disable
```

#### 5. Remove the file `95-omsagent.conf`

[Syslog configuration in Azure portal](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/data-sources-syslog#configure-syslog-in-the-azure-portal)

```sh
cd /etc/rsyslog.d/
```

```sh
rm 95-omsagent.conf
```


#### 6. Restart the rsyslog server
```sh
systemctl restart rsyslog
```
or reboot the server
```sh
reboot
```
