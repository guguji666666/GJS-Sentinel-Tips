# Using Microsoft Sentinel with Azure Web Application Firewall

## Reference
* [Using Microsoft Sentinel with Azure Web Application Firewall](https://learn.microsoft.com/en-us/azure/web-application-firewall/waf-sentinel)
* [Using Application Gateway WAF to protect your application](https://learn.microsoft.com/en-us/azure/active-directory/app-proxy/application-proxy-application-gateway-waf)
* [What is Azure Web Application Firewall on Azure Application Gateway?](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/ag-overview)
* [Integrating Azure Web Application Firewall with Azure Sentinel (2020 doc)](https://techcommunity.microsoft.com/t5/azure-network-security-blog/integrating-azure-web-application-firewall-with-azure-sentinel/ba-p/1720306)

### [WAF modes](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/ag-overview#waf-modes)
The Application Gateway WAF can be configured to run in the following two modes: <br>
* Detection mode: Monitors and logs all threat alerts. You turn on logging diagnostics for Application Gateway in the Diagnostics section. You must also make sure that the WAF log is selected and turned on. Web application firewall doesn't block incoming requests when it's operating in Detection mode.
* Prevention mode: Blocks intrusions and attacks that the rules detect. The attacker receives a "403 unauthorized access" exception, and the connection is closed. Prevention mode records such attacks in the WAF logs.

### [WAF log analytics categories](https://learn.microsoft.com/en-us/azure/web-application-firewall/waf-sentinel#waf-log-analytics-categories)
WAF log analytics are broken down into the following categories: <br>
* All WAF actions taken
* Top 40 blocked request URI addresses
* Top 50 event triggers
* Messages over time
* Full message details
* Attack events by messages
* Attack events over time
* Tracking ID filter
* Tracking ID messages
* Top 10 attacking IP addresses
* Attack messages of IP addresses

### WAF connector in Sentinel
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/407afa8b-0117-4781-ae89-50699e59f532)

### Built-in analytics rules related to WAF
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d26abfb7-42f5-487c-8308-6a2da83b4328)

We need to install the solution from Sentinel content hub first to get built-in analytics rule <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/9941f4ad-ba1f-496b-af4d-eaae7d993c4f)

### Customed WAF KQL queries

To monitor Web Application Firewall (WAF) events from the AzureDiagnostics table using Kusto Query Language (KQL) in Azure Monitor or Azure Log Analytics, you can start with the following sample queries. These queries assume that you have already configured Azure Diagnostics for your WAF resources.

1. **View WAF Allowed Traffic:**

   This query helps you view WAF allowed traffic events:

   ```kql
   AzureDiagnostics
   | where ResourceType == "APPLICATIONGATEWAYS" and Category == "ApplicationGatewayFirewallLog"
   | where action_s == "Allowed" 
   | project timestamp_t, clientIP_s, url_s, ruleSetType_s, message_s
   ```

   This query filters logs related to Application Gateway Firewall and displays details like the timestamp, client IP, URL, rule set type, and message for allowed traffic.

2. **View WAF Blocked Traffic:**

   This query helps you view WAF blocked traffic events:

   ```kql
   AzureDiagnostics
   | where ResourceType == "APPLICATIONGATEWAYS" and Category == "ApplicationGatewayFirewallLog"
   | where action_s == "Blocked" 
   | project timestamp_t, clientIP_s, url_s, ruleSetType_s, message_s
   ```

   This query filters logs related to Application Gateway Firewall and displays details like the timestamp, client IP, URL, rule set type, and message for blocked traffic.

3. **View WAF False Positives:**

   To identify potential false positives, you can query for WAF events with specific status codes that might indicate a false positive:

   ```kql
   AzureDiagnostics
   | where ResourceType == "APPLICATIONGATEWAYS" and Category == "ApplicationGatewayFirewallLog"
   | where action_s == "Blocked" 
   | where tostring(status_d) in ("403", "406", "407")
   | project timestamp_t, clientIP_s, url_s, ruleSetType_s, message_s, status_d
   ```

   In this query, we're looking for blocked requests with status codes 403, 406, or 407, which could be potential false positives. You can adjust the status codes as needed.

4. **View WAF Anomalies:**

   To monitor for anomalies in WAF traffic, you can use the following query to detect unusual patterns or spikes:

   ```kql
   AzureDiagnostics
   | where ResourceType == "APPLICATIONGATEWAYS" and Category == "ApplicationGatewayFirewallLog"
   | summarize Count=count() by bin(timestamp_t, 1h)
   | order by Count desc
   ```

   This query counts the number of WAF events per hour and orders them by count in descending order. You can adjust the time interval (`1h`) and add additional aggregation or filtering as needed.

5. **View WAF Top Rules Triggered:**

   To identify the top WAF rules triggered by events, you can use the following query:

   ```kql
   AzureDiagnostics
   | where ResourceType == "APPLICATIONGATEWAYS" and Category == "ApplicationGatewayFirewallLog"
   | summarize Count=count() by ruleId_s
   | top 10 by Count desc
   ```

   This query counts the occurrences of each rule being triggered and lists the top 10 rules with the highest counts. You can adjust the number of rules displayed (`top 10`) as needed.

These sample KQL queries should help you get started with monitoring WAF events in Azure Diagnostics. You can further customize and refine these queries based on your specific requirements and the data available in your Azure Monitor logs.
