# 🔧 Installing `microsoft-sentinel-log-analytics-logstash-output-plugin` for Logstash

This guide helps you:

* ✅ Install **Logstash**
* ✅ Fetch only the Microsoft Sentinel output plugin (no full repo needed)
* ✅ Install the plugin into Logstash
* ✅ Use it in a working config

---

## ✅ Prerequisites

* Root or `sudo` access
* Internet access from the machine
* `java`, `git`, and `ruby` installed
* Logstash version 7.x or 8.x supported

---

## 🏗 Step 1: Install Logstash

### 🔹 For RHEL / CentOS / Rocky Linux

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

### 🔹 For Ubuntu / Debian

```bash
# Install dependencies
sudo apt-get update && sudo apt-get install apt-transport-https gnupg -y

# Add Elastic GPG key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Add Logstash APT repo
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list

# Install Logstash
sudo apt-get update && sudo apt-get install logstash -y
```

![image](https://github.com/user-attachments/assets/b7ad2873-047e-47f0-b2dd-eb5845e2dfb1)

---

### 🔹 Verify Logstash Installed
Try to find the installed location:
```bash
dpkg -L logstash | grep bin/logstash
```
```bash
/usr/share/logstash/bin/logstash --version
```
![image](https://github.com/user-attachments/assets/b8353069-0afb-426f-bf55-4028bd9b0192)

---


### 🔹Start Logstash service
```sh
systemctl enable logstash
```

```sh
systemctl start logstash
```

Check the service state again
```sh
systemctl status logstash
```
![image](https://github.com/user-attachments/assets/bce10737-29cc-41f0-93ab-79dfc2b6491d)

---


## 🛠 Step 2: Install the Plugin

Installation
```bash
/usr/share/logstash/bin/logstash-plugin install microsoft-sentinel-log-analytics-logstash-output-plugin
```
![image](https://github.com/user-attachments/assets/9651ab79-fd1d-4b32-adac-c868bcecb417)


## ✅ Step 3: Verify Plugin Installation

```bash
/usr/share/logstash/bin/logstash-plugin list --verbose | grep sentinel
```
![image](https://github.com/user-attachments/assets/c075fb27-be35-47c8-bbf4-dd70d732c070)

---

## 📄 Step 4: Example Logstash Configuration 
```
cd /etc/logstash/conf.d
```
```
cat > pipeline.conf
```
copy the content below to pipeline.conf

```
input {
    generator {
          lines => [
               "This is a test log message from demo"
          ]
         count => 10
    }
}
output {
 microsoft-sentinel-log-analytics-logstash-output-plugin {
    create_sample_file => true
    sample_file_path => "/tmp" #for example: "c:\\temp" (for windows) or "/tmp" for Linux. 
  }
}
```
![image](https://github.com/user-attachments/assets/1604595e-6d7d-469c-b210-f9e267aeaade)

Verify if the pipeline configuration works as expected
```
systemctl restart logstash
```

```
cd /tmp && ls -al
``` 
You should see the new sample files generated, `download` one of the them, we need it later
![image](https://github.com/user-attachments/assets/b2a530a9-d004-4d1f-948b-581ce991947b)


Sample context
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
---

## 🔗 References

* [Microsoft Sentinel Plugin](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin)
* [Logstash Plugin Dev Guide](https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html)
* [DownGit (Download GitHub folder)](https://minhaskamal.github.io/DownGit/)

---
