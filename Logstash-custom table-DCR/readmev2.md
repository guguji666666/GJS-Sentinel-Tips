Certainly! Here's an optimized and comprehensive `README.md` for your GitHub repository [GJS-Sentinel-Tips](https://github.com/guguji666666/GJS-Sentinel-Tips/tree/main/Logstash-custom%20table-DCR), specifically tailored for the `Logstash-custom table-DCR` directory. This guide provides clear instructions on setting up Logstash to forward logs to Microsoft Sentinel using Data Collection Rules (DCRs).

---

# 📘 Logstash to Microsoft Sentinel via DCR (Custom Table)

This guide demonstrates how to configure Logstash to forward logs to Microsoft Sentinel using Data Collection Rules (DCRs) and the `microsoft-sentinel-log-analytics-logstash-output-plugin`.([Microsoft Learn][1])

---

## 📋 Prerequisites

* **Logstash** installed (version 7.0–7.17.13 or 8.0–8.15).
* **Java** installed and `JAVA_HOME` environment variable set.
* **Ruby** installed.
* Access to an **Azure Log Analytics Workspace**.
* Permissions to create **Data Collection Endpoints (DCEs)** and **Data Collection Rules (DCRs)**.
* **Azure Active Directory (AAD)** application with appropriate permissions.([Microsoft Learn][2], [GitHub][3], [Medium][4])

---

## 🛠️ Step 1: Install Logstash

### For Ubuntu/Debian:

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install logstash
```

### For RHEL/CentOS:

```bash
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo tee /etc/yum.repos.d/logstash.repo <<EOF
[logstash]
name=Elastic repository for Logstash
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
enabled=1
autorefresh=1
type=rpm-md
EOF
sudo yum install logstash
```

---

## 🔌 Step 2: Install Microsoft Sentinel Output Plugin

```bash
sudo /usr/share/logstash/bin/logstash-plugin install microsoft-sentinel-log-analytics-logstash-output-plugin
```

> Ensure that your Logstash version is compatible with the plugin.

---

## 🧪 Step 3: Create Sample Log Data

Generate a sample log file to define the schema for your custom table:([Medium][4])

```bash
sudo mkdir /tmp/logstash
sudo tee /etc/logstash/conf.d/sample.conf > /dev/null <<EOF
input {
  generator {
    lines => ["This is a test log message"]
    count => 10
  }
}
output {
  microsoft-sentinel-log-analytics-logstash-output-plugin {
    create_sample_file => true
    sample_file_path => "/tmp/logstash/"
  }
}
EOF
```

Run Logstash to generate the sample file:([Microsoft Learn][1])

```bash
sudo /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/sample.conf
```

The sample file (e.g., `sampleFile<epoch>.json`) will be created in `/tmp/logstash/`.([Microsoft Learn][1])

---

## ☁️ Step 4: Configure Azure Resources

### 4.1 Create Data Collection Endpoint (DCE)

1. Navigate to **Azure Portal** > **Monitor** > **Data Collection Endpoints**.
2. Click **+ Create** and provide necessary details.
3. After creation, note the **Logs Ingestion URI**.([Medium][4])

### 4.2 Create Data Collection Rule (DCR) and Custom Table

1. Go to **Azure Portal** > **Log Analytics Workspace** > **Tables**.
2. Click **+ Create** and select **Custom Logs (DCR-based)**.
3. Upload the sample JSON file generated earlier.
4. Define the schema and transformation as needed.
5. Associate the DCR with the previously created DCE.([GitHub][5], [Medium][4])

### 4.3 Register Azure AD Application

1. Navigate to **Azure Portal** > **Azure Active Directory** > **App registrations**.
2. Click **+ New registration**, provide a name, and register the application.
3. Under **Certificates & secrets**, create a new client secret.
4. Note the **Application (client) ID**, **Directory (tenant) ID**, and **Client Secret**.([Medium][4])

---

## ⚙️ Step 5: Configure Logstash Pipeline

Create a new Logstash configuration file:

```bash
sudo tee /etc/logstash/conf.d/sentinel.conf > /dev/null <<EOF
input {
  file {
    path => "/var/log/syslog"
    start_position => "beginning"
  }
}
output {
  microsoft-sentinel-log-analytics-logstash-output-plugin {
    client_app_Id => "<Your Client ID>"
    client_app_secret => "<Your Client Secret>"
    tenant_id => "<Your Tenant ID>"
    data_collection_endpoint => "<Your DCE Logs Ingestion URI>"
    dcr_immutable_id => "<Your DCR Immutable ID>"
    dcr_stream_name => "<Your Stream Name>"
  }
}
EOF
```

Replace placeholders with your actual Azure AD application credentials and DCR details.([Medium][4])

---

## 🚀 Step 6: Start Logstash

Start the Logstash service:

```bash
sudo systemctl start logstash
```

Enable Logstash to start on boot:

```bash
sudo systemctl enable logstash
```

---

## 🔍 Step 7: Verify Data Ingestion

In the Azure Portal:

1. Navigate to **Microsoft Sentinel** > **Logs**.
2. Under **Custom Logs**, find your newly created table (e.g., `CustomLog_CL`).
3. Run a query to verify data ingestion:([Microsoft Learn][2])

```kusto
CustomLog_CL
| limit 10
```

---

## 🛠️ Troubleshooting

* Ensure that the Azure AD application has the necessary permissions to write to the Log Analytics workspace.
* Verify network connectivity between your Logstash instance and Azure endpoints.
* Check Logstash logs for any errors:([GitHub][6])

```bash
sudo journalctl -u logstash -f
```

---

## 📚 References

* [Microsoft Sentinel: Connect Logstash with DCR-based API](https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules)
* [Logstash Working with Plugins](https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html)
* [Azure Monitor: Custom Logs Migration](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/custom-logs-migrate)

---

Feel free to contribute or raise issues for any enhancements or problems encountered.

---

[1]: https://learn.microsoft.com/pt-pt/azure/sentinel/connect-logstash-data-connection-rules?utm_source=chatgpt.com "Use Logstash to stream logs with pipeline transformations via DCR-based ..."
[2]: https://learn.microsoft.com/en-us/azure/sentinel/connect-logstash-data-connection-rules?utm_source=chatgpt.com "Use Logstash to stream logs with pipeline transformations via DCR ..."
[3]: https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/microsoft-logstash-output-azure-loganalytics/README.md?utm_source=chatgpt.com "Azure Log Analytics output plugin for Logstash - GitHub"
[4]: https://koosg.medium.com/ingest-dcr-based-custom-logs-in-microsoft-sentinel-with-logstash-f94c79e69b93?utm_source=chatgpt.com "Ingest DCR-based custom logs in Microsoft Sentinel with Logstash"
[5]: https://github.com/Azure/Azure-Sentinel/issues/10975?utm_source=chatgpt.com "Creating a new custom log (DCR Based) doe not give you the option ..."
[6]: https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin/README.md?utm_source=chatgpt.com "Microsoft Sentinel output plugin for Logstash - GitHub"
