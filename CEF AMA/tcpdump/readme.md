# Tcpdump guidance

## 1. Launch 3 ssh sessions to CEF fowarder server

## 2. In session 1, run command below
```sh
sudo tcpdump -s 0 -Ani any port 514 -vv -w /var/log/cef514.pcap &
sudo tcpdump -s 0 -Ani any port 28330 -vv -w /var/log/cef28330.pcap &
```

You will see the output like this, note the PID here <br>
![image](https://github.com/user-attachments/assets/9f05af10-9ce1-42a1-9f22-f274733d70f7)


## 3. In session 2, run the commands below to manually generate CEF logs and send to port 514 
```
if you already have external source such as firewall that sends CEF logs to the current CEF fowarder server, then please ignore this step)
```

```sh
logger -p local4.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

logger -p auth.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|EncryptionDowngradeSuspiciousActivity|Encryption downgrade activity|5|start=2018-12-12T18:10:35.0334169Z app=Kerberos msg=The encryption method of the TGT field of TGS_REQ message from W2012R2-000000-Server has been downgraded based on previously learned behavior. This may be a result of a Golden Ticket in-use on W2012R2-000000-Server. externalId=2009 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114f938ca1ec1250cafcfa"

logger -p user.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"


logger -p local4.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

logger -p auth.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|EncryptionDowngradeSuspiciousActivity|Encryption downgrade activity|5|start=2018-12-12T18:10:35.0334169Z app=Kerberos msg=The encryption method of the TGT field of TGS_REQ message from W2012R2-000000-Server has been downgraded based on previously learned behavior. This may be a result of a Golden Ticket in-use on W2012R2-000000-Server. externalId=2009 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114f938ca1ec1250cafcfa"

logger -p user.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|LdapBruteForceSuspiciousActivity|Brute force attack using LDAP simple bind|5|start=2018-12-12T17:52:10.2350665Z app=Ldap msg=10000 password guess attempts were made on 100 accounts from W2012R2-000000-Server. One account password was successfully guessed. externalId=2004 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c114acb8ca1ec1250cacdcb"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|SuspiciousVPNLogin|Suspicious VPN login detected|5|start=2018-12-13T09:45:00.0000000Z app=VPN suser=johndoe msg=Suspicious login to VPN from unusual location. externalId=3001 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c1156788ca1ec1250cb1234"

logger -p local4.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|MalwareInfection|Malware infection detected|5|start=2018-12-13T10:00:00.0000000Z app=Antivirus suser=SYSTEM msg=Malware detected on host W2012R2-000001-Server. externalId=3002 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c1157898ca1ec1250cb5678"



logger -p auth.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|UnauthorizedAccessAttempt|Unauthorized access attempt|5|start=2018-12-13T11:30:00.0000000Z app=Authentication suser=unknown msg=Unauthorized access attempt detected. externalId=4001 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c1167898ca1ec1250cb8901"

logger -p auth.warn -P 514 -n 127.0.0.1 -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|MultipleFailedLogins|Multiple failed login attempts|5|start=2018-12-13T12:00:00.0000000Z app=Authentication suser=johndoe msg=Multiple failed login attempts detected. externalId=4002 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c1168908ca1ec1250cb8902"


logger -p user.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|DataExfiltration|Data exfiltration detected|5|start=2018-12-13T13:15:00.0000000Z app=DataLeakPrevention suser=janedoe msg=Large data transfer detected to external IP. externalId=5001 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c1178908ca1ec1250cb8903"

logger -p user.warn -t CEF "CEF:0|Microsoft|ATA|1.9.0.0|PhishingEmailDetected|Phishing email detected|5|start=2018-12-13T14:00:00.0000000Z app=EmailSecurity suser=SYSTEM msg=Phishing email detected and quarantined. externalId=5002 cs1Label=url cs1=https://192.168.0.220/suspiciousActivity/5c1179018ca1ec1250cb8904"
```

## 4. Wait for 60s, go to session 3, run commands below to kill PIDs we noted before

```sh
kill <PID>
```
![image](https://github.com/user-attachments/assets/88816593-d4fd-4b93-85bb-360cd75ae0ab)

Then go back to session 1, you will see the results like this <br>
![image](https://github.com/user-attachments/assets/4715a7e7-f7d5-48cb-9d52-b11b0891d14e)

The pcap logs should be here <br>
![image](https://github.com/user-attachments/assets/37c62055-43ba-4255-a6af-e11d6d8dfa21)


