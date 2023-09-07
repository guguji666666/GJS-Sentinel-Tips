# Collect Meraki logs via oms agent

## 1. Modify `/etc/rsyslog.conf`

<img width="1059" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1a5ab5b7-5bd9-42d5-b831-4d18db8b5289">

## 2. Modify `/etc/rsyslog.d/10-meraki.conf`

```
if $rawmsg contains "MX84 flows" then @@127.0.0.1:22033;meraki
& stop
if $rawmsg contains "MX84 urls" then @@127.0.0.1:22033;meraki
& stop
if $rawmsg contains "MX84 ids-alerts" then @@127.0.0.1:22033;meraki
& stop
if $rawmsg contains "MX84 events" then @@127.0.0.1:22033;meraki
& stop
if $rawmsg contains "MR18 events" then @@127.0.0.1:22033;meraki
& stop
if $rawmsg contains "MS220_8P events" then @@127.0.0.1:22033;meraki
& stop
```

## 3. Manually generate logs using logger commands

```
logger -n 127.0.0.1 -p local4.warn "1374543213.342705328 MX84 urls src=192.168.1.186:63735 dst=69.58.188.40:80 mac=58:1F:AA:CE:61:F2 request: GET https://..."

logger -n 127.0.0.1 -p local4.warn "1374543986.038687615 MX84 flows src=192.168.1.186 dst=8.8.8.8 mac=58:1F:AA:CE:61:F2 protocol=udp sport=55719 dport=53 pattern: allow all"

logger -n 127.0.0.1 -p local4.warn "1377449842.514782056 MX84 ids-alerts signature=129:4:1 priority=3 timestamp=1377449842.512569 direction=ingress protocol=tcp/ip src=74.125.140.132:80"

logger -n 127.0.0.1 -p local4.warn "1380664994.337961231 MX84 events type=vpn_connectivity_change vpn_type='site-to-site' peer_contact='98.68.191.209:51856' peer_ident='2814ee002c075181bb1b7478ee073860' connectivity='true'"

logger -n 127.0.0.1 -p local4.warn "1377448470.246576346 MX84 ids-alerts signature=119:15:1 priority=2 timestamp=1377448470.238064 direction=egress protocol=tcp/ip src=192.168.111.254:56240 signature=1:28423:1 priority=1 timestamp=1468531589.810079 dhost=98:5A:EB:E1:81:2F direction=ingress protocol=tcp/ip src=151.101.52.238:80 dst=192.168.128.2:53023 message: EXPLOIT-KIT Multiple exploit kit single digit exe detection url=http://www.eicar.org/download/eicar.com.txt src=192.168.128.2:53150 dst=188.40.238.250:80 mac=98:5A:EB:E1:81:2F name='EICAR:EICAR_Test_file_not_a_virus-tpd'// 1563249630.774247467 remote_DC1_appliance security_event ids_alerted signature=1:41944:2 priority=1 timestamp=TIMESTAMPEPOCH.647461 dhost=74:86:7A:D9:D7:AA direction=ingress protocol=tcp/ip src=23.6.199.123:80 dst=10.1.10.51:56938 message: BROWSER-IE Microsoft Edge scripting engine security bypass css attempt"

logger -n 127.0.0.1 -p local4.warn "1380653443.857790533 MR18 events type=device_packet_flood radio='0' state='end' alarm_id='4' reason='left_channel' airmarshal_events type= rogue_ssid_detected ssid='' bssid='02:18:5A:AE:56:00' src='02:18:5A:AE:56:00' dst='02:18:6A:13:09:D0' wired_mac='00:18:0A:AE:56:00' vlan_id='0' channel='157' rssi='21' fc_type='0' fc_subtype='5'"

logger -n 127.0.0.1 -p local4.warn "1380653443.857790533 MS220_8P events type=8021x_eap_success port='' identity='employee@ikarem.com'"

```

Meanwile, launch another ssh seesion and run the command:
```
sudo tcpdump -A -ni any port 22033 -vv
```

## 4. Check the logs in the workspace

<img width="1906" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/6bf6524b-0594-4147-bc06-81231caeaaa1">

