# Basic troubleshooting steps for CEF log forwarder
## 1. Check Firewall rules and forwarding rules between rsyslog daemon and MMA
### Path : /etc/rsyslog.d 
```sh
sudo ls /etc/rsyslog.d
```
![image](https://user-images.githubusercontent.com/96930989/211133207-f579d5ac-7681-4fe5-874b-4bbb0720f581.png)

* 20-ufw.conf : Firewall rules on local machine

* 50-default.conf : Could configure local logging and so on

* security-config-omsagent.conf : Forwarding configuration between rsyslog daemon and MMA (filter to receive `CEF` logs only)

```sh
cat 20-ufw.conf
```
![image](https://user-images.githubusercontent.com/96930989/211133612-7f48435d-3110-458e-aca3-ad06a3a2123c.png)

```sh
cat 50-default.conf
```
![image](https://user-images.githubusercontent.com/96930989/211133628-f59d078d-dc13-4aa5-9278-cac047fd3e39.png)

```sh
cat security-config-omsagent.conf
```
![image](https://user-images.githubusercontent.com/96930989/211133635-8add4994-1182-4eb7-8c89-e3bed0c6e6d8.png)

## 2. Check configuration betwween CEF data sources and rsyslog daemon
### Path : /etc/rsyslog.conf 
```sh
cat /etc/rsyslog.conf
```
In this file we can check the protocol and port set on the rsyslog daemen
![image](https://user-images.githubusercontent.com/96930989/211134060-7ddf3240-b896-4ff0-98d9-f75268f005ff.png)



## 4. Check if the log matches the CEF format

#### Navigate to [CEF debug regex](https://regex101.com/)

#### CEF format
```
/(?<time>(?:\w+ +){2,3}(?:\d+:){2}\d+|\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.[\w\-\:\+]{3,12}):?\s*(?:(?<host>[^: ]+) ?:?)?\s*(?<ident>.*CEF.+?(?=0\|)|%ASA[0-9\-]{8,10})\s*:?(?<message>0\|.*|.*)/
```
![image](https://user-images.githubusercontent.com/96930989/211126902-5a7bfa6c-6ece-45c6-8045-8a9809f97a8a.png)

The CEF formart could also be found in the path if you configured CEF forwarder on Linux machine

```sh
cat /etc/opt/microsoft/omsagent/<your workspace ID>/conf/omsagent.d/security_events.conf
```
![image](https://user-images.githubusercontent.com/96930989/211126976-4fdeec09-77d4-4065-b938-dcdba4192857.png)


