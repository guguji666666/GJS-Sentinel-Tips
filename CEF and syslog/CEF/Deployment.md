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

## 3. Start deployment

### OS supported


