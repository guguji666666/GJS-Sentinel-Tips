# 💡 Azure Monitor Agent (AMA) – Troubleshooting Guide

## 🔄 Restarting the AMA Service on a Windows Machine

Use the following steps to safely restart the **Azure Monitor Agent** service by terminating the host process. This is useful for resolving issues such as stalled data ingestion or agent unresponsiveness.

---

### ✅ Step 1: Log into the Machine

Connect to the Windows machine where **Azure Monitor Agent (AMA)** is installed. Ensure you have **administrative privileges**.

---

### ✅ Step 2: Open Task Manager

Press `Ctrl + Shift + Esc` to launch **Task Manager**.
Navigate to the **Processes** tab and confirm that the following five AMA-related processes are running:

<img width="374" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/aabc1e70-cb7b-4e62-ade5-17d76d59c795">

---

### ✅ Step 3: Terminate `MonAgentHost.exe`

Locate the **`MonAgentHost.exe`** process in the list.
Right-click the process and select **End Task**.

> 🔍 Note: This is the core agent host process. Terminating it will trigger a self-recovery mechanism.

---

### ✅ Step 4: Wait for Auto-Restart

Within **1–2 minutes**, the `MonAgentHost.exe` process will automatically restart.

> ⏱️ If the process does not reappear, check the **Windows Event Viewer** or **Services** console (`services.msc`) to ensure the **Azure Monitor Agent** service is running properly.

---

📘 *Need additional help?* Feel free to check the [official AMA documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-overview) or raise an issue in this repository.

---

