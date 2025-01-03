# Pcap and Npcap

## Monitor change

### 1. Enable File System Auditing

Step 1: Identify Installation Path
	•	For WinPcap, the default installation path is:
	•	C:\Program Files (x86)\WinPcap\
	•	For Npcap, the default installation path is:
	•	C:\Program Files\Npcap\

Step 2: Enable Auditing on the Directory
	1.	Navigate to the installation directory of PCAP or NPCAP.
	2.	Right-click the directory and select Properties.
	3.	Go to the Security tab and click Advanced.
	4.	Switch to the Auditing tab and click Add.
	5.	In the “Principal” field, enter Everyone (or a specific user/group to monitor).
	6.	Select Successful and Failed checkboxes for permissions like:
	•	Modify
	•	Write
	•	Delete
	7.	Click OK to apply the auditing settings.

Step 3: Review Audit Logs
	1.	Open Event Viewer by pressing Win + R, typing eventvwr, and pressing Enter.
	2.	Navigate to Windows Logs > Security.
	3.	Look for Event ID 4663:
	•	This indicates an access attempt on a file or directory.


### 2. Monitor Registry Changes

Step 1: Locate Relevant Registry Keys
	•	For Npcap, locate:
	•	HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\npf
	•	For WinPcap, locate:
	•	HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinPcap

Step 2: Enable Registry Auditing
	1.	Open the Windows Registry Editor by pressing Win + R, typing regedit, and pressing Enter.
	2.	Navigate to the relevant key.
	3.	Right-click the key and select Permissions.
	4.	Click Advanced, then go to the Auditing tab.
	5.	Click Add:
	•	Enter Everyone (or a specific user/group to monitor).
	•	Enable auditing for:
	•	Set Value
	•	Create Subkey
	•	Delete Subkey
	6.	Save the settings.

Step 3: Review Registry Audit Logs
	1.	Open Event Viewer.
	2.	Navigate to Windows Logs > Security.
	3.	Look for Event ID 4657:
	•	This indicates a modification to a registry key or value.


### 3. Use Real-Time Monitoring Tools

Sysmon (System Monitor)
	1.	Download Sysmon:
	•	Download the Sysinternals Suite from Microsoft’s Sysinternals website.
	2.	Install Sysmon:
	•	Run sysmon -accepteula -i to install Sysmon with a basic configuration.
	3.	Create a Configuration File:
	•	Use a configuration file that includes rules to monitor the specific directories or registry keys for PCAP/NPCAP.
	4.	Example Rule:
 ```xml
<EventFiltering>
    <FileCreateTime onmatch="include">
        <TargetFilename condition="contains">WinPcap</TargetFilename>
        <TargetFilename condition="contains">Npcap</TargetFilename>
    </FileCreateTime>
    <RegistryEvent onmatch="include">
        <TargetObject condition="contains">\Services\npf</TargetObject>
        <TargetObject condition="contains">\Services\WinPcap</TargetObject>
    </RegistryEvent>
</EventFiltering>
```
