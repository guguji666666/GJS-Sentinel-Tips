# 🚨 Retrieve Analytics Rule Query from Microsoft Sentinel Incident Trigger (Logic App)

## 🛠️ Preparation Steps

1. **Enable System-Assigned Managed Identity** for your Logic App.
2. **Assign `Microsoft Sentinel Contributor` Role** to the Logic App's managed identity.

---

## 🔁 Step 1: Trigger — Microsoft Sentinel Incident

Use the **Microsoft Sentinel incident trigger** as the first step in your Logic App.

![image](https://github.com/user-attachments/assets/7a090e5b-337a-4b36-9948-95c0f3296d37)

---

## 📦 Step 2: Add Action — Parse JSON (Data Operations)

Insert a **Parse JSON** action right after the trigger to extract the incident payload.

![image](https://github.com/user-attachments/assets/710cbf1c-59b3-45be-a2c6-950a28b4ccd6)

* **Content**: Select `body` from the output of the Sentinel incident trigger.

  ![image](https://github.com/user-attachments/assets/9b302155-16d2-4b12-b4c7-5d1a063f3683)

* **Schema**: Use the full JSON schema below to parse the incident object.

<details>
  <summary>Click to expand JSON schema</summary>

```json
[...Your original full schema here...]
```

</details>

---

## 🔄 Step 3: Add Control — `For each`

Add a **For each** loop to iterate over the alerts (if not automatically created).

![image](https://github.com/user-attachments/assets/79618df7-fb89-4f70-9293-431d9a8ca0b8)

---

## 🧮 Step 4: Add Action — Compose (Extract Analytics Rule ID)

Inside the loop, add a **Compose** action to extract the rule ID.

![image](https://github.com/user-attachments/assets/5cb009d0-837a-4b93-9c19-65a8dc974589)

**Input**:

```plaintext
last(split(items('For_each'), '/'))
```

![image](https://github.com/user-attachments/assets/d11c5030-7e4d-487c-846a-1a1ccbb3bda0)

---

## 🌐 Step 5: Add Action — HTTP (Get Analytics Rule)

Configure an HTTP GET action to retrieve the analytics rule.

![image](https://github.com/user-attachments/assets/dca51f7f-0663-4615-921c-568ce74cb1fe)

* **URI** (example from lab):
```plaintext
https://management.azure.com/subscriptions/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['SubscriptionId']}/resourceGroups/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['ResourceGroupName']}/providers/Microsoft.OperationalInsights/workspaces/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['WorkspaceName']}/providers/Microsoft.SecurityInsights/alertRules/@{outputs('Compose_analytics_rule_id')}?api-version=2024-09-01
``` 
> 📌 **Note**: In the sample URI below, replace `Parse_JSON_orgin_XDR` with the **actual name** you assigned to the **Parse JSON** action in **Step 2**.

```plaintext
https://management.azure.com/subscriptions/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['SubscriptionId']}/resourceGroups/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['ResourceGroupName']}/providers/Microsoft.OperationalInsights/workspaces/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['WorkspaceName']}/providers/Microsoft.SecurityInsights/alertRules/@{outputs('Compose_analytics_rule_id')}?api-version=2024-09-01
```

> ✅ Example (if your Parse JSON action is named `Parse_JSON_SentinelIncident`):

```plaintext
@{body('Parse_JSON_SentinelIncident')?['workspaceInfo']?['SubscriptionId']}
```
This ensures your Logic App references the correct dynamic output from the earlier action when building the URI to retrieve the analytics rule definition.


* **Method**: `GET`

* **Authentication**:

  * Type: `Managed Identity`
  * Identity: `System-assigned`
  * Audience: `https://management.azure.com`

Sample configuration:

![image](https://github.com/user-attachments/assets/5cfcea6d-bbce-4bf3-9864-9e9aa27d9e34)

---

## 🧩 Step 6: Add Action — Parse JSON (Analytics Rule Output)

* **Content**: Use the body output from the HTTP step.

![image](https://github.com/user-attachments/assets/6111d1b1-ac79-483e-b014-4029933f2e16)

* **Schema**: Paste the following directly.

```json
[...Your second JSON schema here...]
```

---

## 🧪 Step 7: Test — Use a Sample Incident

You can now test your workflow with a sample incident. At the final output of Step 6, you will get the full details of the analytics rule, including the original **KQL query**.

Sample output:

```json
{
  "id": "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.SecurityInsights/alertRules/xxx",
  "name": "a1d7ba82-a14c-4245-a781-81481901f558",
  "type": "Microsoft.SecurityInsights/alertRules",
  "kind": "Scheduled",
  "properties": {
    "query": "ASimDnsActivityLogs | where TimeGenerated > ago(7d) | ...",
    "queryFrequency": "PT5M",
    "queryPeriod": "PT30M",
    ...
  }
}
```

The `query` field will contain the exact rule logic used to trigger the incident, such as:

```kusto
ASimDnsActivityLogs
| where TimeGenerated > ago(7d)
| where SrcIpAddr == "192.168.50.35"
| where EventSubType == "request"
| where DnsQuery has "microsoft.com"
| extend TopLevelDomain = tostring(split(DnsQuery, ".")[-1])
| ...
| order by TimeGenerated desc
```

> ✅ **Tip**: This lets you extract and reuse the query logic directly in other automations, investigations, or documentation.

---
