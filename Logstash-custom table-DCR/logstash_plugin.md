# logstash sample input plugins
---

### ✅ 1. `stdin` – Manual input from command line

```bash
input {
    stdin { }
}
```

* Useful for typing logs manually into the console to test pipeline behavior.

---

### ✅ 2. `file` – Read from a static local file

```bash
input {
    file {
        path => "/var/log/test.log"
        start_position => "beginning"
        sincedb_path => "/dev/null"
    }
}
```

* Reads logs from a file once (due to `sincedb_path => /dev/null`).

---

### ✅ 3. `tcp` – Receive logs over TCP (good for testing with `nc`)

```bash
input {
    tcp {
        port => 5044
        codec => line
    }
}
```

* Send logs via:

  ```bash
  echo "Test log over TCP" | nc localhost 5044
  ```

---

### ✅ 4. `udp` – Lightweight test for receiving logs over UDP

```bash
input {
    udp {
        port => 5140
        codec => plain
    }
}
```

* Send logs via:

  ```bash
  echo "Test log over UDP" | nc -u localhost 5140
  ```

---

### ✅ 5. `http` – Accept logs via HTTP POST (like a mini webhook)

```bash
input {
    http {
        port => 8080
    }
}
```

* Send test data using:

  ```bash
  curl -XPOST 'http://localhost:8080' -d 'This is a test HTTP log'
  ```

---
