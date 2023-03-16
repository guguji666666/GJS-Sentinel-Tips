## [Deploy CEF forwarder with AMA](https://learn.microsoft.com/en-us/azure/sentinel/connect-cef-ama)

### Workflow
#### 1. CEF source and forwarder set on a single server
![image](https://user-images.githubusercontent.com/96930989/225633906-299fca10-2f80-49f6-b366-205a25c07824.png)
#### 2. CEF source and forwarder set on different servers
![image](https://user-images.githubusercontent.com/96930989/225633923-4f1c8262-394f-4d62-898d-8ebb9bc8c3eb.png)

### MS TSG guidance
#### 1. [Troubleshooting guidance for the Azure Monitor agent on Linux virtual machines and scale sets](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-troubleshoot-linux-vm?context=%2Fazure%2Fvirtual-machines%2Fcontext%2Fcontext#basic-troubleshooting-steps)

#### 2. [Rsyslog data not uploaded due to Full Disk space issue on AMA Linux Agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-troubleshoot-linux-vm-rsyslog?context=%2Fazure%2Fvirtual-machines%2Fcontext%2Fcontext)

#### 3. Check if rsyslog daemon is listening to port 514
```sh
netstat -an | grep 514
```

#### 4. Make sure that you can see logs being written to the local log file, either `/var/log/messages` or `/var/log/syslog`
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
