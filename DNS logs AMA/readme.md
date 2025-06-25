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

## Filters in DCR

### Filter for `DnsQuery` - domain name

| 域名通配符 | 用途分类 | 说明 |
|------------|----------|------|
| *.microsoft.com | Microsoft 官方域名 | 广泛用于微软各类服务和产品 |
| *.windows.com | Windows 系统服务 | 系统功能、更新、激活、遥测等 |
| *.msftconnecttest.com | 网络连通性测试 | 用于 Windows 网络状态检测（NCSI） |
| *.msedge.net | CDN/内容分发 | Microsoft 服务常用 CDN，例如 Edge 浏览器 |
| *.office.com | Office 服务 | Office Web、Teams、Outlook 等 |
| *.office365.com | Office 365 平台 | 企业办公入口 |
| *.live.com | 账户登录/同步 | 微软账户服务 |
| *.msn.com | 内容门户 | MSN 新闻、天气等 |
| *.microsoftonline.com | 身份验证 | AAD 登录/身份验证 |
| *.microsoftonline-p.com | 身份验证/CDN | 配合 AAD 验证与内容加载 |
| *.msocdn.com | Office CDN | Office 应用资源分发 |
| *.microsoft365.com | Office 365 门户 | Microsoft 365 总入口 |
| *.s-microsoft.com | 分析与遥测 | 用于遥测、遥控和合规性上报 |
| *.azure.com | Azure 官方服务 | Azure 控制台及子服务 |
| *.azureedge.net | Azure CDN | Azure 静态内容边缘加速 |
| *.azurefd.net | Azure Front Door | 流量调度/全局负载均衡 |
| *.azurerms.com | Azure RMS | 资源管理或策略服务 |
| *.visualstudio.com | DevOps 平台 | Azure DevOps、构建服务 |
| *.vsts.me | DevOps 登录 | Azure DevOps 服务子域 |
| *.vsassets.io | 开发资源 | Visual Studio 内容分发 |
| *.onedrive.com | 文件同步 | OneDrive 云盘 |
| *.sharepoint.com | 文件协作 | SharePoint 站点 |
| *.microsoftstream.com | 视频会议 | Microsoft Stream 视频服务 |
| *.msappproxy.net | 反向代理 | Azure App Proxy 通道 |
| *.msidentity.com | 身份验证 | Microsoft Identity 平台 |
| *.aadcdn.microsoftonline-p.com | 身份验证 CDN | AAD 验证相关静态资源 |
| *.windowsupdate.com | Windows 更新 | 系统补丁和服务包获取 |
| *.update.microsoft.com | 更新服务主域 | 系统更新主入口 |
| *.delivery.mp.microsoft.com | 更新 CDN | 分发系统补丁/更新内容 |
| *.dl.delivery.mp.microsoft.com | 更新 CDN | 下载服务器 |
| *.fe2.update.microsoft.com | 更新前端 | 前端代理 |
| *.statsfe2.update.microsoft.com | 遥测统计 | 更新上传统计 |
| *.au.windowsupdate.com | 自动更新 | 旧版 Windows 使用 |
| *.tsfe.trafficshaping.dsp.mp.microsoft.com | 下载调度 | 动态带宽控制 |
| *.do.dsp.mp.microsoft.com | 调度服务 | 优化更新下载路径 |
| *.sls.update.microsoft.com | 许可服务 | SLS 授权与验证 |
| *.emdl.ws.microsoft.com | 电子分发 | 某些 OEM 安装或资源 |
| *.ntservicepack.microsoft.com | 旧版服务包 | Service Pack 下载 |
| *.bing.com | 搜索引擎 | Microsoft Bing |
| *.gstatic.com | Google 静态资源 | 如字体、js等 |
| *.google.com | Google 服务 | 常规搜索、登录 |
| *.googleapis.com | Google API | API服务 |
| *.apple.com | Apple 服务 | iOS/macOS 系统行为 |
| *.icloud.com | iCloud 服务 | 苹果云存储 |
| *.amazon.com | Amazon 网站 | 购物平台 |
| *.aws.amazon.com | AWS 控制台 | Amazon 云服务 |
| *.facebook.com | Facebook 平台 | 社交平台 |
| *.fbcdn.net | Facebook CDN | 内容分发 |
| *.instagram.com | Instagram 平台 | 社交图片分享 |
| *.cdninstagram.com | Instagram CDN | 图片内容分发 |
| *.whatsapp.com | 即时通讯 | WhatsApp 服务 |
| *.baidu.com | 搜索引擎 | 百度搜索与服务 |
| *.bdstatic.com | 百度静态资源 | JS、CSS 等 |
| *.alibaba.com | 阿里巴巴 | 电商/采购平台 |
| *.alicdn.com | 阿里 CDN | 淘宝/天猫 静态资源 |
| *.alipay.com | 支付宝 | 支付服务 |
| *.tencent.com | 腾讯服务 | QQ、微信等 |
| *.wechat.com | 微信官方 | 微信服务 |
| *.qq.com | QQ 相关 | 邮箱、IM等 |
| *.github.com | 开发平台 | GitHub 主站 |
| *.githubusercontent.com | 开发内容 | 代码托管内容 |
| *.youtube.com | 视频服务 | YouTube |
| *.ytimg.com | YouTube CDN | 视频封面/资源 |
| *.netflix.com | 视频平台 | Netflix |
| *.nflximg.net | Netflix CDN | 静态资源 |
| *.nflxvideo.net | Netflix 视频 | 视频流 |
| *.arc-msedge.net | Azure Arc 路由 | Arc 客户端与控制平面通信 |
| *.t-msedge.net | Microsoft 路由层 | Traffic Manager 子域 |
| *.a-msedge.net | CDN 层 | Microsoft 边缘分发 |
| *.ax-msedge.net | CDN 层 | 附加边缘分发域 |
| *.b-msedge.net | CDN 层 | 静态资源分发 |
| *.l-msedge.net | CDN 层 | Edge/Skype/配置服务 |
| *.cn-msedge.net | 中国节点 | 针对中国地区优化访问 |
| *.ln-msedge.net | LinkedIn 节点 | LinkedIn 加速 |
| *.trafficmanager.net | 流量调度平台 | Microsoft Azure Traffic Manager 动态负载均衡服务 |

