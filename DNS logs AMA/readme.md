# 📡 Stream and Filter Data from Windows DNS Servers with the AMA Connector

[👉 Official Guide](https://learn.microsoft.com/en-us/azure/sentinel/connect-dns-ama)

---

### 🧰 Step 1: Deploy DNS Servers

By default, the **Domain Controller (DC)** acts as the primary (master) DNS server in a domain.

If you'd like to test using a **separate DNS server**, you can [deploy a secondary DNS server](https://www.youtube.com/watch?v=g9w8apZnbg0).

---

#### ✅ Install DNS Server Role on the Secondary Server

![Install DNS Server](https://user-images.githubusercontent.com/96930989/226557476-5987a954-a115-4a59-9b8c-db2b5fa19d56.png)

---

#### 🗂 Create a DNS Zone

Follow the wizard and **enter the same DNS zone name** as configured on your master DNS server (DC):

![Create DNS Zone 1](https://user-images.githubusercontent.com/96930989/226562899-3b32602c-26b2-4f76-a607-98465c5e8719.png)
![Create DNS Zone 2](https://user-images.githubusercontent.com/96930989/226562946-0f9da621-e4b3-411f-838f-f4ed9a0bd4dd.png)
![Create DNS Zone 3](https://user-images.githubusercontent.com/96930989/226562984-fd84a321-d70a-416a-b02b-ef6e2930c888.png)
![Zone Name Input](https://user-images.githubusercontent.com/96930989/226565253-18c6eb19-feb4-4417-8957-1918a9161115.png)

---

#### 📥 Configure Master DNS IP

Specify the IP address of the master DNS server (DC):

![Input Master IP](https://user-images.githubusercontent.com/96930989/226565294-ac68d8bd-4f51-4904-8cef-c80f4c0e7a07.png)

---

#### 🔄 Allow DNS Zone Transfer on the Master Server

On the **DC (master)**:

1. Allow zone transfers
2. Define the IP of the secondary DNS server
3. Add the secondary server to the **Notify List**

![Navigate to Master](https://user-images.githubusercontent.com/96930989/226565603-e3dcf0e0-ce0a-421e-930b-af5282b6de35.png)
![Allow Transfers](https://user-images.githubusercontent.com/96930989/226566541-0fbb044d-8829-48ee-ae37-4bb31630f8c3.png)
![Notify List](https://user-images.githubusercontent.com/96930989/226568068-a9e60ad0-b9b4-49de-979e-338019ca2a21.png)

Then go back to the **secondary server** and refresh:

![Refresh Zone](https://user-images.githubusercontent.com/96930989/226568342-1defd0a4-100f-43f8-a8a9-99ff8e41cb7c.png)

You may also adjust the refresh interval on the master server:

![Refresh Interval](https://user-images.githubusercontent.com/96930989/226570742-0ebc10d6-9741-4b3b-a06c-44094f4a1abf.png)

---

### ⚙️ Step 2: [Install Azure Monitor Agent (AMA)](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-powershell#install)

Follow the official instructions to install AMA on both DNS servers.

---

### 📌 Step 3: Configure the DNS Data Connector in Sentinel

1. Go to **Sentinel > Content Hub**, search for and install the **DNS solution** <br>
   ![Install DNS Solution](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/66deacbb-3012-4cbf-ac57-4e336202f5a9)

2. After 5 minutes, navigate to `Data connectors`, find the DNS connector, and open it <br>
   ![Open DNS Connector](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f51c8c7d-2e14-4897-8568-de93202a41de)

3. Click **Edit DCR**, then assign it to the target VM or **Arc-enabled VM** <br>
   ![Edit DCR](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f0bc71fb-574f-41c3-b484-49e427d78547)

4. **Restart the DNS server** to apply DCR assignment changes.

---

## 🧪 Lab Setup Reference

### 🖥️ Environment Topology

> Client (Windows 10, domain-joined) → Secondary DNS Server → Domain Controller (DC)

| Machine              | IP Address       |
| -------------------- | ---------------- |
| Client               | `192.168.50.176` |
| Secondary DNS Server | `192.168.50.169` |
| DC (Master DNS)      | `192.168.50.103` |

The **client machine** is configured to use the **secondary DNS server**.

---

### 🔍 Sample KQL Query for DNS Logs

```kusto
ASimDnsActivityLogs
| where SrcIpAddr != "192.168.50.169"  // IP of secondary DNS server
| where SrcIpAddr != "192.168.50.103"  // IP of Master DNS server (DC)
| where EventSubType == "request"      // DNS query request only
| where DnsQuery contains "telerik.com"
| project TimeGenerated, EventSubType, SrcIpAddr, DnsQuery
| order by TimeGenerated desc 
```

> ✅ This query helps confirm whether the original client machine is generating DNS traffic.

📷 Sample Output:

![DNS Log Output](https://user-images.githubusercontent.com/96930989/234183170-2eb0d0f6-b36a-46d4-9484-3fd25a902b7d.png)

---

### ⚠️ Important Note

If your DNS query flow is:

```
Client → DC (DNS) → Third-party forwarder → Azure VM DNS
```

It’s **expected** that the original source IP might not appear in logs due to intermediate forwarding. In such cases, the event only reflects that the DNS name was resolved—not the identity of the original requester.

---
