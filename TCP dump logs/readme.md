# Capture TCP Dump network trace

## 1. Install TCP Dump utility

While most distributions include this utility you may find in some cases that it isn't installed. The following can help with the installation in the following distributions:
* RHEL & CENTOS - yum install tcpdump
* UNBUNTU - apt-get install tcpdump
* SUSE - zypper -n install tcpdump
* DEBIAN - apt-get install tcpdump

## 2. Capture the trace
### 1. In an SSH session, we are going to start the trace with the following command
```sh
sudo tcpdump -w '/tmp/capture.pcap' &
```
<img width="1456" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c2e66044-692b-47cc-88a5-9d34efdbfd75">

Note: Make a note of this process number as it will be required later to stop this process.

### 2. Launch another SSH session
We'll restart the Azure Monitor Agent for Linux to initiate agent activity and re-establish connections to our endpoints following the steps below:

#### a. Commands to stop the AMA agent:
```sh
cd /var/lib/waagent/Microsoft.Azure.Monitor.AzureMonitorLinuxAgent-<agent version number>/
```
```sh
./shim.sh -disable
```
<img width="1232" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/11713997-deb8-4ab2-b826-b3159ca81ac0">

After the scripts finish running you should see the following results of a successful execution <br>
<img width="1929" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c92d3cf8-da81-4ee9-b35a-57a0c25dedd6">

#### b. Commands to start the AMA agent:
```sh
cd /var/lib/waagent/Microsoft.Azure.Monitor.AzureMonitorLinuxAgent-<agent version number>/
```
```sh
./shim.sh -enable
```

After the scripts finish running you should see the following results of a successful execution <br>
<img width="1919" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a0f6ab8b-3733-427d-8c73-2280e91a928b">

## 3. After restarting the agent, it is best to wait 4 to 5 minutes before stopping the trace, however if the agent is noting connection errors in either the mdsd.err or the mdsd.info  log files it's best to wait until we see these errors written so we can validate traffic issues with a specific time the error was written.

To stop the trace you will need the process id you collected in step 1, using that process id you can execute the following command:
```sh
sudo kill "process id"
```
<img width="838" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1ddfc1d3-103d-4ad5-a4dd-3d4f6b893cd5"> <br>

You should see the packet capture stop in the initial SSH session that was running the trace <br>
<img width="1064" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c2daa008-feca-4db4-bcf1-0732d6c6f2a8">

## 4. After trace is stopped, we will need to get a new set of troubleshooting log from the azure monitor agent troubleshooter following the steps in [Capture AMA logs using troubleshooter tool](https://github.com/guguji666666/GJS-Sentinel-Tips/tree/main/AMA%20TSG%20tool), along with the output file from the `/tmp` location for review.

TCP Dump network trace <br>
<img width="1324" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d76616bc-53c5-4a10-a764-47ccacb715b6">

	
## *Important note*
If you do not see any packets captured by the network trace it is likely that you will need to specify the interface for the tcp dump.
In order to find the names of an interface, Run the following command:
```shg
sudo ifconfig -s
```
<img width="750" alt="image" src="https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/31378752-0587-4294-a1ce-5849be787f34"> <br>

It is likely that you will see interface names like eth0, eth1, and lo; (lo is loopback and should be ignored for these instructions). In this example our primary network interface is eth0 so in order to get a trace using tcpdump on an interface named eth0 run this command:
```sh
sudo tcpdump -i eth0 -w '/tmp/capture.pcap' &
```
If this is the case you would need to start the process over and use this command in place of the command in Step 1.
