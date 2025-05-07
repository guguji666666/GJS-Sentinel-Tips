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
![image](https://github.com/user-attachments/assets/f381428c-d8d0-4342-9626-3cff8249b96e)

---

## 📦 Step 2: Download Only the Plugin Folder

### Option 1: Use Git Sparse Checkout (Recommended)

```bash
# Create working dir
mkdir sentinel-plugin && cd sentinel-plugin

# Init sparse git repo
git init
git remote add origin https://github.com/Azure/Azure-Sentinel.git
git config core.sparseCheckout true

# Define target folder only
echo "DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin" >> .git/info/sparse-checkout

# Pull only that subfolder
git pull origin master

# Move into plugin directory
cd DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin
```

---

### Option 2: Direct ZIP Download (No Git Required)

📥 Use [DownGit](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin) to download only the plugin folder as ZIP.

Then extract and `cd` into the plugin directory.

---

## 🛠 Step 3: Install the Plugin

### Method 1: Install from Folder (Direct Install)

```bash
/opt/logstash/bin/logstash-plugin install --no-verify --local .
```

If this fails, proceed to manual `.gem` build method.

---

### Method 2: Build and Install Gem

```bash
# Build the plugin gem
gem build microsoft-sentinel-log-analytics-logstash-output-plugin.gemspec

# Install the .gem file into Logstash
sudo /opt/logstash/bin/logstash-plugin install logstash-output-microsoft-sentinel-log-analytics-*.gem
```

---

## ✅ Step 4: Verify Plugin Installation

```bash
/opt/logstash/bin/logstash-plugin list --verbose | grep sentinel
```

---

## 📄 Step 5: Example Logstash Configuration

```ruby
input {
  stdin {}
}

output {
  microsoft-sentinel-log-analytics-logstash-output-plugin {
    workspace_id => "<Your Workspace ID>"
    shared_key   => "<Your Primary Key>"
    log_type     => "CustomLog"
  }
}
```

Save as `test_logstash.conf` and run:

```bash
/opt/logstash/bin/logstash -f test_logstash.conf
```

---

## 🔗 References

* [Microsoft Sentinel Plugin](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin)
* [Logstash Plugin Dev Guide](https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html)
* [DownGit (Download GitHub folder)](https://minhaskamal.github.io/DownGit/)

---
