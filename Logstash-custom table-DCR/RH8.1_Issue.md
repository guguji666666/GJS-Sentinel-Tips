# 🛠️ Issue with Logstash 7.3.2 + JDK 1.8 on Red Hat 8.1


## 🦾 Install Logstash 7.3.2 + JDK 1.8 on AWS EC2 (Red Hat 8.1)

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


View debug logs
```bash
/usr/share/logstash/bin/logstash --log.level debug -t -f /etc/logstash/conf.d/pipeline.conf
```

![image](https://github.com/user-attachments/assets/14d69029-5d7c-419b-9e47-cf8c6bf8e972)


### 🔍 Validate all configs in pipeline directory

```bash
/usr/share/logstash/bin/logstash -t -f /etc/logstash/conf.d/
```

---

## 🧨 Known Issue Observed During Validation

While validating the Logstash configuration using debug mode, the following issue was encountered:

```bash
[root@ip-172-31-33-79 conf.d]# /usr/share/logstash/bin/logstash --log.level debug -t -f /etc/logstash/conf.d/pipeline.conf | grep -E 'sentinel|java'
Thread.exclusive is deprecated, use Thread::Mutex
WARNING: Could not find logstash.yml which is typically located in $LS_HOME/config or /etc/logstash. You can specify the path using --path.settings. Continuing using the defaults
[DEBUG] 2025-05-11 03:14:41.044 [LogStash::Runner] runner - pipeline.java_execution: true
[DEBUG] 2025-05-11 03:14:43.278 [LogStash::Runner] Reflections - expanded subtype java.lang.Cloneable -> org.jruby.RubyBasicObject
[DEBUG] 2025-05-11 03:14:43.278 [LogStash::Runner] Reflections - expanded subtype java.io.Serializable -> org.jruby.RubyBasicObject
[DEBUG] 2025-05-11 03:14:43.278 [LogStash::Runner] Reflections - expanded subtype java.lang.Comparable -> org.jruby.RubyBasicObject
[DEBUG] 2025-05-11 03:14:43.286 [LogStash::Runner] Reflections - expanded subtype java.security.SecureClassLoader -> java.net.URLClassLoader
[DEBUG] 2025-05-11 03:14:43.286 [LogStash::Runner] Reflections - expanded subtype java.lang.ClassLoader -> java.security.SecureClassLoader
[DEBUG] 2025-05-11 03:14:43.286 [LogStash::Runner] Reflections - expanded subtype java.io.Closeable -> java.net.URLClassLoader
[DEBUG] 2025-05-11 03:14:43.286 [LogStash::Runner] Reflections - expanded subtype java.lang.AutoCloseable -> java.io.Closeable
[DEBUG] 2025-05-11 03:14:43.286 [LogStash::Runner] Reflections - expanded subtype java.lang.Comparable -> java.lang.Enum
[DEBUG] 2025-05-11 03:14:43.287 [LogStash::Runner] Reflections - expanded subtype java.io.Serializable -> java.lang.Enum
[FATAL] 2025-05-11 03:14:44.071 [LogStash::Runner] runner - The given configuration is invalid. Reason: undefined local variable or method `sentinel' for #<LogStash::BasePipeline:0x40e0213c>
[ERROR] 2025-05-11 03:14:44.090 [LogStash::Runner] Logstash - java.lang.IllegalStateException: Logstash stopped processing because of an error: (SystemExit) exit
```

📌 **Root Cause Suspected**:

- Missing `logstash.yml` file
- Possibly incompatible JRuby behavior
- Exit triggered by `SystemExit` error

📎 **Recommended Troubleshooting**:

- Ensure `/etc/logstash/logstash.yml` or a custom `--path.settings` is defined
- Confirm JDK 1.8 compatibility and dependencies
- Test with a minimal pipeline config to isolate the issue

You have successfully installed:

- 🟢 **OpenJDK 1.8**
- 🟢 **Logstash 7.3.2**
- 🟢 **Systemd-based Logstash service**
- 


---


## ⚙️ Optional: Install Logstash 7.10.0 (with bundled JDK)

If you prefer to install **Logstash 7.10.0**, note that this version **includes a bundled JDK**, so there's **no need to install OpenJDK manually**.

> ✅ Starting from version 7.9.0, Logstash comes with a built-in JDK.

### OS info

![image](https://github.com/user-attachments/assets/26b4ca8c-8ded-4aa7-af72-f10f3d62bdb5)


### 📥 Install Logstash 7.10.0

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

# Install logstash 7.10.0
sudo yum install -y logstash-7.10.0
```
![image](https://github.com/user-attachments/assets/8e5ae4e6-0b2a-4bce-a000-27cc7df4d903)

### ✅ Verify Logstash and bundled Java version

```bash
/usr/share/logstash/bin/logstash --version
/usr/share/logstash/jdk/bin/java -version
```

Example output: （Indicate bundled JDK installed, standlone JDK not installed indeed)

![image](https://github.com/user-attachments/assets/0d6dfefa-f7fa-4954-b4fd-e4f3e28ea1a0)


### ▶️ Start and enable the Logstash service

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now logstash
```
![image](https://github.com/user-attachments/assets/5adc0af7-7c0d-4a1c-9d40-f2c7a7c865c4)

---

## 📚 Reference: Bundled JDK in Logstash

Elastic added bundled JDK support starting in version **7.9.0** and continued in all 7.x versions including **7.10.0**, **7.13.0**, and **7.14.0**. Here are links to the official release notes confirming this:

* 🔗 [Logstash 7.10.0 Release Notes](https://www.elastic.co/guide/en/logstash/7.14/logstash-7-10-0.html)

  > *"Logstash now uses the bundled JDK by default..."*

* 🔗 [Logstash 7.13.0 Release Notes](https://www.elastic.co/guide/en/logstash/7.14/logstash-7-13-0.html)

  > *"The bundled Java is used by default unless another JAVA\_HOME is explicitly set."*

* 🔗 [Logstash 7.14.0 Release Notes](https://www.elastic.co/guide/en/logstash/7.14/logstash-7-14-0.html)

  > *"Bundled Java continues to be the default runtime environment."*

✅ This confirms that you **do not need to manually install Java** when using Logstash 7.10.0 or later.

---

