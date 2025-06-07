Sure! Here's the **fully optimized and beautified English version** of your guide to **Get EASM CVE Reporting (Attack Surface Summary)** — with all original image links preserved:

---

# 🛡️ Get EASM CVE Reporting (Attack Surface Summary)

## 📘 1. [API Reference – Reports: Get Summary](https://learn.microsoft.com/en-us/rest/api/defenderforeasm/dataplanepreview/reports/get-summary?view=rest-defenderforeasm-dataplanepreview-2024-10-01-preview&tabs=HTTP)

---

## 🔐 2. Register Entra ID Application

Follow [this guide](https://learn.microsoft.com/en-us/graph/auth-register-app-v2) to register an application and obtain the following:

* `Application (client) ID`
* `Client Secret`

📸 Example UI:
![image](https://github.com/user-attachments/assets/34c7aa0f-19ea-436d-a59a-cbfb74d784a2)

---

## 🧪 3. Test the API

### 🔑 [Choose Authentication Method](https://learn.microsoft.com/en-us/rest/api/defenderforeasm/authentication#client-service-principal)

#### ✅ HTTP Method

```
GET
```

#### 🌐 Endpoint Format

```
https://{region}.easm.defender.microsoft.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/workspaces/{workspaceName}
```

Then append this to the endpoint:

```
/cisaCves?api-version=2024-10-01-preview
```

📸 You can find the EASM region and resource ID in the Azure portal:
![image](https://github.com/user-attachments/assets/8698fa29-07f2-4d2a-9387-5666fbf9f13c)

---

## 📦 Sample Request Body by Severity

### 🔴 High Priority

```json
{
  "metricCategories": ["priority_high_severity"],
  "metrics": null,
  "filters": null,
  "groupBy": null
}
```

### 🟠 Medium Priority

```json
{
  "metricCategories": ["priority_medium_severity"],
  "metrics": null,
  "filters": null,
  "groupBy": null
}
```

### 🟢 Low Priority

```json
{
  "metricCategories": ["priority_low_severity"],
  "metrics": null,
  "filters": null,
  "groupBy": null
}
```

---

## 🔍 4. View API Response

### 📂 Sample Response (High Priority Findings)

```json
sample json inside
```

---

## ⚙️ 5. Automate with Logic App

### 🧭 Step 1: Choose Consumption Plan

![image](https://github.com/user-attachments/assets/6bbf0a66-e5d4-46de-bcdb-a513cba488f6)

---

### 🔁 Step 2: Add `Recurrence` Trigger

![image](https://github.com/user-attachments/assets/a462fdf9-d87f-45d0-85cf-99dc2cf64bb5)

---

### 🌐 Step 3: Add `HTTP` Action

![image](https://github.com/user-attachments/assets/63f297f7-05b4-4a0a-915b-9032423c5fe5)

* **URL**:

```
{endpoint}/cisaCves?api-version=2024-10-01-preview
```

* Fill in:

  * Tenant ID
  * Audience:

    ```
    https://easm.defender.microsoft.com
    ```
  * Client ID
  * Client Secret

📸 Example:
![image](https://github.com/user-attachments/assets/8cbe9e9c-f0bf-4241-88f3-d9477971aec3)

---

### 🧩 Step 4: Add `Parse JSON` Action

Use the high-priority sample response to generate a schema.
![image](https://github.com/user-attachments/assets/f4e2eaeb-1c76-4d79-918a-18310e2ae6c8)
![image](https://github.com/user-attachments/assets/5e360ae0-993e-4db4-8d4e-69776bd7fe2c)
![image](https://github.com/user-attachments/assets/71baaeab-7481-4c26-9d46-593dac035d47)

---

### 🧹 Step 5: (Optional) Add `Filter array` Action

Filter only those items with `count > 0`.

#### `From` Expression

```js
first(body('Parse_JSON_High')?['assetSummaries'])?['children']
```

> Replace `Parse_JSON_High` with your exact step name.

📸
![image](https://github.com/user-attachments/assets/25cb83f3-24f6-480c-b7e0-6982483dcd80)

#### `Filter` Expression

```js
item()?['count']
```

Set condition: **Greater than** `0`
![image](https://github.com/user-attachments/assets/d78d1adb-b623-4319-872d-5ae056aebde1)
![image](https://github.com/user-attachments/assets/f40fb039-4108-4585-a3a8-403b1d3cb686)

---

### 🧾 Step 6: Add `Create HTML Table`

![image](https://github.com/user-attachments/assets/4c8628f6-f052-436c-9fcf-e6f0e04ea91c)

---

### 📧 Step 7: Add `Send an email (V2)`

* Fill in:

  * To: your recipient
  * Subject
  * Body: insert the table output from the previous step

#### Optional HTML Styling

```html
<style>
  table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    font-size: 1em;
    font-family: Arial, sans-serif;
  }

  th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: left;
  }

  th {
    background-color: #4CAF50;
    color: white;
  }

  tr:nth-child(even) {
    background-color: #f2f2f2;
  }

  tr:hover {
    background-color: #ddd;
  }
</style>
```

📸 Preview:
![image](https://github.com/user-attachments/assets/e1b2ec36-98da-4dfd-aef3-a2e2b6922028)
![image](https://github.com/user-attachments/assets/b1ddf00a-68a0-4bf1-9412-87fd223d9e3f)

---

## 🧪 6. Test Your Logic App

Here’s an example output in email:
Only shows `children` with `count > 0`
![image](https://github.com/user-attachments/assets/66feda75-15c1-4141-ac5b-040752edaf89)

---

Would you like this converted into a downloadable `.md` file or a GitHub-ready documentation template?
