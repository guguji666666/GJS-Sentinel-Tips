## [Deploy CEF forwarder with AMA](https://learn.microsoft.com/en-us/azure/sentinel/connect-cef-ama)

## Workflow
#### 1. CEF source and forwarder set on a single server
![image](https://user-images.githubusercontent.com/96930989/225633906-299fca10-2f80-49f6-b366-205a25c07824.png)
#### 2. CEF source and forwarder set on different servers
![image](https://user-images.githubusercontent.com/96930989/225633923-4f1c8262-394f-4d62-898d-8ebb9bc8c3eb.png)

### [Add CEF logs faclities and log level in DCR](https://learn.microsoft.com/en-us/azure/sentinel/connect-cef-ama#select-the-data-source-type-and-create-the-dcr)

## TSG guidance

### 1. Check the status of services on the VM

AMA service
```sh
systemctl status azuremonitoragent
```
![image](https://user-images.githubusercontent.com/96930989/229035992-94fa71b1-4474-474d-b0d1-164c02c90f37.png)

If the daemon is rsyslog
```sh
systemctl status rsyslog
```
![image](https://user-images.githubusercontent.com/96930989/229680037-9daf01d2-74e3-43a9-9327-95d32fe28e21.png)

If you want to [install rsyslog daemon](https://www.linkedin.com/pulse/how-install-set-up-rsyslog-server-linux-ubuntu-20041-akshay-sharma)

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

### 2. Check hearbeart in the workspace, check if the VM is in the list
```kusto
Heartbeat
| order by TimeGenerated desc
| project TimeGenerated, Computer, Category
```
![image](https://user-images.githubusercontent.com/96930989/229036309-11182c17-7557-4f4c-b378-bb36cde198e7.png)


### 3. Check configuration between CEF data sources and rsyslog daemon

Path : /etc/rsyslog.conf 

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


### 4. Check if rsyslog daemon is listening to port 514
```sh
netstat -an | grep 514
```
![image](https://user-images.githubusercontent.com/96930989/226531248-7aeabe91-8666-4781-84c7-f0dffd32b326.png)

### 5. Make sure that you can see logs being written to the local log file, either `/var/log/messages` or `/var/log/syslog`
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

### 6. [Configure syslog rotation](https://www.systutorials.com/docs/linux/man/5-logrotate.conf/)

### 7. Sample CEF logs
#### Using logger
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

#### Using echo
```sh
# First log entry
echo "CEF:0|Microsoft1|ATA1|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491" | logger -p local4.warn -P 514 -n 127.0.0.1 -t CEF

# Second log entry
echo "CEF:0|Microsoft2|ATA2|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491" | logger -p auth.warn -P 514 -n 127.0.0.1 -t CEF

# Third log entry
echo "CEF:0|Microsoft3|ATA3|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb" | logger -p local4.warn -t CEF

# Fourth log entry
echo "CEF:0|Microsoft4|ATA4|1.9.0.0|EncryptionDowngradeSuspiciousActivity|Encryption downgrade activity|5|start=2018-12-12T18:10:35.0334169Z app=Kerberos msg=The encryption method of the TGT field of TGS_REQ message from W2012R2-000000-Server has been downgraded based on previously learned behavior. This may be a result of a Golden Ticket in-use on W2012R2-000000-Server. externalId=2009 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c114f938ca1ec1250cafcfa" | logger -p local4.warn -t CEF

# Fifth log entry
echo "CEF:0|Microsoft5|ATA5|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb" | logger -p user.warn -t CEF

# Sixth log entry
echo "CEF:0|Symantec|Endpoint Protection|14.0.0.0|MalwareDetection|Malware detected on system|10|start=2018-12-12T19:15:00.0000000Z app=SymantecEndpointProtection suser=JohnDoe src=192.168.1.100 msg=A malicious file was detected and quarantined. MalwareName=W32.Beagle@mm externalId=123456 cs1Label=url cs1=https://symantec.com/malware/123456" | logger -p local4.info -t CEF

# Seventh log entry
echo "CEF:0|Splunk|Enterprise|7.2.0|AccountLockout|User account locked out|6|start=2018-12-12T19:30:22.0000000Z app=IdentityManager suser=JaneSmith msg=Account janesmith has been locked out due to multiple failed login attempts. externalId=987654321 cs1Label=url cs1=https://splunk.com/lockout/987654321" | logger -p auth.notice -t CEF

# Eighth log entry
echo "CEF:0|ArcSight|ESM|7.0.3|LoginSuccess|User login success|3|start=2018-12-12T20:10:00.0000000Z app=ArcSightConsole suser=admin src=192.168.1.50 dhost=arcsight-server msg=User admin successfully logged into the ArcSight ESM console. externalId=112233 cs1Label=url cs1=https://arcsight.com/event/112233" | logger -p auth.info -P 514 -n 127.0.0.1 -t CEF

# Ninth log entry
echo "CEF:0|Microsoft|Windows|10.0.17134.0|SystemRestart|System was rebooted|1|start=2018-12-12T20:45:00.0000000Z app=WindowsEventLog msg=The system has been rebooted. Reason: User initiated shutdown. externalId=123456789 cs1Label=url cs1=https://windows.com/event/123456789" | logger -p local4.notice -t CEF

# Tenth log entry
echo "CEF:0|Cisco|ASA|9.8.2|AccessDenied|Firewall blocked unauthorized access|7|start=2018-12-12T21:00:15.0000000Z app=Firewall src=192.168.2.25 dst=10.10.10.10 msg=Unauthorized access attempt from 192.168.2.25 to 10.10.10.10 was blocked. externalId=77777 cs1Label=url cs1=https://cisco.com/asa-event/77777" | logger -p local4.warn -t CEF

# Eleventh log entry
echo "CEF:0|McAfee|Endpoint Security|5.0.0.0|VirusDetected|Virus detected and quarantined|10|start=2018-12-12T21:15:30.0000000Z app=McAfeeEndpoint suser=Alice src=192.168.1.150 msg=A critical virus was detected and removed. VirusName=Rogue.Malware externalId=54321 cs1Label=url cs1=https://mcafee.com/virus/54321" | logger -p local4.error -t CEF

# Twelfth log entry
echo "CEF:0|PaloAlto|Firewall|8.1.0|MaliciousTraffic|Blocked malicious traffic|7|start=2018-12-12T21:30:10.1234567Z app=PaloAltoFirewall src=192.168.3.10 dst=10.1.1.5 msg=Malicious traffic from 192.168.3.10 has been blocked. externalId=33333 cs1Label=url cs1=https://paloalto.com/firewall/block/33333" | logger -p local4.warning -t CEF

# Thirteenth log entry
echo "CEF:0|TrendMicro|OfficeScan|12.0.0.0|ThreatBlocked|Threat has been blocked|9|start=2018-12-12T21:45:00.0000000Z app=OfficeScan suser=Bob src=192.168.2.100 msg=Threat detected and blocked successfully. externalId=88888 cs1Label=url cs1=https://trendmicro.com/threat/88888" | logger -p local4.notice -t CEF

# Fourteenth log entry
echo "CEF:0|Fortinet|FortiGate|6.2.0|WebFilter|Blocked access to malicious site|5|start=2018-12-12T22:00:00.0000000Z app=FortiGate src=192.168.0.50 dst=malicious.com msg=Access to malicious.com was blocked. externalId=77778 cs1Label=url cs1=https://fortinet.com/webfilter/block/77778" | logger -p local4.info -t CEF

# Fifteenth log entry
echo "CEF:0|Symantec|Network Security|15.1.0.0|IntrusionDetection|Intrusion detected|6|start=2018-12-12T22:10:15.0000000Z app=NetworkSecurity suser=Charlie msg=An intrusion attempt has been detected and logged. externalId=45612 cs1Label=url cs1=https://symantec.com/intrusion/45612" | logger -p auth.warn -t CEF

# Sixteenth log entry
echo "CEF:0|F5|BIG-IP|12.1.0|ApplicationAttack|Application attack detected|7|start=2018-12-12T22:30:45.0000000Z app=BIG-IP suser=David msg=Detected multiple attempts to exploit an application vulnerability. externalId=99999 cs1Label=url cs1=https://f5.com/appattack/99999" | logger -p local4.warn -t CEF

# Seventeenth log entry
echo "CEF:0|Cisco|Identity Services Engine|2.3.0|UserAuthentication|User authenticated successfully|3|start=2018-12-12T23:00:00.0000000Z app=ISE suser=Eve msg=User Eve has successfully authenticated. externalId=11234 cs1Label=url cs1=https://cisco.com/ise/auth/11234" | logger -p auth.info -t CEF

# Eighteenth log entry
echo "CEF:0|IBM|QRadar|7.4.0|DataBreaches|Potential data breach detected|10|start=2018-12-12T23:15:25.0000000Z app=QRadar msg=A potential data breach was detected from the network. externalId=22222 cs1Label=url cs1=https://ibm.com/qradar/breach/22222" | logger -p local4.crit -t CEF

# Nineteenth log entry
echo "CEF:0|Splunk|ESM|8.0.0|LogInFailure|User login failure|4|start=2018-12-12T23:25:35.0000000Z app=Splunk suser=Frank msg=Login failed for user Frank due to incorrect password. externalId=33333 cs1Label=url cs1=https://splunk.com/loginfail/33333" | logger -p auth.error -t CEF

# Twentieth log entry
echo "CEF:0|Microsoft|Azure|12.0.1|UnauthorizedAccess|Unauthorized access attempt|8|start=2018-12-12T23:35:50.0000000Z app=Azure suser=Grace msg=Unauthorized access attempt detected for the service account Grace. externalId=12345 cs1Label=url cs1=https://microsoft.com/azure/unauthorized/12345" | logger -p local4.alert -t CEF
```
| Facility 宏名字 | Facility 英文名字/模块 | Facility Value |
|:----------------|:----------------------|:--------------|
| LOG_KERN         | kernel messages         | 0             |
| LOG_USER         | user-level messages     | 1             |
| LOG_MAIL         | mail system             | 2             |
| LOG_DAEMON       | system daemons          | 3             |
| LOG_AUTH         | security/authorization messages | 4  |
| LOG_SYSLOG       | messages generated internally by syslogd | 5 |
| LOG_LPR          | line printer subsystem  | 6             |
| LOG_NEWS         | network news subsystem  | 7             |
| LOG_UUCP         | UUCP subsystem           | 8             |
| LOG_CLOCK        | clock daemon             | 9             |
| LOG_AUTHPRIV     | security/authorization messages (private) | 10 |
| LOG_FTP          | FTP daemon               | 11            |
| LOG_NTP          | NTP subsystem             | 12            |
| LOG_AUDIT        | log audit                | 13            |
| LOG_ALERT        | log alert                | 14            |
| (备用 clock daemon) | clock daemon (private) | 15            |
| LOG_LOCAL0       | local use 0 (local0)     | 16            |
| LOG_LOCAL1       | local use 1 (local1)     | 17            |
| LOG_LOCAL2       | local use 2 (local2)     | 18            |
| LOG_LOCAL3       | local use 3 (local3)     | 19            |
| LOG_LOCAL4       | local use 4 (local4)     | 20            |
| LOG_LOCAL5       | local use 5 (local5)     | 21            |
| LOG_LOCAL6       | local use 6 (local6)     | 22            |
| LOG_LOCAL7       | local use 7 (local7)     | 23            |



| Facility 名字         | Facility 值 | Severity 名字     | Severity 值 | PRI (Facility × 8 + Severity) |
|:----------------------|:------------|:------------------|:------------|:------------------------------|
| kernel messages       | 0            | emergency         | 0            | 0                              |
| kernel messages       | 0            | alert             | 1            | 1                              |
| kernel messages       | 0            | critical          | 2            | 2                              |
| kernel messages       | 0            | error             | 3            | 3                              |
| user-level messages    | 1            | informational     | 6            | 14                             |
| user-level messages    | 1            | warning           | 4            | 12                             |
| user-level messages    | 1            | error             | 3            | 11                             |
| mail system           | 2            | warning           | 4            | 20                             |
| system daemons        | 3            | informational     | 6            | 30                             |
| system daemons        | 3            | error             | 3            | 27                             |
| auth/authpriv (security) | 4          | warning           | 4            | 36                             |
| auth/authpriv (security) | 4          | error             | 3            | 35                             |
| auth/authpriv (security) | 4          | informational     | 6            | 38                             |
| auth/authpriv (security) | 4          | notice            | 5            | 37                             |
| syslog internal       | 5            | informational     | 6            | 46                             |
| syslog internal       | 5            | error             | 3            | 43                             |
| local0                 | 16           | informational     | 6            | 134                            |
| local0                 | 16           | warning           | 4            | 132                            |
| local0                 | 16           | error             | 3            | 131                            |
| local4                 | 20           | warning           | 4            | 164                            |
| local4                 | 20           | informational     | 6            | 166                            |
| local4                 | 20           | notice            | 5            | 165                            |
| local4                 | 20           | error             | 3            | 163                            |
| local4                 | 20           | alert             | 1            | 161                            |
| daemon                | 3            | critical          | 2            | 26                             |

```sh
# Facility: local4 (20), Severity: warning (4)
echo "<164>$(date '+%b %d %H:%M:%S') 40.112.72.205 CEF:0|Microsoft1|ATA1|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

# Facility: auth (4), Severity: warning (4)
echo "<36>$(date '+%b %d %H:%M:%S') 40.112.72.205 CEF:0|Microsoft2|ATA2|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

# Facility: local4 (20), Severity: warning (4)
echo "<164>$(date '+%b %d %H:%M:%S') 40.112.72.205 CEF:0|Microsoft3|ATA3|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"

# Facility: local4 (20), Severity: warning (4)
echo "<164>$(date '+%b %d %H:%M:%S') 40.112.72.205 CEF:0|Microsoft4|ATA4|1.9.0.0|EncryptionDowngradeSuspiciousActivity|Encryption downgrade activity|5|start=2018-12-12T18:10:35.0334169Z app=Kerberos msg=The encryption method of the TGT field of TGS_REQ message from W2012R2-000000-Server has been downgraded based on previously learned behavior. This may be a result of a Golden Ticket in-use on W2012R2-000000-Server. externalId=2009 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c114f938ca1ec1250cafcfa"

# Facility: user (1), Severity: warning (4)
echo "<12>$(date '+%b %d %H:%M:%S') 40.112.72.205 CEF:0|Microsoft5|ATA5|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"
```


### 8. Check if the CEF log received matches the CEF format

1. Navigate to [CEF debug regex](https://regex101.com/)

2. Input CEF format
```
/(?<time>(?:\w+ +){2,3}(?:\d+:){2}\d+|\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.[\w\-\:\+]{3,12}):?\s*(?:(?<host>[^: ]+) ?:?)?\s*(?<ident>.*CEF.+?(?=0\|)|%ASA[0-9\-]{8,10})\s*:?(?<message>0\|.*|.*)/
```

3. Input the CEF logs you received
![image](https://user-images.githubusercontent.com/96930989/213848436-8e31cc32-609f-4fb6-9fb6-7fc7309c1f8e.png)

Sample CEF logs in right format
```
Apr 11 00:15:00 cef-ama-01 CEF CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491
```

### 9. Capture TCP dump logs
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

### 10. Enable debug logging in rsyslog
Add a file at `/etc/rsyslog.d/1-debug.conf` with the following contents:
```sh
sudo systemctl restart rsyslog
```
After this, rsyslog will be outputting internal debug logs to `/var/log/rsyslog.debug.log`

### 11. Capture logs for further troubleshooting

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
