# 🚀 Quickstart Guide: Installing `microsoft-sentinel-log-analytics-logstash-output-plugin` for Logstash Integration with Microsoft Sentinel

This guide helps you:

* ✅ Install **Logstash**
* ✅ Install the Microsoft Sentinel output plugin only (no full repo clone needed)
* ✅ Integrate the plugin with Logstash
* ✅ Configure and test ingestion with sample data
* ✅ Create DCR/DCE and a custom table for Microsoft Sentinel ingestion

---

## ✅ Prerequisites

* Root or `sudo` access
* Internet access
* `java`, `git`, and `ruby` installed
* Logstash version **7.x** or **8.x**

---

## 🏗 Step 1: Install Logstash

### 🔹 RHEL / CentOS / Rocky Linux

```bash
# Import Elastic GPG key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Create repo file
sudo tee /etc/yum.repos.d/logstash.repo <<EOF
[logstash]
name=Elastic repository for Logstash
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
enabled=1
autorefresh=1
type=rpm-md
EOF

# Install Logstash
sudo yum install logstash -y
```

---

### 🔹 Ubuntu / Debian

```bash
sudo apt-get update && sudo apt-get install apt-transport-https gnupg -y

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list

sudo apt-get update && sudo apt-get install logstash -y
```

![image](https://github.com/user-attachments/assets/b7ad2873-047e-47f0-b2dd-eb5845e2dfb1)

---

### 🔹 Verify Installation

```bash
dpkg -L logstash | grep bin/logstash
/usr/share/logstash/bin/logstash --version
```

![image](https://github.com/user-attachments/assets/b8353069-0afb-426f-bf55-4028bd9b0192)

---

### 🔹 Start Logstash

```bash
sudo systemctl enable logstash
sudo systemctl start logstash
sudo systemctl status logstash
```

![image](https://github.com/user-attachments/assets/bce10737-29cc-41f0-93ab-79dfc2b6491d)

---

## 🛠 Step 2: Install the Plugin

```bash
/usr/share/logstash/bin/logstash-plugin install microsoft-sentinel-log-analytics-logstash-output-plugin
```

![image](https://github.com/user-attachments/assets/9651ab79-fd1d-4b32-adac-c868bcecb417)

---

## ✅ Step 3: Verify Plugin Installation

```bash
/usr/share/logstash/bin/logstash-plugin list --verbose | grep sentinel
```

![image](https://github.com/user-attachments/assets/c075fb27-be35-47c8-bbf4-dd70d732c070)

---

## 📄 Step 4: Sample Logstash Config

```bash
cd /etc/logstash/conf.d
cat > pipeline.conf
```

Copy this content into `pipeline.conf`:

```logstash
input {
    generator {
        lines => [ "This is a test log message from demo" ]
        count => 10
    }
}
output {
    microsoft-sentinel-log-analytics-logstash-output-plugin {
        create_sample_file => true
        sample_file_path => "/tmp"
    }
}
```

Restart Logstash:

```bash
systemctl restart logstash
cd /tmp && ls -al
```

![image](https://github.com/user-attachments/assets/b2a530a9-d004-4d1f-948b-581ce991947b)

---

### 🔍 Sample Output Format

<details>
<summary>Click to expand sample JSON output</summary>

```json
[
  {
    "event": { "original": "This is a test log message from demo", "sequence": 7 },
    "message": "This is a test log message from demo",
    "host": { "name": "Jump" },
    "ls_timestamp": "2025-05-07T04:12:59.393961364Z",
    "ls_version": "1"
  }
  ...
]
```

</details>

---

## ✅ Step 5: Create DCR, DCE & Custom Table

**Docs:**
[🔗 Microsoft Guide](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules#create-dcr-resources-for-ingestion-into-a-custom-table)

### 1. [Configure Application](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#configure-the-application)

Collect:

* tenant id
* app id / client secret

### 2. [Create Data Collection Endpoint](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#create-a-data-collection-endpoint)

![image](https://user-images.githubusercontent.com/96930989/217995625-8a16f928-2aad-4ef4-9b6b-b5a4b8c7cf7b.png)

---

### 3. [Create Custom Table](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#parse-and-filter-sample-data)

Modify KQL:

```kusto
source
| extend TimeGenerated = ls_timestamp
```

![image](https://user-images.githubusercontent.com/96930989/217982753-7ae92e05-efca-441a-92c6-394147e37f97.png)

---

### 4. [Collect DCR Info](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/tutorial-logs-ingestion-portal#collect-information-from-the-dcr)

![image](https://user-images.githubusercontent.com/96930989/217995923-f3c9c9da-6347-4136-bf09-c049b0851874.png)

---

### 5. Assign DCR Permission

![image](https://user-images.githubusercontent.com/96930989/217984174-1ee6f384-6ad8-45ee-ad6f-95725bdcd9cc.png)

---

### 6. Assign DCR to VM

![image](https://user-images.githubusercontent.com/96930989/217984223-fe06060e-1d9f-4e7c-b375-e2876caf7ef4.png)

---

## ✅ Step 6: Full Pipeline Config

```bash
cd /etc/logstash/conf.d
rm pipeline.conf
cat > pipeline1.conf
```

```logstash
input {
    generator {
        lines => [ "This is a test log message from demo" ]
        count => 10
    }
}
output {
  microsoft-sentinel-log-analytics-logstash-output-plugin {
    client_app_Id => "<your_client_app_id>"
    client_app_secret => "<your_client_secret>"
    tenant_id => "<your_tenant_id>"
    data_collection_endpoint => "<your_DCE_logsIngestion_URI>"
    dcr_immutable_id => "<your_DCR_immutableId>"
    dcr_stream_name => "<your_stream_name>"
    create_sample_file => false
    sample_file_path => "/tmp"
  }
}
```

```bash
systemctl restart logstash
```

Wait a few minutes, then check the table:

![image](https://user-images.githubusercontent.com/96930989/217994591-d8d67409-11c5-44f1-b275-6ebdc0aea3b8.png)

---

## ✅ Troubleshooting Guide

1. Confirm DCR/DCE assigned to VM
   ![image](https://user-images.githubusercontent.com/96930989/221455738-e43af103-4b5b-4278-b426-047b52ab9b46.png)

2. Ensure custom table is correctly selected
   ![image](https://user-images.githubusercontent.com/96930989/221455636-0bbd3c78-9cd5-4029-80ef-62e4cba063dd.png)

3. Check schema
   ![image](https://user-images.githubusercontent.com/96930989/221455924-a64d3ce8-9135-4320-8a40-8184ef1f3e13.png)

4. Validate Logstash service

   ```bash
   systemctl status logstash
   ```

   ![image](https://user-images.githubusercontent.com/96930989/213091935-d89b3f36-995c-4559-a49e-bf9e66d4d9fb.png)

5. Backup config & test sample output

---

## 🔗 References

* [🔌 Microsoft Sentinel Plugin](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin)
* [📘 Logstash Plugin Development Guide](https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html)
* [📥 DownGit Tool](https://minhaskamal.github.io/DownGit/)

---
