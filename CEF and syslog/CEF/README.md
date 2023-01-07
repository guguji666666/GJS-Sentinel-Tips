# Useful CEF tips
## 1. Check if CEF parsing is correct

#### Navigate to [CEF parsing](https://regex101.com/)

#### CEF format
```
/(?<time>(?:\w+ +){2,3}(?:\d+:){2}\d+|\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.[\w\-\:\+]{3,12}):?\s*(?:(?<host>[^: ]+) ?:?)?\s*(?<ident>.*CEF.+?(?=0\|)|%ASA[0-9\-]{8,10})\s*:?(?<message>0\|.*|.*)/
```
![image](https://user-images.githubusercontent.com/96930989/211126902-5a7bfa6c-6ece-45c6-8045-8a9809f97a8a.png)

The CEF formart could also be found in the path if you configured CEF forwarder on Linux machine

```
cat /etc/opt/microsoft/omsagent/<your workspace ID>/conf/omsagent.d/security_events.conf
```
![image](https://user-images.githubusercontent.com/96930989/211126976-4fdeec09-77d4-4065-b938-dcdba4192857.png)
