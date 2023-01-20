## Forward syslog to workspace with MMA
* [Collect Syslog data sources with the Log Analytics agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/data-sources-syslog)
* [Collect data from Linux-based sources using Syslog](https://learn.microsoft.com/en-us/azure/sentinel/connect-syslog)

## Basic
1. Syslog is an `event logging protocol` that is common to Linux. 
2. You can use the `Syslog daemon` built into Linux devices and appliances to collect local events of the types you specify, and have it send those events to Microsoft Sentinel using the Log Analytics agent for Linux (formerly known as the OMS agent).
3. The table used in workspace is `syslog`
4. Parsing happens in `Sentinel`

## Workflow
1. Data source and log forwarder deployed on the `same` linux server
![image](https://user-images.githubusercontent.com/96930989/213683832-2bb83320-9f2f-44de-a850-f71cb1e9a12c.png)
2. Data source and log forwarder deployed on `different` linux servers
* The Syslog daemon on the forwarder sends events to the Log Analytics agent over `UDP`. 
* If this Linux forwarder is expected to collect a high volume of Syslog events, its Syslog daemon sends events to the agent over `TCP` instead.
![image](https://user-images.githubusercontent.com/96930989/213684013-2cb9aff0-a224-4c54-9d58-b74fd1ec8aa5.png)


## Before deployment
1. While you are setting up your Syslog data connector, make sure to `turn off` your Microsoft Defender for Cloud `auto-provisioning` settings for the `MMA/OMS agent`.
You can turn them back on after your data connector is completely set up. [syslog collector troubleshooter](https://learn.microsoft.com/en-us/azure/sentinel/troubleshooting-cef-syslog?tabs=syslog#verify-your-data-connector-prerequisites)

2. Log Analytics supports collection of messages sent by the `rsyslog` or `syslog-ng` daemons, where `rsyslog` is the `default`. 
3. The default syslog daemon on `version 5` of Red Hat Enterprise Linux (RHEL), CentOS, and Oracle Linux version (sysklog) is `not supported` for syslog event collection. To collect syslog data from this version of these distributions, the `rsyslog` daemon should be installed and configured to replace sysklog.


## Deployment guidance
* Install the OMS agent (MMA) 
* Configure the data logging, configure the parse if required
* Configure OMS agent (MMA) the logs it should collect


