# CEF forwarder with MMA (Microsoft monitor agent)
## 1. Understand workflow 
[CEF with MMA](https://learn.microsoft.com/en-us/azure/sentinel/connect-common-event-format)

CEF forwarder server is Azure VM 
![image](https://user-images.githubusercontent.com/96930989/211131290-975809f8-ddee-4d8e-ad71-a29740ccba16.png)

CEF forwarder server is on-prem/other cloud server
![image](https://user-images.githubusercontent.com/96930989/211131297-610608d1-038e-4f95-9b31-3c3621f2e2c2.png)

1. Data source send out data through firewall

2. Syslog daemon on syslog forwarder server > listening for logs on TCP port 514 

3. Syslog daemon on syslog forwarder server > set filter to collect CEF logs only

4. Syslog daemon forwards log to MMA(OMS agent) via TCP 25226

5. MMA listens for CEF logs from built-in syslog daemon on TCP port 25226 

6. MMA performs CEF logs mapping so that the logs being parsed could be accepted by workspace

7. MMA sends the CEF logs to the workspace

## 2. Table used by CEF logs in workspace
[Search for CEF events](https://learn.microsoft.com/en-us/azure/sentinel/connect-common-event-format#find-your-data)

To search for CEF events in Log Analytics, query the `CommonSecurityLog` table in the query window.

## 3. Start deployment of log forwarder
### [Hardware and OS requirements](https://learn.microsoft.com/en-us/azure/sentinel/connect-log-forwarder?tabs=rsyslog#prerequisites)

`Hardware (physical/virtual)`
```
Your Linux machine must have a minimum of 4 CPU cores and 8 GB RAM.
A single log forwarder machine with the above hardware configuration and using the rsyslog daemon has a supported capacity of up to 8500 events per second (EPS) collected.
```

`Operating system`
```
CentOS 7 and 8 (not 6), including minor versions (64-bit/32-bit)
Amazon Linux 2017.09 and Amazon Linux 2 (64-bit only)
Oracle Linux 7, 8 (64-bit/32-bit)
Red Hat Enterprise Linux (RHEL) Server 7 and 8 (not 6), including minor versions (64-bit/32-bit)
Debian GNU/Linux 8 and 9 (64-bit/32-bit)
Ubuntu Linux 14.04 LTS and 16.04 LTS (64-bit/32-bit), 18.04 LTS (64-bit only), and 20.04 LTS (64-bit only)
SUSE Linux Enterprise Server 12, 15 (64-bit only)
```

`Daemon versions`
```
Rsyslog: v8
Syslog-ng: 2.1 - 3.22.1
```

`Packages`
```
You must have Python 2.7 or 3 installed on the Linux machine.
Use the python --version or python3 --version command to check.
```

`Syslog RFC support`
```
Syslog RFC 3164
Syslog RFC 5424
```

`Configuration`
```
You must have elevated permissions (sudo) on your designated Linux machine.
The Linux machine must not be connected to any Azure workspaces before you install the Log Analytics agent.
```

`Data`
```
You may need your Microsoft Sentinel workspace's Workspace ID and Workspace Primary Key at some point in this process. 
You can find them in the workspace settings, under Agents management.
```