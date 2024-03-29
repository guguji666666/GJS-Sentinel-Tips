# Purge OMS agent on Linux

## 1. Verify current version of OMS agent installed
Debian based distro (for e.g. Ubuntu) machines
```sh
apt list | grep omsagent
```

Other distributions
```sh
rpm -qa | grep oms
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/86341991-0159-4fea-8d56-1b86f2a4fe1a)

## 2. Purge actions

### 1. Go to portal and uninstall these three extensions (if present) from the Virtual Machine extension blade.
* LinuxDiagnostics
* OMSAgentForLinux

### 2. Remove LAD files from the machine if they exist
#### a.First, check these two locations and remove them if they exist:

```sh
cd /var/lib/waagent/Microsoft.Azure.Diagnostics.LinuxDiagnostic-<version>/
```

```sh
/var/opt/microsoft/omsagent/LAD/
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/ba5943fa-032c-4e4f-bf60-108cc73fbf16)

#### b. If you do not find anything, please run the command below to check for any lad packages

Redhat based distro (RedHat, CentOS, Oracle, Fedora + SUSE*)
```sh
rpm -qa | grep lad
```
```sh
rpm -qa | grep mdsd
```

Debian based distro (Debian, Ubuntu):
```sh
dpkg -l | grep lad
```
```sh
dpkg -l | grep mdsd
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/31096c10-b549-436d-aa4b-f2631f32fff5)

If you see any, then we can `remove` them using the commands

Redhat based distro (RedHat, CentOS, Oracle, Fedora + SUSE*):
```sh
rpm -e package_name
```

##### Remove mdsd

Redhat based distro (RedHat, CentOS, Oracle, Fedora + SUSE*):
```sh
rpm -e | grep mdsd
```

Debian based distro (Debian, Ubuntu)
```
dpkg -r | grep mdsd
```
Then double check if the OMS extension in portal to see if it goes away.


### 3. Run the commands below to get the agent file and purge the agent:
```sh
_wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh_ 
```
```sh
chmod +x ./onboard_agent.sh
```
```sh
sudo ./onboard_agent.sh --purge
```
