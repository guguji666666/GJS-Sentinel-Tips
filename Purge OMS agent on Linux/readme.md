## Purge OMS agent on Linux

### 1. Verify current version of OMS agent installed
Debian based distro (for e.g. Ubuntu) machines
```sh
apt list | grep omsagent
```

Other distributions
```sh
rpm -qa | grep oms
```
