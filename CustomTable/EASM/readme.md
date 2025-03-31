# EASM info
## EASM CVE
### 1. [Get Cisa Cves Rest API](https://learn.microsoft.com/en-us/rest/api/defenderforeasm/dataplanepreview/cisa-cves/get-cisa-cves?view=rest-defenderforeasm-dataplanepreview-2024-10-01-preview&tabs=HTTP)
### 2. [Register entra id application](https://learn.microsoft.com/en-us/graph/auth-register-app-v2)
Get `application id` and the `client secret` created <br>
![image](https://github.com/user-attachments/assets/34c7aa0f-19ea-436d-a59a-cbfb74d784a2)

### 3. Test API
#### [Choose authentication method](https://learn.microsoft.com/en-us/rest/api/defenderforeasm/authentication#client-service-principal)

Method
```
GET
```
Endpoint: The endpoint hosting the requested resource. For example 
```
https://{region}.easm.defender.microsoft.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/workspaces/{workspaceName}
```
URL will be <br>
```
endpoint}/cisaCves?api-version=2024-10-01-preview
```

We can find the region and resource id of EASM workspace here <br>
![image](https://github.com/user-attachments/assets/8698fa29-07f2-4d2a-9387-5666fbf9f13c)


### 4. Check API response
Sample
```json
{
    "totalElements": 4,
    "value": [
        {
            "cveID": "CVE-2020-11023",
            "vendorProject": "JQuery",
            "product": "JQuery",
            "vulnerabilityName": "JQuery Cross-Site Scripting (XSS) Vulnerability",
            "shortDescription": "JQuery contains a persistent cross-site scripting (XSS) vulnerability. When passing maliciously formed, untrusted input enclosed in HTML tags, JQuery's DOM manipulators can execute untrusted code in the context of the user's browser.",
            "requiredAction": "Apply mitigations per vendor instructions or discontinue use of the product if mitigations are unavailable.",
            "notes": "https://blog.jquery.com/2020/04/10/jquery-3-5-0-released/ ; https://nvd.nist.gov/vuln/detail/CVE-2020-11023",
            "dateAdded": "2025-01-23T00:00:00Z",
            "dueDate": "2025-02-13T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 119
        },
        {
            "cveID": "CVE-2021-40438",
            "vendorProject": "Apache",
            "product": "Apache",
            "vulnerabilityName": "Apache HTTP Server-Side Request Forgery (SSRF)",
            "shortDescription": "A crafted request uri-path can cause mod_proxy to forward the request to an origin server choosen by the remote user. This issue affects Apache HTTP Server 2.4.48 and earlier.",
            "requiredAction": "Apply updates per vendor instructions.",
            "notes": "",
            "dateAdded": "2021-12-01T00:00:00Z",
            "dueDate": "2021-12-15T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 12
        },
        {
            "cveID": "CVE-2019-11043",
            "vendorProject": "PHP",
            "product": "FastCGI Process Manager (FPM)",
            "vulnerabilityName": "PHP FastCGI Process Manager (FPM) Buffer Overflow Vulnerability",
            "shortDescription": "In some versions of PHP in certain configurations of FPM setup, it is possible to cause FPM module to write past allocated buffers allowing the possibility of remote code execution.",
            "requiredAction": "Apply updates per vendor instructions.",
            "notes": "",
            "dateAdded": "2022-03-25T00:00:00Z",
            "dueDate": "2022-04-15T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 6
        },
        {
            "cveID": "CVE-2019-0211",
            "vendorProject": "Apache",
            "product": "HTTP Server",
            "vulnerabilityName": "Apache HTTP Server Privilege Escalation Vulnerability",
            "shortDescription": "Apache HTTP Server, with MPM event, worker or prefork, code executing in less-privileged child processes or threads (including scripts executed by an in-process scripting interpreter) could execute code with the privileges of the parent process (usually root) by manipulating the scoreboard.",
            "requiredAction": "Apply updates per vendor instructions.",
            "notes": "",
            "dateAdded": "2021-11-03T00:00:00Z",
            "dueDate": "2022-05-03T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 1
        }
    ]
}
```

We need the `value section` part in response
```json
{
    "cveID": "CVE-2020-11023",
    "vendorProject": "JQuery",
    "product": "JQuery",
    "vulnerabilityName": "JQuery Cross-Site Scripting (XSS) Vulnerability",
    "shortDescription": "JQuery contains a persistent cross-site scripting (XSS) vulnerability. When passing maliciously formed, untrusted input enclosed in HTML tags, JQuery's DOM manipulators can execute untrusted code in the context of the user's browser.",
    "requiredAction": "Apply mitigations per vendor instructions or discontinue use of the product if mitigations are unavailable.",
    "notes": "https://blog.jquery.com/2020/04/10/jquery-3-5-0-released/ ; https://nvd.nist.gov/vuln/detail/CVE-2020-11023",
    "dateAdded": "2025-01-23T00:00:00Z",
    "dueDate": "2025-02-13T00:00:00Z",
    "updatedAt": "2025-03-31T00:07:12Z",
    "count": 119
}
```

### 5. Create logic app
#### 1. Choose the plan <br>
![image](https://github.com/user-attachments/assets/6bbf0a66-e5d4-46de-bcdb-a513cba488f6)

#### 2. Add Recurrence <br>
![image](https://github.com/user-attachments/assets/a462fdf9-d87f-45d0-85cf-99dc2cf64bb5)

#### 3. Add action > http <br>
![image](https://github.com/user-attachments/assets/0c3936d2-2b44-4835-8492-47b30335b639)

URL <br>
```
endpoint}/cisaCves?api-version=2024-10-01-preview
```

Input the info below: <br>
* Tenant
* Audience
```
https://easm.defender.microsoft.com
```
* Client ID
* Secret
![image](https://github.com/user-attachments/assets/8cbe9e9c-f0bf-4241-88f3-d9477971aec3)

#### 4. Add action > parse json
![image](https://github.com/user-attachments/assets/f4e2eaeb-1c76-4d79-918a-18310e2ae6c8)

![image](https://github.com/user-attachments/assets/5e360ae0-993e-4db4-8d4e-69776bd7fe2c)

![image](https://github.com/user-attachments/assets/71baaeab-7481-4c26-9d46-593dac035d47)

Use sample json below to generate schema <br>
![image](https://github.com/user-attachments/assets/6a23793e-98af-4f80-ad7c-4b9a8b848327)

```json
{
    "totalElements": 4,
    "value": [
        {
            "cveID": "CVE-2020-11023",
            "vendorProject": "JQuery",
            "product": "JQuery",
            "vulnerabilityName": "JQuery Cross-Site Scripting (XSS) Vulnerability",
            "shortDescription": "JQuery contains a persistent cross-site scripting (XSS) vulnerability. When passing maliciously formed, untrusted input enclosed in HTML tags, JQuery's DOM manipulators can execute untrusted code in the context of the user's browser.",
            "requiredAction": "Apply mitigations per vendor instructions or discontinue use of the product if mitigations are unavailable.",
            "notes": "https://blog.jquery.com/2020/04/10/jquery-3-5-0-released/ ; https://nvd.nist.gov/vuln/detail/CVE-2020-11023",
            "dateAdded": "2025-01-23T00:00:00Z",
            "dueDate": "2025-02-13T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 119
        },
        {
            "cveID": "CVE-2021-40438",
            "vendorProject": "Apache",
            "product": "Apache",
            "vulnerabilityName": "Apache HTTP Server-Side Request Forgery (SSRF)",
            "shortDescription": "A crafted request uri-path can cause mod_proxy to forward the request to an origin server choosen by the remote user. This issue affects Apache HTTP Server 2.4.48 and earlier.",
            "requiredAction": "Apply updates per vendor instructions.",
            "notes": "",
            "dateAdded": "2021-12-01T00:00:00Z",
            "dueDate": "2021-12-15T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 12
        },
        {
            "cveID": "CVE-2019-11043",
            "vendorProject": "PHP",
            "product": "FastCGI Process Manager (FPM)",
            "vulnerabilityName": "PHP FastCGI Process Manager (FPM) Buffer Overflow Vulnerability",
            "shortDescription": "In some versions of PHP in certain configurations of FPM setup, it is possible to cause FPM module to write past allocated buffers allowing the possibility of remote code execution.",
            "requiredAction": "Apply updates per vendor instructions.",
            "notes": "",
            "dateAdded": "2022-03-25T00:00:00Z",
            "dueDate": "2022-04-15T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 6
        },
        {
            "cveID": "CVE-2019-0211",
            "vendorProject": "Apache",
            "product": "HTTP Server",
            "vulnerabilityName": "Apache HTTP Server Privilege Escalation Vulnerability",
            "shortDescription": "Apache HTTP Server, with MPM event, worker or prefork, code executing in less-privileged child processes or threads (including scripts executed by an in-process scripting interpreter) could execute code with the privileges of the parent process (usually root) by manipulating the scoreboard.",
            "requiredAction": "Apply updates per vendor instructions.",
            "notes": "",
            "dateAdded": "2021-11-03T00:00:00Z",
            "dueDate": "2022-05-03T00:00:00Z",
            "updatedAt": "2025-03-31T00:07:12Z",
            "count": 1
        }
    ]
}
```

![image](https://github.com/user-attachments/assets/661c2eda-4490-47fc-9e8c-87f36e02a7d2)


#### 5. Add action > create html table
![image](https://github.com/user-attachments/assets/227badcc-3a03-4a5e-8a6d-945129bf566b)

![image](https://github.com/user-attachments/assets/33c4aaf1-656c-4e94-9743-4fc8c56811bc)

#### 6. Add action > send an email(v2)
* Input the email addressed to receive the mail
* Input the subject of the mail
* In body, add part below
html
```html
<style>
  table {
    width: 100%; /* Make the table width fill the container */
    border-collapse: collapse; /* Merge borders */
    margin: 20px 0; /* Margin at the top and bottom */
    font-size: 1em; /* Font size */
    font-family: Arial, sans-serif; /* Font type */
  }

  th, td {
    border: 1px solid #ddd; /* Border color */
    padding: 12px; /* Inner padding */
    text-align: left; /* Text aligned to the left */
  }

  th {
    background-color: #4CAF50; /* Header background color */
    color: white; /* Header font color */
  }

  tr:nth-child(even) {
    background-color: #f2f2f2; /* Even row background color */
  }

  tr:hover {
    background-color: #ddd; /* Hover effect */
  }
</style>
```

Output of previous step <br>
![image](https://github.com/user-attachments/assets/e1b2ec36-98da-4dfd-aef3-a2e2b6922028)

![image](https://github.com/user-attachments/assets/b1ddf00a-68a0-4bf1-9412-87fd223d9e3f)

#### 7. Test logic app
Sample in my mail <br>
![image](https://github.com/user-attachments/assets/d0a624f6-1478-4702-9a08-1de199f72106)


