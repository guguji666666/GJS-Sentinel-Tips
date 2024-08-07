## [Stream and filter data from Windows DNS servers with the AMA connector](https://learn.microsoft.com/en-us/azure/sentinel/connect-dns-ama)

### 1. Deploy DNS server
DC would be the master DNS server in the domain by default

[Deploy a secondary DNS server](https://www.youtube.com/watch?v=g9w8apZnbg0) in the domain if you want to test on a separated DNS server

#### Install DNS Server role on the secondary DNS server
![image](https://user-images.githubusercontent.com/96930989/226557476-5987a954-a115-4a59-9b8c-db2b5fa19d56.png)

#### Create DNS zone
![image](https://user-images.githubusercontent.com/96930989/226562899-3b32602c-26b2-4f76-a607-98465c5e8719.png)

![image](https://user-images.githubusercontent.com/96930989/226562946-0f9da621-e4b3-411f-838f-f4ed9a0bd4dd.png)

![image](https://user-images.githubusercontent.com/96930989/226562984-fd84a321-d70a-416a-b02b-ef6e2930c888.png)

Input the same DNS zone name found from your master DNS server (DC in this lab)

![image](https://user-images.githubusercontent.com/96930989/226565253-18c6eb19-feb4-4417-8957-1918a9161115.png)

#### Input the IP of master DNS server (DC in this lab)
![image](https://user-images.githubusercontent.com/96930989/226565294-ac68d8bd-4f51-4904-8cef-c80f4c0e7a07.png)

#### Allow DNS Zone Transfer

Navigate to master DNS server (DC in this lab)
![image](https://user-images.githubusercontent.com/96930989/226565603-e3dcf0e0-ce0a-421e-930b-af5282b6de35.png)

Allow Zone transfers and define the IP of secondary DNS server

![image](https://user-images.githubusercontent.com/96930989/226566541-0fbb044d-8829-48ee-ae37-4bb31630f8c3.png)

Also add the secondary DNS server to the notify list

![image](https://user-images.githubusercontent.com/96930989/226568068-a9e60ad0-b9b4-49de-979e-338019ca2a21.png)

Then refresh on the secondary DNS server

![image](https://user-images.githubusercontent.com/96930989/226568342-1defd0a4-100f-43f8-a8a9-99ff8e41cb7c.png)

We can also modify the refresh interval here on the master DNS server (DC)

![image](https://user-images.githubusercontent.com/96930989/226570742-0ebc10d6-9741-4b3b-a06c-44094f4a1abf.png)

### 2. [Install AMA](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-powershell#install)

### 3. Configure data connector in Sentinel

Install the solution from Sentinel content hub <br>
<img width="1939" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/66deacbb-3012-4cbf-ac57-4e336202f5a9">

![image](https://github.com/user-attachments/assets/92483571-64ab-432a-8b05-96ecd6720e3c)

Once installed, wait for 5 minutes and navigate to `data connectors`, find this connector and open it<br>
<img width="1949" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f51c8c7d-2e14-4897-8568-de93202a41de">

Edit DCR here, assign it to Azure VM or Arc-enabled VM <br>
<img width="2255" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f0bc71fb-574f-41c3-b484-49e427d78547">

Restart the DNS server to get update on DCR assignment

## Lab for reference

1. I built the lab following the flow: Client (domain joined) > Secondary DNS server > DC (Master DNS server)
2. IP table of the machines
* Client machine running win 10 	192.168.50.176
* Secondary DNS server	192.168.50.169
* DC	192.168.50.103
3. I set the secondary DNS server as the DNS server used by the client machine running win 10, then I access several DNS on the client machine
4. In the workspace, I ran the KQL query below and it seems the DNS related logs contains the source that generates the DNS query request.

```kusto
ASimDnsActivityLogs
| where SrcIpAddr != "192.168.50.169"  // IP of secondary DNS server
| where SrcIpAddr != "192.168.50.103"  // IP of Master DNS server (DC)
| where EventSubType == "request"      // We focus on the DNS query request from the client machine
| where DnsQuery contains "telerik.com" // The DNS you want to filter
| project TimeGenerated, EventSubType, SrcIpAddr, DnsQuery
| order by TimeGenerated desc 
```

Output <br>
![image](https://user-images.githubusercontent.com/96930989/234183170-2eb0d0f6-b36a-46d4-9484-3fd25a902b7d.png)

If the flow is Client > AD (DNS server)> 3rd party forwarder > Forward to Azure VM DNS, it is expected that the source that generates DNS query request may be missing since there are multiple components involved in the workflow to transfer the request and the incident itself is supposed to focus on the fact the specified DNS is being touched.

