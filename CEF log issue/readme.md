# CEF log issue

## The information of CEF logs are missing in sentinel workspace

### Test 1
Sample log 1 from firewall
```sh
Oct 25 01:23:48 blog.gulaoda.com ASM CEF: 0|14.1.5|Illegal file type|Illegal file type|6|dvchost=drdc011tm01.dr.icwa.wa.gov.au dvc=10.7.90.115 s1=/Common/adfs-prod-http cslLabel-policy_name cs2=/Common/adfs-prod-http cs2Label=http_class_name deviceCustomDate1=Mar 04 2023 12:41:56 deviceCustomDatelLabel-poicy apply date externalId=3485208313932711252 act=blocked cn1=0 chiLabel=response code Src=35.216.229.155 spt=50388 dst=172.16.90.19 pt=443 requestMethod=GET pp=H IPPS Css-W/A csSLabel=%_ forwarded for_header_ value rt=Oct 25 2023 09:23:48 deviceExternalId-0 cs4-Forceful Browsing Cs4Label-attack type cs6=CH Cs6Label=geo locatio n c6a1= c6alLabel-device address ¿6a2= c6a2Label=source address c6a3= c6a3Label=destination address c6a4= c6a4Labei=ip address intelligence msg=N/A suid=0 suser=N/A cn2=3 cn2Label=violation
```

Send the log to port 514 on forwarder server
```sh
echo -n "Oct 25 01:23:48 blog.gulaoda.com ASM CEF: 0|14.1.5|Illegal file type|Illegal file type|6|dvchost=drdc011tm01.dr.icwa.wa.gov.au dvc=10.7.90.115 s1=/Common/adfs-prod-http cslLabel-policy_name cs2=/Common/adfs-prod-http cs2Label=http_class_name deviceCustomDate1=Mar 04 2023 12:41:56 deviceCustomDatelLabel-poicy apply date externalId=3485208313932711252 act=blocked cn1=0 chiLabel=response code Src=35.216.229.155 spt=50388 dst=172.16.90.19 pt=443 requestMethod=GET pp=H IPPS Css-W/A csSLabel=%_ forwarded for_header_ value rt=Oct 25 2023 09:23:48 deviceExternalId-0 cs4-Forceful Browsing Cs4Label-attack type cs6=CH Cs6Label=geo locatio n c6a1= c6alLabel-device address ¿6a2= c6a2Label=source address c6a3= c6a3Label=destination address c6a4= c6a4Labei=ip address intelligence msg=N/A suid=0 suser=N/A cn2=3 cn2Label=violation" | nc -u -w0 localhost 514
```

### Test 2
Sample log 2 with qualified format
```sh
Oct 25 00:15:00 cef-ama-01 CEF CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491
```

Send the log to port 514 on forwarder server
```sh
echo -n "Oct 25 00:15:00 cef-ama-01 CEF CEF:0|Microsoft|ATA|1.9.0.0|AbnormalSensitiveGroupMembershipChangeSuspiciousActivity|Abnormal modification of sensitive groups|5|start=2018-12-12T18:52:58.0000000Z app=GroupMembershipChangeEvent suser=krbtgt msg=krbtgt has uncharacteristically modified sensitive group memberships. externalId=2024 cs1Label=url cs1= https://192.168.0.220/suspiciousActivity/5c113d028ca1ec1250ca0491" | nc -u -w0 localhost 514
```

### Test 3
Sample log 3 with qualified format (firewall)
```sh
Oct 25 01:22:48 blog.gulaoda.com ASM CEF: 0|Microsoft|ATA|14.1.5|Illegal file type|Illegal file type|6|dvchost=drdc011tm01.dr.icwa.wa.gov.au dvc=10.7.90.115 s1=/Common/adfs-prod-http cslLabel-policy_name cs2=/Common/adfs-prod-http cs2Label=http_class_name deviceCustomDate1=Mar 04 2023 12:41:56 deviceCustomDatelLabel-poicy apply date externalId=3485208313932711252 act=blocked cn1=0 chiLabel=response code Src=35.216.229.155 spt=50388 dst=172.16.90.19 pt=443 requestMethod=GET pp=H IPPS Css-W/A csSLabel=%_ forwarded for_header_ value rt=Oct 25 2023 09:23:48 deviceExternalId-0 cs4-Forceful Browsing Cs4Label-attack type cs6=CH Cs6Label=geo locatio n c6a1= c6alLabel-device address ¿6a2= c6a2Label=source address c6a3= c6a3Label=destination address c6a4= c6a4Labei=ip address intelligence msg=N/A suid=0 suser=N/A cn2=3 cn2Label=violation
```

Send the log to port 514 on forwarder server
```sh
echo -n "Oct 25 01:22:48 blog.gulaoda.com ASM CEF: 0|Microsoft|ATA|14.1.5|Illegal file type|Illegal file type|6|dvchost=drdc011tm01.dr.icwa.wa.gov.au dvc=10.7.90.115 s1=/Common/adfs-prod-http cslLabel-policy_name cs2=/Common/adfs-prod-http cs2Label=http_class_name deviceCustomDate1=Mar 04 2023 12:41:56 deviceCustomDatelLabel-poicy apply date externalId=3485208313932711252 act=blocked cn1=0 chiLabel=response code Src=35.216.229.155 spt=50388 dst=172.16.90.19 pt=443 requestMethod=GET pp=H IPPS Css-W/A csSLabel=%_ forwarded for_header_ value rt=Oct 25 2023 09:23:48 deviceExternalId-0 cs4-Forceful Browsing Cs4Label-attack type cs6=CH Cs6Label=geo locatio n c6a1= c6alLabel-device address ¿6a2= c6a2Label=source address c6a3= c6a3Label=destination address c6a4= c6a4Labei=ip address intelligence msg=N/A suid=0 suser=N/A cn2=3 cn2Label=violation" | nc -u -w0 localhost 514
```

