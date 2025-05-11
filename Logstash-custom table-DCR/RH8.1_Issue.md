

🦾 Install Logstash 7.3.2 + JDK 1.8 on AWS EC2 (Red Hat 8.1)

This guide walks you through a clean installation of Logstash 7.3.2 and OpenJDK 1.8 on a Red Hat 8.1 EC2 instance using the official Elastic YUM repo — with full systemd support.

⸻

🧰 Prerequisites
	•	✅ AWS EC2 instance running Red Hat Enterprise Linux 8.1
	•	✅ sudo user access
	•	✅ Internet connectivity

⸻

📦 Step 1: System Update & Install Base Tools

sudo dnf update -y
sudo dnf install -y wget curl unzip vim


⸻

☕ Step 2: Install OpenJDK 1.8

sudo dnf install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

✅ Verify Java installation:

java -version

Example output:

openjdk version "1.8.0_412"
OpenJDK Runtime Environment ...


⸻

🔐 Step 3: Add Elastic YUM Repository

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


⸻

🧹 Step 4: Clean Up Previous Install (If Any)

sudo yum remove -y logstash
sudo rm -rf /etc/logstash /usr/share/logstash /var/log/logstash /etc/systemd/system/logstash.service


⸻

📥 Step 5: Install Logstash 7.3.2 via Yum

sudo yum install -y logstash-7.3.2

✅ Verify Logstash version:

/usr/share/logstash/bin/logstash --version

Expected output:

logstash 7.3.2


⸻

▶️ Step 6: Enable & Start the Logstash Service

sudo systemctl daemon-reload
sudo systemctl enable --now logstash

✅ Check Logstash status:

sudo systemctl status logstash


⸻

🧪 Step 7: Test with a Sample Pipeline (Optional)

Create a simple pipeline config:

sudo tee /etc/logstash/conf.d/test.conf > /dev/null <<EOF
input {
  stdin { }
}
output {
  stdout { codec => rubydebug }
}
EOF

Run Logstash manually to test:

sudo /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/test.conf

Now type something and press Enter — you should see a parsed JSON output.

⸻

✅ Success!

You’ve successfully installed:
	•	🟢 JDK 1.8
	•	🟢 Logstash 7.3.2
	•	🟢 Systemd-supported Logstash service

⸻

📚 Next Steps

Want to build a real pipeline? Try one of the following:
	•	Forward logs to Elasticsearch
	•	Send alerts to Azure Sentinel
	•	Output to local files or syslog
