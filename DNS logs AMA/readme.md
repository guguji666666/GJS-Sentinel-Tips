## [Stream and filter data from Windows DNS servers with the AMA connector](https://learn.microsoft.com/en-us/azure/sentinel/connect-dns-ama)

### Deployment steps
DC would be the master DNS server in the domain by default

1. [Deploy a secondary DNS server](https://www.youtube.com/watch?v=g9w8apZnbg0) in the domain if you want to test on a separated DNS server

#### Install DNS Server role on the secondary DNS server
![image](https://user-images.githubusercontent.com/96930989/226557476-5987a954-a115-4a59-9b8c-db2b5fa19d56.png)

#### Create DNS zone
![image](https://user-images.githubusercontent.com/96930989/226562899-3b32602c-26b2-4f76-a607-98465c5e8719.png)

![image](https://user-images.githubusercontent.com/96930989/226562946-0f9da621-e4b3-411f-838f-f4ed9a0bd4dd.png)

![image](https://user-images.githubusercontent.com/96930989/226562984-fd84a321-d70a-416a-b02b-ef6e2930c888.png)

##### Input the same DNS zone name found from your DC
![image](https://user-images.githubusercontent.com/96930989/226563690-e5d65d0c-3aa4-49a8-aab7-6a5777a2424d.png)
