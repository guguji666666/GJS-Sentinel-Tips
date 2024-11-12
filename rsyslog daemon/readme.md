# Update rsyslog daemon

## Update rsyslog daemon on redhat

## Original version (sample)
![image](https://github.com/user-attachments/assets/8c061c26-caf5-4e24-b1b5-f010935702af)


## List versions available
![image](https://github.com/user-attachments/assets/d49344e4-7f8a-465d-b8be-2d308f38e6a6)


## Update rsyslog daemon

To update the `rsyslog` daemon from version 8.24 to 8.34 on Red Hat Enterprise Linux (RHEL) 7.9, you'll generally follow these steps. However, keep in mind that direct package updates depend on the package being available in the repositories your system is configured to use. As of my last update, RHEL's default repositories may not always contain the very latest versions of software like `rsyslog` due to Red Hat's focus on stability and security. If the specific version you're looking for isn't available in the default or EPEL repositories, you might need to use or configure additional repositories or compile the software from source.

### Step 1: Backup Current Configuration

Before making changes to critical system services like `rsyslog`, it's a good practice to back up your current configuration.

```bash
sudo cp /etc/rsyslog.conf /etc/rsyslog.conf.backup
```


### Step 2: Check Your Current `rsyslog` Version

```bash
rsyslogd -v
```

This step ensures you know your starting version and can verify the upgrade later.

### Step 3: Update Your System

Ensure your package lists and installed packages are up to date. This can also update `rsyslog` if the newer version is available in the repositories.

```bash
sudo yum update
```

### Step 4: Check Available `rsyslog` Versions

Before attempting to upgrade, check which versions of `rsyslog` are available in your configured repositories:

```bash
sudo yum list available --showduplicates rsyslog
```
![image](https://github.com/user-attachments/assets/6a82de9a-695a-4129-97cf-c229d8ca07d9)

### Step 5: Install a Specific Version of `rsyslog`

If you see version 8.34 in the list from the previous command, you can proceed to install it. If it's not available, you'll need to find a repository that contains it or consider compiling from source.

If available, install it using:

```bash
sudo yum install rsyslog-8.34*
```

Replace `8.34*` with the exact version string if necessary.

### If the Version is Not Available in Repositories

#### Option 1: Enable Additional Repositories or Configure a New Repository

You might find a third-party repository that provides the specific version of `rsyslog` you need. After configuring the repository, you can attempt to install the specific version as shown above.

#### Option 2: Compile from Source

1.  **Download the Source Package**
    
    First, you need to download the source package for `rsyslog` version 8.34. You can find it on the [official rsyslog website](https://www.rsyslog.com/) or its [GitHub repository](https://github.com/rsyslog/rsyslog).
    
2.  **Install Development Tools**
    
    ```bash
    sudo yum groupinstall "Development Tools"
    sudo yum install libestr-devel librelp-devel zlib-devel libuuid-devel
    ```
    
3.  **Compile and Install**
    
    Navigate to the directory where you downloaded the `rsyslog` source, then compile and install:
    
    ```bash
    tar xzf rsyslog-8.34.tar.gz
    cd rsyslog-8.34
    ./configure
    make
    sudo make install
    ```
    
4.  **Post-Installation**
    
    After installing, you might need to adjust your system's service scripts, as compiling from source won't automatically configure systemd or init scripts.
    

### Step 6: Verify the Update

After installation, verify the update by checking the version again:

```bash
rsyslogd -v
```

### Note

Direct upgrading to a specific minor version not available in your configured repositories can be challenging and might require additional steps not covered here, such as adding specific repositories or compiling from source. Always ensure you understand the implications of adding third-party repositories or installing software from source, especially concerning system stability and security.
