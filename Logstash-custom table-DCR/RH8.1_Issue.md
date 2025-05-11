# 🦾 Install Logstash 7.3.2 + JDK 1.8 on AWS EC2 (Red Hat 8.1)

This guide walks you through a **clean installation** of Logstash 7.3.2 and OpenJDK 1.8 on a **Red Hat 8.1 EC2 instance**, using the official Elastic YUM repository with full systemd support.

---

## 🧰 Prerequisites

Make sure you have the following ready:

- ✅ AWS EC2 instance running **RHEL 8.1**
- ✅ `sudo` user privileges
- ✅ Internet access

---

## 📦 Step 1: Update System & Install Basic Tools

```bash
sudo dnf update -y
sudo dnf install -y wget curl unzip vim
```

---

## ☕ Step 2: Install OpenJDK 1.8

```bash
sudo dnf install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
```

### ✅ Verify Java installation

```bash
java -version
```

Example output:

```
openjdk version "1.8.0_412"
OpenJDK Runtime Environment ...
```

---

## 🔐 Step 3: Add Elastic YUM Repository

```bash
# Import Elastic GPG key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Add Elastic 7.x repository
sudo tee /etc/yum.repos.d/logstash.repo > /dev/null <<EOF
[logstash-7.x]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
enabled=1
autorefresh=1
type=rpm-md
EOF
```

---

## 🧹 Step 4: Clean Previous Installations (If Any)

```bash
sudo yum remove -y logstash
sudo rm -rf /etc/logstash /usr/share/logstash /var/log/logstash /etc/systemd/system/logstash.service
```

---

## 📥 Step 5: Install Logstash 7.3.2

```bash
sudo yum install -y logstash-7.3.2
```

### ✅ Verify Logstash version

```bash
/usr/share/logstash/bin/logstash --version
```

Expected output:

```
logstash 7.3.2
```

---

## ▶️ Step 6: Enable & Start Logstash Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now logstash
```

### ✅ Check Logstash service status

```bash
sudo systemctl status logstash
```

---

## 🧪 Step 7: Quick Test with Sample Pipeline (Optional)

### Create a sample config

```bash
sudo tee /etc/logstash/conf.d/test.conf > /dev/null <<EOF
input {
  stdin { }
}
output {
  stdout { codec => rubydebug }
}
EOF
```

### Run Logstash manually

```bash
sudo /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/test.conf
```

🟢 Now type something and hit Enter — you’ll see parsed JSON output.

---

## 🧪 Validate Logstash Configuration (Dry Run)

Before starting Logstash with a new pipeline, validate its syntax:

```bash
/usr/share/logstash/bin/logstash -t -f /etc/logstash/conf.d/test.conf
```

```bash
/usr/share/logstash/bin/logstash -t -f /etc/logstash/conf.d/pipeline.conf
```

### ✔️ Valid output

```
Sending Logstash logs to /var/log/logstash...
Configuration OK
```

### ❌ On error

```
[ERROR] Expected one of #, => at line 3, column 10 ...
```

### Sample

```bash
/usr/share/logstash/bin/logstash -t -f /etc/logstash/conf.d/pipeline.conf
```
![image](https://github.com/user-attachments/assets/1155a266-a12f-4191-a0b6-40f336796cd3)

Enable debug logs
```bash
/usr/share/logstash/bin/logstash --log.level debug -t -f /etc/logstash/conf.d/pipeline.conf
```

### 🔍 Validate all configs in pipeline directory

```bash
/usr/share/logstash/bin/logstash -t -f /etc/logstash/conf.d/
```

---

## 🎉 Installation Summary

You have successfully installed:

- 🟢 **OpenJDK 1.8**
- 🟢 **Logstash 7.3.2**
- 🟢 **Systemd-based Logstash service**

---

## 📚 What’s Next?

Try building a real-world Logstash pipeline:

- 🔁 Forward logs to **Elasticsearch**
- 📤 Send alerts to **Azure Sentinel**
- 📄 Output to **local files** or **syslog**
