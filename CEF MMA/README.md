# TSG for CEF log forwarder with MMA
## [Workflow](https://learn.microsoft.com/en-us/azure/sentinel/connect-common-event-format) 
### CEF forwarder server is Azure VM
![image](https://user-images.githubusercontent.com/96930989/220794512-eba62a76-b297-4bb9-aacb-041861621341.png)
### CEF forwarder server is on-prem/other cloud server
![image](https://user-images.githubusercontent.com/96930989/220794518-e0f67296-5016-49e2-92ba-b9cd41c04961.png)

1. Data source send out data through firewall
2. Syslog daemon on syslog forwarder server > listening for logs on TCP port 514 by default
3. Syslog daemon on syslog forwarder server > set filter to collect CEF logs only
4. Syslog daemon forwards log to MMA(OMS agent) via TCP port 25226
5. MMA listens for CEF logs from built-in syslog daemon on TCP port 25226 
6. MMA performs CEF logs mapping so that the logs parsed could be accepted by workspace
7. MMA sends the CEF logs to the workspace

## [Basic troubleshooting steps](https://learn.microsoft.com/en-us/azure/sentinel/troubleshooting-cef-syslog?tabs=cef)

### Check the stauts of services

[Troubleshoot issues with the Log Analytics agent for Linux](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/agent-linux-troubleshoot)

auoms
```sh
systemctl status auoms
```
![image](https://user-images.githubusercontent.com/96930989/229679984-e02ec129-800c-410e-b998-567b37f3add1.png)

OMSAgent service
```sh
sudo /opt/microsoft/omsagent/bin/omsadmin.sh -l
```
![image](https://user-images.githubusercontent.com/96930989/229681739-3fafde47-73f2-4ed1-a5c7-ec2648500c3e.png)

Check if current heartbeats in omsagent.log
```sh
sudo su root
tail -f /var/opt/microsoft/omsagent/log/omsagent.log
```
![image](https://user-images.githubusercontent.com/96930989/229681843-e65f1e2b-a357-4819-991b-386cbc72a325.png)


If the daemon is rsyslog
```sh
systemctl status rsyslog
```
![image](https://user-images.githubusercontent.com/96930989/229680037-9daf01d2-74e3-43a9-9327-95d32fe28e21.png)

If you want to install rsyslog daemon

```sh
apt install rsyslog -y
```

```sh
systemctl start rsyslog
systemctl enable rsyslog
```

Modify the rsyslog config file, uncomment the content below
```sh
nano /etc/rsyslog.conf
```
![image](https://user-images.githubusercontent.com/96930989/230888513-54b16790-ce11-4ea9-adc8-2fc833e30b29.png)

```sh
sudo systemctl restart rsyslog
```

```sh
sudo systemctl status rsyslog
```


If the daemon is syslog-ng, we can check the status
```sh
systemctl status syslog-ng
```

### 1. Check Firewall rules and forwarding rules between rsyslog daemon and MMA
### Path : /etc/rsyslog.d 
```sh
sudo ls /etc/rsyslog.d
```
![image](https://user-images.githubusercontent.com/96930989/211133207-f579d5ac-7681-4fe5-874b-4bbb0720f581.png)

* 20-ufw.conf : Firewall rules on local machine
```sh
cat 20-ufw.conf
```
![image](https://user-images.githubusercontent.com/96930989/211133612-7f48435d-3110-458e-aca3-ad06a3a2123c.png)

* 50-default.conf : Could configure local logging and so on
```sh
cat 50-default.conf
```
![image](https://user-images.githubusercontent.com/96930989/211133628-f59d078d-dc13-4aa5-9278-cac047fd3e39.png)


* security-config-omsagent.conf : Forwarding configuration between rsyslog daemon and MMA (filter to receive `CEF` logs only)
```sh
cat security-config-omsagent.conf
```
![image](https://user-images.githubusercontent.com/96930989/211133635-8add4994-1182-4eb7-8c89-e3bed0c6e6d8.png)


### Path : /etc/opt/microsoft/omsagent/[WorkspaceID]/conf/omsagent.d/security_events.conf
* security_events.conf : Rules set on OMS agent
```
/etc/opt/microsoft/omsagent/[WorkspaceID]/conf/omsagent.d/security_events.conf
```
![image](https://user-images.githubusercontent.com/96930989/220628825-e7cb6a95-e74e-4f9a-860c-8318bbd80fb8.png)


### 2. Check configuration between CEF data sources and rsyslog daemon
### Path : /etc/rsyslog.conf 
```sh
cat /etc/rsyslog.conf
```
In this file we can check the protocol and port set on the rsyslog daemon
![image](https://user-images.githubusercontent.com/96930989/211134060-7ddf3240-b896-4ff0-98d9-f75268f005ff.png)

By default, the listening port is 514, however, if the customer wants to use a differnent port, take 6514 for example, we can foloow the steps below

Original configuration

![image](https://user-images.githubusercontent.com/96930989/230566919-72223585-d9d0-42c8-8669-6ef16ea1d36a.png)

Modify the port to 6514 here, then save the file

![image](https://user-images.githubusercontent.com/96930989/230569120-edd145e3-f105-4a4a-b9bb-3e58bcd26559.png)

Restart rsyslog service
```sh
service rsyslog restart
```

Check the state of rsyslog daemon service, make sure it is running
```sh
systemctl status rsyslog
```

![image](https://user-images.githubusercontent.com/96930989/230569222-2e728400-1aa6-40e2-b258-5714c847ce7c.png)

Check if rsyslog daemon is listening to port 6514
```sh
netstat -an | grep 6514
```

![image](https://user-images.githubusercontent.com/96930989/230569376-6fe4e33d-da84-4f7b-81a3-4564b303dd34.png)


Send CEF log to port 6514
```sh
logger -p local4.warn -P 6514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousGJSActivity/5c113d028ca1ec1250ca0491"
```

Check the CEF log in workspace

![image](https://user-images.githubusercontent.com/96930989/230570626-686df9e5-e8ce-49ce-ac3d-1f8e9ee4c302.png)


### 3. Check ASA firewall/CEF parsing

Check if ASA firewall mapping exists in configuration file
```sh
grep -i "return ident if ident.include?('%ASA')" /opt/microsoft/omsagent/plugin/security_lib.rb
```
![image](https://user-images.githubusercontent.com/96930989/211134320-9f563d0d-6d56-422f-867d-cae81892b946.png)


Check if CEF mapping exists in configuration file
```sh
grep -i "return 'CEF' if ident.include?('CEF')" /opt/microsoft/omsagent/plugin/security_lib.rb
```
![image](https://user-images.githubusercontent.com/96930989/211134629-aa844aa7-af04-4e64-b0b9-26afb11bafdb.png)

Check mapping file
```sh
cat /opt/microsoft/omsagent/plugin/security_lib.rb
```
![image](https://user-images.githubusercontent.com/96930989/211134339-1797f29e-e62d-4867-89ac-48502cf10a96.png)

### 4. Check hostname mapping 
```sh
grep -i "'Host' => record\['host'\]"  /opt/microsoft/omsagent/plugin/filter_syslog_security.rb
```
![image](https://user-images.githubusercontent.com/96930989/211134727-73c2da08-9dbb-42ef-8a25-9e2ef2ce2c59.png)

```sh
cat /opt/microsoft/omsagent/plugin/filter_syslog_security.rb
```
![image](https://user-images.githubusercontent.com/96930989/211134733-f4691063-5d0b-4a01-bdd6-89b22e8c7b0b.png)


Restart the `syslog daemon` and the `Log Analytics agent` if necessary
```sh
service rsyslog restart
```
```sh
/opt/microsoft/omsagent/bin/service_control restart <workspaceID>
```

### 5. Check if rsyslog daemon and MMA are listening to port 514/25226 (or customized ports being used)

Checks that the necessary connections are established: 
* tcp 514 for receiving data
* tcp 25226 for internal communication between the rsyslog daemon and the Log Analytics agent
```sh
netstat -an | grep 514
netstat -an | grep 25226
```
![image](https://user-images.githubusercontent.com/96930989/211134831-a47385d9-835d-4447-b950-ba553cacd3c3.png)


### 6. Verify data flow on port 514 and 25226 (or customized ports being used)

Checks that the syslog daemon is receiving data on port 514, and that the agent is receiving data on port 25226:

```sh
sudo tcpdump -A -ni any port 514 -vv
```
```sh
sudo tcpdump -A -ni any port 25226 -vv
```


### 7. Check connection between OMS agent and Microsoft sentinel  
[Troubleshoot a connection between Microsoft Sentinel and a CEF or Syslog data connector](https://learn.microsoft.com/en-us/azure/sentinel/troubleshooting-cef-syslog?tabs=cef#linux-and-oms-agent-related-issues)

Make sure that you can see packets arriving on TCP/UDP port 514 on the Syslog collector

Make sure that you can see data packets flowing on port 25226

Make sure that your virtual machine has an outbound connection to port 443 via TCP, or can connect to the [Log Analytics endpoints](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/log-analytics-agent#network-requirements)

Make sure that you have access to required URLs from your CEF collector through your firewall policy. 
[Firewall requirements](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/log-analytics-agent#firewall-requirements)

Make sure that you can see logs being written to the local log file, either `/var/log/messages` or `/var/log/syslog`
![image](https://user-images.githubusercontent.com/96930989/211135011-7d447f4a-c0d0-4874-ba87-e0795fadcc8c.png)

For Centos/Redhat
```sh
sudo tac /var/log/messages | grep CEF -m 10
```
![image](https://user-images.githubusercontent.com/96930989/211135017-485afc6d-8314-43a1-863c-e71829a441cc.png)

For Ubuntu/Debian
```sh
sudo tac /var/log/syslog | grep CEF -m 10
```
![image](https://user-images.githubusercontent.com/96930989/213848193-af1d4e9d-46c7-4f98-9143-a46680fbb34e.png)

### 8. Check if the CEF log received matches the CEF format

1. Navigate to [CEF debug regex](https://regex101.com/)
2. Input CEF format
```
/(?<time>(?:\w+ +){2,3}(?:\d+:){2}\d+|\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.[\w\-\:\+]{3,12}):?\s*(?:(?<host>[^: ]+) ?:?)?\s*(?<ident>.*CEF.+?(?=0\|)|%ASA[0-9\-]{8,10})\s*:?(?<message>0\|.*|.*)/
```
The CEF formart could also be found in the path if you configured CEF forwarder on Linux machine
```sh
cat /etc/opt/microsoft/omsagent/<your workspace ID>/conf/omsagent.d/security_events.conf
```
![image](https://user-images.githubusercontent.com/96930989/211126976-4fdeec09-77d4-4065-b938-dcdba4192857.png)

3. Input the CEF logs you received
![image](https://user-images.githubusercontent.com/96930989/213848436-8e31cc32-609f-4fb6-9fb6-7fc7309c1f8e.png)


### 9. Sample CEF logs with logger command
```cmd
logger -p local4.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"
```

```cmd
logger -p auth.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"
```

```cmd
logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"
```

```cmd
logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|EncryptionDowngradeSuspiciousActivity|Encryption downgrade activity|5|start=2018-12-12T18:10:35.0334169Z app=Kerberos msg=The encryption method of the TGT field of TGS_REQ message from W2012R2-000000-Server has been downgraded based on previously learned behavior. This may be a result of a Golden Ticket in-use on W2012R2-000000-Server. externalId=2009 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114f938ca1ec1250cafcfa"
```

```cmd
logger -p user.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"
```

### 10. Reinstall MMA

[Remvove Linux OMS agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/agent-manage?tabs=PowerShellLinux#linux-agent-2)

Install MMA using the script downloaded from sentinel connector page

### 11. CEF-MMA TSG script > Modify the extension to `py`

[CEF-MMA-TSG.txt](https://github.com/guguji666666/GJS-Sentinel-Tips/files/11169699/CEF-MMA-TSG.txt)
