# Using Microsoft Sentinel with Azure Web Application Firewall

## Reference
* [Using Microsoft Sentinel with Azure Web Application Firewall](https://learn.microsoft.com/en-us/azure/web-application-firewall/waf-sentinel)
* [Using Application Gateway WAF to protect your application](https://learn.microsoft.com/en-us/azure/active-directory/app-proxy/application-proxy-application-gateway-waf)
* [What is Azure Web Application Firewall on Azure Application Gateway?](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/ag-overview)

### [WAF modes](https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/ag-overview#waf-modes)
The Application Gateway WAF can be configured to run in the following two modes: <br>
* Detection mode: Monitors and logs all threat alerts. You turn on logging diagnostics for Application Gateway in the Diagnostics section. You must also make sure that the WAF log is selected and turned on. Web application firewall doesn't block incoming requests when it's operating in Detection mode.
* Prevention mode: Blocks intrusions and attacks that the rules detect. The attacker receives a "403 unauthorized access" exception, and the connection is closed. Prevention mode records such attacks in the WAF logs.
