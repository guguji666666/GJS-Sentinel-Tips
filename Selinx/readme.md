# Selinux blocks traffic to oms agent

Selinux can block the connections to the OMSAgent, if the OS is a distribution from Redhat or CentOS we need to confirm that SELinux is in a permissive state.

To disable permanently the  setting in SELinux to Permissive mode permanently, we need to edit `/etc/selinux/config` Change the SELINUX value to “SELINUX=permissive”

```sh
nano /etc/selinux/config
```
```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of these two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

Save the configuration file and reboot the server

Run the command below to verify the status of Selinux
```sh
sestatus
```
```
SELinux status:                 disabled - Good
SELinux status:                 permissive - Good
SELinux status:                 enforced - bad, need to disable or set to permissive
```
