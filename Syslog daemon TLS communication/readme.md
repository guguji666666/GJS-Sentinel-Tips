## Security considerations - syslog daemon communication in TLS

Make sure to configure the machine's security according to your organization's security policy. <br>
For example, you can configure your network to align with your corporate network security policy and change the ports and protocols in the daemon to align with your requirements. <br>
You can use the following instructions to improve your machine security configuration:  [Secure VM in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/security-policy), [Best practices for Network security](https://learn.microsoft.com/en-us/azure/security/fundamentals/network-best-practices). <br>
If your devices are sending Syslog and CEF logs over TLS (because, for example, your log forwarder is in the cloud), you will need to configure the Syslog daemon (rsyslog or syslog-ng) to communicate in TLS. See the following documentation for details:
### [Security considerations](https://learn.microsoft.com/en-us/azure/sentinel/connect-log-forwarder?tabs=rsyslog#security-considerations)
### [syslog-ng daemon](https://support.oneidentity.com/technical-documents/syslog-ng-open-source-edition/3.22/administration-guide/60#TOPIC-1209298)
### [Rsyslog daemon](https://www.rsyslog.com/doc/v8-stable/tutorials/tls_cert_scenario.html)
