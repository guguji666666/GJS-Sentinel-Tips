# 🚀 Quickstart Guide

## Integrate Logstash with Microsoft Sentinel using `microsoft-sentinel-log-analytics-logstash-output-plugin`

This guide walks you through:

* ✅ Installing **Logstash**
* ✅ Installing the **Microsoft Sentinel Log Analytics output plugin** (no full repo clone required)
* ✅ Configuring the plugin within Logstash
* ✅ Sending test data to verify ingestion
* ✅ Creating **DCR**, **DCE**, and a custom **Log Analytics table** for Microsoft Sentinel

---

## 🔄 Logstash Processing Workflow

```text
+---------------------------+
|   Pipeline Configuration  |
|  (/etc/logstash/conf.d/) |
+---------------------------+

[Inputs] --> [Filters] --> [Outputs]
     (1)        (2)           (3)

+---------+ +---------+ +----------+ +------------+ +-----------+ +----------+
| Redis   | | Apache  | | JDBC     | | alter      | | Elastic   | | Graphite |
| Syslog  | | JMS     | | RabbitMQ| | aggregate  | | MongoDB   | | InfluxDB |
| csv     |           |           | | clone      | |           | | StatsD   |
+---------+ +---------+ +----------+ | range      | +-----------+ +----------+
                                     | mutate     |
                                     +------------+
```

![Logstash Workflow](https://github.com/user-attachments/assets/f8e774a1-df8b-4aa2-85b6-8a26bd6c2582)

---

## ✅ Prerequisites

Before starting, ensure the following are available:

* Root or `sudo` access
* Internet connectivity
* Installed: `java`, `git`, `ruby`
* Logstash version **7.x** or **8.x**

---

## ☕ JDK Integration in Logstash (7.10.0+)

From **Logstash 7.10.0**, the distribution includes a bundled JDK for easier setup.

📘 [Logstash 7.10.0 Release Notes](https://www.elastic.co/guide/en/logstash/7.14/logstash-7-10-0.html)

> No need to install Java separately – it's already bundled.

![JDK Info](https://github.com/user-attachments/assets/521f516d-eefe-47c0-a42b-73873b3d5a5c)

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

Verify if OpenJDK exists as well (after logstash 7.10.0)
```bash
/usr/share/logstash/jdk/bin/java -version
```
![image](https://github.com/user-attachments/assets/3dbafe86-d56f-4644-90dd-341a5fb7f6f6)

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
sudo systemctl daemon-reload
```

```bash
systemctl restart logstash
```

```bash
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
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 7
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393961364Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 3
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.392715439Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 1
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.391903723Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 0
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.387581635Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 4
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393050546Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 6
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393661758Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 8
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.394569976Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 9
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.394891583Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 5
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.393312451Z",
        "ls_version": "1"
    },
    {
        "event": {
            "original": "This is a test log message from demo",
            "sequence": 2
        },
        "message": "This is a test log message from demo",
        "host": {
            "name": "Jump"
        },
        "ls_timestamp": "2025-05-07T04:12:59.392338331Z",
        "ls_version": "1"
    }
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

![image](https://github.com/user-attachments/assets/08ffceb3-8857-4593-86c6-11acd50d0b4e)

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

![image](https://github.com/user-attachments/assets/2f2cdfb3-15c4-4c1c-9c64-ab820e880363)

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

![image](https://github.com/user-attachments/assets/e3b67f0e-2bb0-4403-b395-d678f84e55df)

---

## ✅ Troubleshooting Guide

1. Confirm DCR/DCE assigned to VM
   ![image](https://user-images.githubusercontent.com/96930989/221455738-e43af103-4b5b-4278-b426-047b52ab9b46.png)

2. Ensure custom table is correctly selected
   ![image](https://user-images.githubusercontent.com/96930989/221455636-0bbd3c78-9cd5-4029-80ef-62e4cba063dd.png)

3. Check schema
   ![image](https://user-images.githubusercontent.com/96930989/221455924-a64d3ce8-9135-4320-8a40-8184ef1f3e13.png)

4. Validate Logstash service, make sure it is running

   ```bash
   systemctl status logstash
   ```

5. Backup config & test sample output

---

## 🔗 References

* [🔌 Microsoft Sentinel Plugin](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin)
* [📘 Logstash Plugin Development Guide](https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html)
* [📥 DownGit Tool](https://minhaskamal.github.io/DownGit/)

---
