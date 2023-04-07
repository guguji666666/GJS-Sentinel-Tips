## [Deploy CEF forwarder with AMA](https://learn.microsoft.com/en-us/azure/sentinel/connect-cef-ama)

### Workflow
#### 1. CEF source and forwarder set on a single server
![image](https://user-images.githubusercontent.com/96930989/225633906-299fca10-2f80-49f6-b366-205a25c07824.png)
#### 2. CEF source and forwarder set on different servers
![image](https://user-images.githubusercontent.com/96930989/225633923-4f1c8262-394f-4d62-898d-8ebb9bc8c3eb.png)

### [Add CEF logs faclities and log level in DCR](https://learn.microsoft.com/en-us/azure/sentinel/connect-cef-ama#select-the-data-source-type-and-create-the-dcr)

### TSG guidance

#### 1. Check the status of services on the VM

AMA service
```sh
systemctl status azuremonitoragent
```
![image](https://user-images.githubusercontent.com/96930989/229035992-94fa71b1-4474-474d-b0d1-164c02c90f37.png)

If the daemon is rsyslog
```sh
systemctl status rsyslog
```
![image](https://user-images.githubusercontent.com/96930989/229680887-f3a0b4e6-b598-414e-870c-228deb2e9bf2.png)


If the daemon is syslog-ng
```sh
systemctl status syslog-ng
```

#### 2. Check hearbeart in the workspace, check if the VM is in the list
```kusto
Heartbeat
| order by TimeGenerated desc
| project TimeGenerated, Computer, Category
```
![image](https://user-images.githubusercontent.com/96930989/229036309-11182c17-7557-4f4c-b378-bb36cde198e7.png)


#### 3. Check configuration betwween CEF data sources and rsyslog daemon

Path : /etc/rsyslog.conf 

```sh
cat /etc/rsyslog.conf
```

In this file we can check the protocol and port set on the rsyslog daemon

![image](https://user-images.githubusercontent.com/96930989/211134060-7ddf3240-b896-4ff0-98d9-f75268f005ff.png)

By default, the listening port is 514, however, if the customer wants to use a differnent port, take 6514 for example, we can foloow the steps below

Original configuration


Modify the port to 6514 here, then save the file


Restart rsyslog service
```sh
sudo service rsyslog restart
```

Check if rsyslog daemon is listening to port 6514
```sh
netstat -an | grep 6514
```

Send CEF log to port 6514
```sh
logger -p local4.warn -P 6514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"
```

Check the log in workspace


#### 4. Check if rsyslog daemon is listening to port 514
```sh
netstat -an | grep 514
```
![image](https://user-images.githubusercontent.com/96930989/226531248-7aeabe91-8666-4781-84c7-f0dffd32b326.png)

#### 5. Make sure that you can see logs being written to the local log file, either `/var/log/messages` or `/var/log/syslog`
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

#### 6. [Configure syslog rotation](https://www.systutorials.com/docs/linux/man/5-logrotate.conf/)

#### 7. Sample CEF logs with logger command
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

You can also send them all in one
```cmd
logger -p local4.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

logger -p auth.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|EncryptionDowngradeSuspiciousActivity|Encryption downgrade activity|5|start=2018-12-12T18:10:35.0334169Z app=Kerberos msg=The encryption method of the TGT field of TGS_REQ message from W2012R2-000000-Server has been downgraded based on previously learned behavior. This may be a result of a Golden Ticket in-use on W2012R2-000000-Server. externalId=2009 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114f938ca1ec1250cafcfa"

logger -p user.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"
```

### 8. Check if the CEF log received matches the CEF format

1. Navigate to [CEF debug regex](https://regex101.com/)

2. Input CEF format
```
/(?<time>(?:\w+ +){2,3}(?:\d+:){2}\d+|\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.[\w\-\:\+]{3,12}):?\s*(?:(?<host>[^: ]+) ?:?)?\s*(?<ident>.*CEF.+?(?=0\|)|%ASA[0-9\-]{8,10})\s*:?(?<message>0\|.*|.*)/
```

3. Input the CEF logs you received
![image](https://user-images.githubusercontent.com/96930989/213848436-8e31cc32-609f-4fb6-9fb6-7fc7309c1f8e.png)


#### 9. Capture TCP dump logs
```sh
sudo tcpdump -w '/tmp/capture.pcap' &
```
Note the process id here
![image](https://user-images.githubusercontent.com/96930989/227417734-2af2edf2-c27d-4f47-8faa-e0d6c52c5603.png)

Wait for 3 mins, launch another session, run the command
```sh
Kill <process id>
```
![image](https://user-images.githubusercontent.com/96930989/227417784-92655e51-dffb-4dcc-9ce1-0b16d8f3a0a8.png)

Then the previous session will show

![image](https://user-images.githubusercontent.com/96930989/227417818-12cc630f-f87c-4200-bc29-578d363428e4.png)

#### 10. Enable debug logging in rsyslog
Add a file at `/etc/rsyslog.d/1-debug.conf` with the following contents:
```sh
sudo systemctl restart rsyslog
```
After this, rsyslog will be outputting internal debug logs to `/var/log/rsyslog.debug.log`

#### 11. Capture logs for further troubleshooting

Go to the troubleshooter's installed location
```sh
cd /var/lib/waagent/Microsoft.Azure.Monitor.AzureMonitorLinuxAgent-<version>/ama_tst
```
![image](https://user-images.githubusercontent.com/96930989/229040535-e219f521-dc65-4681-bbaa-517a4b14f208.png)

Run the troubleshooter
```sh
sudo sh ama_troubleshooter.sh
```

Select option "L"

![image](https://user-images.githubusercontent.com/96930989/229040740-6a8f4e1c-86cf-4b93-872d-96d446813d22.png)

Define the path for output results

![image](https://user-images.githubusercontent.com/96930989/229040781-e0309d1a-5489-4f39-ac0f-88fba47815ac.png)

If the troubleshooter isn't properly installed, or needs to be updated, the newest version can be downloaded and run by following the steps below.
 
Copy the troubleshooter bundle onto your machine
```sh
wget https://github.com/Azure/azure-linux-extensions/raw/master/AzureMonitorAgent/ama_tst/ama_tst.tgz
```

Unpack the bundle
```sh
tar -xzvf ama_tst.tgz
```

Once the script is ready, run the troubleshooter: 
```sh
sudo sh ama_troubleshooter.sh
```

Select option "L"

![image](https://user-images.githubusercontent.com/96930989/229040740-6a8f4e1c-86cf-4b93-872d-96d446813d22.png)

Define the path for output results

![image](https://user-images.githubusercontent.com/96930989/229040781-e0309d1a-5489-4f39-ac0f-88fba47815ac.png)


#### [Troubleshooting guidance for the Azure Monitor agent on Linux virtual machines and scale sets](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-troubleshoot-linux-vm?context=%2Fazure%2Fvirtual-machines%2Fcontext%2Fcontext#basic-troubleshooting-steps)

#### [Rsyslog data not uploaded due to Full Disk space issue on AMA Linux Agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-troubleshoot-linux-vm-rsyslog?context=%2Fazure%2Fvirtual-machines%2Fcontext%2Fcontext)

The df command shows almost no space available on /dev/sda1, as shown below
```sh
df -h
```
![image](https://user-images.githubusercontent.com/96930989/226531417-bf1ba739-e30b-460b-8cae-1988c1046e43.png)

The du command can be used to inspect the disk to determine which files are causing the disk to be full. As shown below (machine is running Ubuntu/Debian)
```sh
cd /var/log
```
```sh
du -h syslog*
```
![image](https://user-images.githubusercontent.com/96930989/226531751-e74e25d5-2e24-4806-9d5f-336845c13c84.png)

On some popular distros (for example Ubuntu 18.04 LTS), rsyslog ships with a default configuration file (`/etc/rsyslog.d/50-default.conf`) which will log events from nearly all facilities to disk at /var/log/syslog.

AMA `doesn't rely on` syslog events being logged to /var/log/syslog. Instead, it configures rsyslog to forward events over a socket directly to the azuremonitoragent service process (mdsd).

If you're sending a `high log volume` through rsyslog, consider modifying the default rsyslog config to `avoid logging these events` to this location /var/log/syslog. The events for this facility would still be forwarded to AMA because of the config in `/etc/rsyslog.d/10-azuremonitoragent.conf`

Check `/etc/rsyslog.d/50-default.conf`
```sh
cat /etc/rsyslog.d/50-default.conf
```
![image](https://user-images.githubusercontent.com/96930989/226532794-a7b6ed65-ab9f-40e5-9e74-e5f4f4e1ac26.png)

For example, to remove local4 events from being logged at /var/log/syslog, change this line in /etc/rsyslog.d/50-default.conf from this:
```
*.*;auth,authpriv.none          -/var/log/syslog
```
To this
```
*.*;local4.none;auth,authpriv.none          -/var/log/syslog
```
Then
```sh
sudo systemctl restart rsyslog
```

Check `/etc/rsyslog.d/10-azuremonitoragent.conf`
```sh
cat /etc/rsyslog.d/10-azuremonitoragent.conf
```
![image](https://user-images.githubusercontent.com/96930989/226533023-869953b6-c9d7-49e9-89bd-415a8fa179af.png)


Wait until the results are generated

![image](https://user-images.githubusercontent.com/96930989/229041503-56cd25d3-edf0-406b-9225-089cf7ef6e27.png)


#### Other Reference links
* [Redhat:Why the logs are not getting updated in /var/log/messages ?](https://access.redhat.com/solutions/3094721)
