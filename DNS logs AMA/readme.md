## [Stream and filter data from Windows DNS servers with the AMA connector](https://learn.microsoft.com/en-us/azure/sentinel/connect-dns-ama)

### Deployment steps
DC would be the master DNS server in the domain by default

[Deploy a secondary DNS server](https://www.youtube.com/watch?v=g9w8apZnbg0) in the domain if you want to test on a separated DNS server

#### Install DNS Server role on the secondary DNS server
![image](https://user-images.githubusercontent.com/96930989/226557476-5987a954-a115-4a59-9b8c-db2b5fa19d56.png)

#### Create DNS zone
![image](https://user-images.githubusercontent.com/96930989/226562899-3b32602c-26b2-4f76-a607-98465c5e8719.png)

![image](https://user-images.githubusercontent.com/96930989/226562946-0f9da621-e4b3-411f-838f-f4ed9a0bd4dd.png)

![image](https://user-images.githubusercontent.com/96930989/226562984-fd84a321-d70a-416a-b02b-ef6e2930c888.png)

Input the same DNS zone name found from your master DNS server (DC in this lab)

![image](https://user-images.githubusercontent.com/96930989/226565253-18c6eb19-feb4-4417-8957-1918a9161115.png)

#### Input the IP of master DNS server (DC in this lab)
![image](https://user-images.githubusercontent.com/96930989/226565294-ac68d8bd-4f51-4904-8cef-c80f4c0e7a07.png)

#### Allow DNS Zone Transfer

Navigate to master DNS server (DC in this lab)
![image](https://user-images.githubusercontent.com/96930989/226565603-e3dcf0e0-ce0a-421e-930b-af5282b6de35.png)

Allow Zone transfers and define the IP of secondary DNS server

![image](https://user-images.githubusercontent.com/96930989/226566541-0fbb044d-8829-48ee-ae37-4bb31630f8c3.png)

Also add the secondary DNS server to the notify list

![image](https://user-images.githubusercontent.com/96930989/226568068-a9e60ad0-b9b4-49de-979e-338019ca2a21.png)

Then refresh on the secondary DNS server

![image](https://user-images.githubusercontent.com/96930989/226568342-1defd0a4-100f-43f8-a8a9-99ff8e41cb7c.png)

We can also modify the refresh interval here on the master DNS server (DC)

![image](https://user-images.githubusercontent.com/96930989/226570742-0ebc10d6-9741-4b3b-a06c-44094f4a1abf.png)


## Lab for reference

1. I built the lab following the flow: Client (domain joined) > Secondary DNS server > DC (Master DNS server)
2. IP table of the machines
* Client machine running win 10 	192.168.50.176
* Secondary DNS server	192.168.50.169
* DC	192.168.50.103

