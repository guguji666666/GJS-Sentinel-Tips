# 🔧 Installing `microsoft-sentinel-log-analytics-logstash-output-plugin` for Logstash

This guide walks through installing the [Microsoft Sentinel Log Analytics Logstash output plugin](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin) using instructions from the [Logstash Plugin documentation](https://www.elastic.co/guide/en/logstash/current/working-with-plugins.html).

---

## ✅ Prerequisites

* A working Logstash installation (`logstash --version`)
* `git`, `java`, and `ruby` installed
* Environment variable `JAVA_HOME` is correctly set
* Logstash is installed in a directory like `/opt/logstash`

---

## 📝 Installation Steps

### 1. Navigate to Logstash Installation Directory

```bash
cd /opt/logstash
```

---

### 2. Clone the Plugin Repository

```bash
git clone https://github.com/Azure/Azure-Sentinel.git
```

---

### 3. Navigate to the Plugin Directory

```bash
cd Azure-Sentinel/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin
```

---

### 4. Install the Plugin (Direct Method)

```bash
/opt/logstash/bin/logstash-plugin install no-verify --local .
```

If this fails, proceed with manual packaging.

---

### 5. \[Alternative] Build the Plugin Gem

```bash
gem build microsoft-sentinel-log-analytics-logstash-output-plugin.gemspec
```

This generates a `.gem` file (e.g., `logstash-output-microsoft-sentinel-log-analytics-0.1.0.gem`).

---

### 6. Install the Plugin from the Gem File

```bash
/opt/logstash/bin/logstash-plugin install logstash-output-microsoft-sentinel-log-analytics-*.gem
```

---

### 7. Verify Installation

```bash
/opt/logstash/bin/logstash-plugin list --verbose | grep sentinel
```

---

## 🔁 Example Output Configuration

```ruby
output {
  microsoft-sentinel-log-analytics-logstash-output-plugin {
    workspace_id => "<Your Workspace ID>"
   shared_key   => "<Your Primary Key>"
    log_type     => "CustomLog"
  }
}
```

---

## 🧩 References

* [Logstash Plugin Dev Guide](https://www.elastic.co/guide/en/logstash/current/workin-with-plugins.html)
* [Azure Sentinel Plugin Source](https://github.com/Azure/Azure-Sentinel/tree/master/DataConnectors/microsoft-sentinel-log-analytics-logstash-output-plugin)

---

