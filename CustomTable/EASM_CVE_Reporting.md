# Get EASM CVE Reporting (Attack surface summary)
## 1. [Reports - Get Summary](https://learn.microsoft.com/en-us/rest/api/defenderforeasm/dataplanepreview/reports/get-summary?view=rest-defenderforeasm-dataplanepreview-2024-10-01-preview&tabs=HTTP)
## 2. [Register entra id application](https://learn.microsoft.com/en-us/graph/auth-register-app-v2)
Get `application id` and the `client secret` created <br>
![image](https://github.com/user-attachments/assets/34c7aa0f-19ea-436d-a59a-cbfb74d784a2)

## 3. Test API
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
{endpoint}/cisaCves?api-version=2024-10-01-preview
```

We can find the region and resource id of EASM workspace here <br>
![image](https://github.com/user-attachments/assets/8698fa29-07f2-4d2a-9387-5666fbf9f13c)

Request body
```json
// High priority
{
    "metricCategories": [
        "priority_high_severity"
    ],
    "metrics": null,
    "filters": null,
    "groupBy": null
}




// Medium priority
{
    "metricCategories": [
        "priority_medium_severity"
    ],
    "metrics": null,
    "filters": null,
    "groupBy": null
}




// Low priority
{
    "metricCategories": [
        "priority_low_severity"
    ],
    "metrics": null,
    "filters": null,
    "groupBy": null
}
```


## 4. Check API response
### Sample with High Priority findings
```json
{
    "assetSummaries": [
        {
            "displayName": "High Severity",
            "description": "Attack Surface: High Severity",
            "createdAt": null,
            "updatedAt": "2025-04-02T02:40:22Z",
            "metricCategory": "priority_high_severity",
            "metric": null,
            "filter": null,
            "labelName": null,
            "count": 14,
            "link": null,
            "children": [
                {
                    "displayName": "Multiple Apache HTTPD Vulnerabilities July 2024",
                    "description": "##### Description\nApache httpd server before 2.4.60 was found to contain multiple vulnerabilities that allow server side request forgery, authentication bypasses, mod_rewrite bypasses, reading files from outside of intended file paths, presenting server side code as text files, and in some cases allowing remote code execution. This work has been presented at Black Hat USA 2024 with a detailed technical writeup available. \n\nCVE-2024-38472 — Apache HTTP Server on Windows UNC SSRF\nCVE-2024-38473 — Apache HTTP Server proxy encoding problem\nCVE-2024-38474 — Apache HTTP Server weakness with encoded question marks in back references\nCVE-2024-38475 — Apache HTTP Server weakness in mod_rewrite when first segment of substitution matches filesystem path\nCVE-2024-38476 — Apache HTTP Server may use exploitable/malicious back-end application output to run local handlers via internal redirect\nCVE-2024-38477 — Apache HTTP Server: Crash resulting in denial of service in mod_proxy via a malicious request\nCVE-2023-38709 — Apache HTTP Server: HTTP response splitting (fixed in 2.4.59)\nCVE-2024-39573 — Apache HTTP Server: mod_rewrite proxy handler substitution\n\nIt is worth noting that some Linux distributions, such as Red Hat, CentOS, Debian, and Ubuntu may leverage back-ported security fixes in their software. Additionally it is possible to obtain extended support for security patches after the Linux distribution is out of its main support phase. Because of this *our Insight may fire* on a system with an Apache server that is out of mainstream support, but could be patched using another method. **Administrators should ensure their systems are running the latest version or back-ported version via a direct authenticated session on the affected system.** \n\n##### Related Intelligence\n- CVE: [CVE-2024-38472](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38472/)\n- CVE: [CVE-2024-38473](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38473/)\n- CVE: [CVE-2024-38474](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38474/)\n- CVE: [CVE-2024-38475](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38475/)\n- CVE: [CVE-2024-38476](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38476/)\n- CVE: [CVE-2024-38477](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38477/)\n- CVE: [CVE-2024-38709](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38709/)\n- CVE: [CVE-2024-39573](https://security.microsoft.com/intel-explorer/cves/CVE-2024-39573/)\n- Security Advisory: [Apache.org - Fixed in Apache HTTP Server 2.4.60](https://httpd.apache.org/security/vulnerabilities_24.html)\n- Vulnerability Writeup: [Orange Tsai](https://blog.orange.tw/posts/2024-08-confusion-attacks-en/#%F0%9F%94%A5-4-Other-Vulnerabilities)\n- Black Hat Slides: [Confusion Attacks in Apache HTTP Server](https://i.blackhat.com/BH-US-24/Presentations/US24-Orange-Confusion-Attacks-Exploiting-Hidden-Semantic-Thursday.pdf)\n\n##### Remediation\nFor Linux systems upgrade Apache HTTPD using your system's default package manager (such as apt, yum, dnf, etc). For all others, follow the vendor's [upgrade instructions](https://httpd.apache.org/docs/2.4/install.html#upgrading) that matches your use case.",
                    "createdAt": "2024-09-04T10:14:43Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60375",
                    "filter": null,
                    "labelName": null,
                    "count": 12,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "WordPress Core Multiple CVEs for SQLi and Stored XSS",
                    "description": "##### Description\n\nThis impacts all versions of WordPress major release branches from 3.7 to 5.8 and consists of the following CVEs:\n-   CVE-2022-21664: SQL injection due to improper sanitization in WP_Meta_Query  \n    Due to lack of proper sanitization in WP_Meta_Query, there’s potential for blind SQL Injection\n-   CVE-2022-21661: SQL Injection through WP_Query  \n    Due to improper sanitization in WP_Query, there can be cases where SQL injection is possible through plugins or themes that use it in a certain way.\n-   CVE-2022-21663: Authenticated Object Injection in Multisites  \n    On a multisite, users with Super Admin role can bypass explicit/additional hardening under certain conditions through object injection.\n-   CVE-2022-21662: Stored XSS through authenticated users  \n    Low-privileged authenticated users (like author) in WordPress core are able to execute JavaScript/perform stored XSS attack, which can affect high-privileged users.\n\n##### Related Intelligence\nCVE: [CVE-2022-21661](https://nvd.nist.gov/vuln/detail/CVE-2022-21661)\nCVE: [CVE-2022-21662](https://nvd.nist.gov/vuln/detail/CVE-2022-21662)\nCVE: [CVE-2022-21663](https://nvd.nist.gov/vuln/detail/CVE-2022-21663)\nCVE: [CVE-2022-21664](https://nvd.nist.gov/vuln/detail/CVE-2022-21664)\nSecurity Advisory: [WordPress.org](https://wordpress.org/news/2022/01/wordpress-5-8-3-security-release/)\nPoC: [Exploit-DB](https://www.exploit-db.com/exploits/50663)\nWriteup: [Zero Day Initiative](https://www.zerodayinitiative.com/blog/2022/1/18/cve-2021-21661-exposing-database-info-via-wordpress-sql-injection)\nWriteup: [Medium article - written in Vietnamese](https://cognn.medium.com/sql-injection-in-wordpress-core-zdi-can-15541-a451c492897)\n\n##### Remediation\n\nUpdate to the latest minor release of your WordPress instance by logging in to the admin dashboard and clicking Update WordPress under the Updates screen. See [this page](https://wordpress.org/support/article/updating-wordpress/) if you run into issues. The makers of WordPress also strongly recommend enabling auto-update by following [these instructions.](https://wordpress.org/support/article/configuring-automatic-background-updates/)\n\nThe [WordPress_Versions](https://codex.wordpress.org/WordPress_Versions) page is a great resource to find the latest minor version for specific release branches.  Ensure the version you are running has a release date of January 6, 2022 or greater. ",
                    "createdAt": "2022-01-25T06:43:25Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_51126",
                    "filter": null,
                    "labelName": null,
                    "count": 1,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-28032 - Deserialization Vulnerability in WordPress",
                    "description": "##### Description \nWordPress CMS before version 5.5.2 mishandles deserialization requests in wp-includes/Requests/Utility/FilteredIterator.php. An unauthenticated remote attacker can exploit this vulnerability to execute arbitrary code on the target host by sending specially crafted serialized payloads to an affected instance.\n\n##### Related Intelligence\nCVE: [CVE-2020-28032](https://nvd.nist.gov/vuln/detail/CVE-2020-28032)\nSecurity Advisory: [WordPress](https://wordpress.org/news/2020/10/wordpress-5-5-2-security-and-maintenance-release/)\n\n##### Remediation\nThis vulnerability has been patched in the 5.5.2 WordPress release. WordPress advises that all WordPress users update to the latest version as soon as possible. ",
                    "createdAt": "2021-06-08T04:52:08Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_39726",
                    "filter": null,
                    "labelName": null,
                    "count": 1,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Weblizar School Management Pro Backdoor PHP Access",
                    "description": "##### Description\nVersions before 9.9.7 of the WordPress plugin “The School Management Pro” from [Weblizar](https://weblizar.com/plugins/school-management/) contain a backdoor injected into the license-checking code allowing an unauthenticated attacker to execute arbitrary PHP code on sites with the plugin installed. Arguments to the backdoor can be passed in from a malicious request to execute arbitrary commands. \n\nThe [free version](https://wordpress.org/plugins/school-management-system/) from the WordPress.org plugin repository does not contain the licensing code, and is also not affected by this backdoor.\n\nJetpack observed versions at least from 8.9 that contained the backdoor.  Since there isn't  any clear information about when the backdoor appeared it's assumed any version before 9.9.7 is affected.\n\n##### Related Intelligence\nCVE: [CVE-2022-1609](https://nvd.nist.gov/vuln/detail/CVE-2022-1609)\nSecurity Advisory and PoC: [Jetpack](https://jetpack.com/blog/backdoor-found-in-the-school-management-pro-plugin-for-wordpress/#more-165795)\n\n##### Remediation\nUpdate the plugin to 9.9.7 or higher by logging into the admin panel of your WordPress instance, finding the School Management Pro plugin info, and clicking the update button for it. ",
                    "createdAt": "2022-07-21T03:23:29Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56127",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-36804 - BitBucket Server and Data Center Command Injection",
                    "description": "##### Description\nThere is a command injection vulnerability in multiple API endpoints of Bitbucket Server and Data Center. An attacker with access to a public Bitbucket repository or with **read** permissions to a private one can execute arbitrary code by sending a malicious HTTP request.\n\nAll versions released after 6.10.17 including 7.0.0 and newer are affected, this means that all instances that are running any versions between 7.0.0 and 8.3.0 inclusive can be exploited by this vulnerability.\n\nBitbucket Mesh:\nIf you have configured Bitbucket Mesh nodes, these will need to be updated with to the corresponding version of Mesh that includes the fix. To find the version of Mesh compatible with the Bitbucket Data Center version, please check the [compatibility matrix](https://confluence.atlassian.com/display/BitbucketServer/Bitbucket+Mesh+compatibility+matrix). You can download the corresponding version from the [download centre](https://www.atlassian.com/software/bitbucket/download-mesh-archives).\n\n##### Related Intelligence\nCVE: [CVE-2022-36804](https://nvd.nist.gov/vuln/detail/CVE-2022-36804)\nSecurity Advisory: [Atlassian](https://confluence.atlassian.com/bitbucketserver/bitbucket-server-and-data-center-advisory-2022-08-24-1155489835.html)\nBug Tracker: [Jira](https://jira.atlassian.com/browse/BSERV-13438)\nVulnerability Writeup: [Rapid7](https://attackerkb.com/topics/iJIxJ6JUow/cve-2022-36804/rapid7-analysis)\nVulnerability Analysis: [Snow Winter Lab](https://www.anquanke.com/post/id/280193)\nPoC: [Metasploit](https://github.com/rapid7/metasploit-framework/pull/17042)\n\n##### Remediation\nFollow the vendor's [upgrade guide](https://confluence.atlassian.com/bitbucketserver/bitbucket-server-upgrade-guide-776640551.html) to apply the appropriate patch for your supported version from the table listed below. \n\nFixed Versions:\n- 7.6.17 ([LTS](https://confluence.atlassian.com/enterprise/long-term-support-releases-948227420.html)) or newer\n- 7.17.10 ([LTS](https://confluence.atlassian.com/enterprise/long-term-support-releases-948227420.html)) or newer\n- 7.21.4 ([LTS](https://confluence.atlassian.com/enterprise/long-term-support-releases-948227420.html)) or newer\n- 8.0.3 or newer\n- 8.1.3 or newer\n- 8.2.2 or newer\n- 8.3.1 or newer\n\n*Mitigation*\nIf you’re unable to upgrade Bitbucket, [a temporary mitigation step is to turn off public repositories globally](https://confluence.atlassian.com/bitbucketserver/allowing-public-access-to-code-776639799.html#Allowingpublicaccesstocode-Disablingpublicaccessglobally) by setting **_feature.public.access=false_** as this will change this attack vector from an unauthorized attack to an authorized attack. This can not be considered a complete mitigation as an attacker with a user account could still succeed.",
                    "createdAt": "2022-09-21T09:08:05Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57255",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-2825 - GitLab Unauthenticated Path Traversal",
                    "description": "##### Description\nAn issue has been discovered in GitLab CE/EE affecting only version 16.0.0. An unauthenticated malicious user can use a path traversal vulnerability to read arbitrary files on the server when an attachment exists in a public project nested within at least five groups.  To address this vulnerability users must upgrade to version 16.0.1 or higher. GitLab thanks [pwnie](https://hackerone.com/pwnie) for reporting this vulnerability through the HackerOne bug bounty program. \n\n*Potentially Vulnerable*\nOur GitLab version detection is able to find the major and minor version of GitLab, but not the security patch level.  GitLab uses a versioning format of 16.0.x, with x being the security patch level. Only version 16.0.0 is vulnerable, and only if there are projects with at least five nested groups. Please check your GitLab instance to see if it is running 16.0.1 or higher.\n\n##### Related Intelligence\n- CVE: [CVE-2023-2825](https://nvd.nist.gov/vuln/detail/CVE-2023-2825)\n- Security Advisory: [GitLab](https://about.gitlab.com/releases/2023/05/23/critical-security-release-gitlab-16-0-1-released/)\n- PoC: [GitHub](https://github.com/Occamsec/CVE-2023-2825)\n\n##### Remediation\nFollow [GitLab's directions](https://about.gitlab.com/update/) for upgrading to version 16.0.1 or higher based on your deployment method. ",
                    "createdAt": "2023-06-19T03:51:32Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59423",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-15588 Zoho ManageEngine Desktop Central Integer Overflow Vulnerability",
                    "description": "An issue was discovered in the client side of Zoho ManageEngine Desktop Central 10.0.552.W. An attacker-controlled server can trigger an integer overflow in InternetSendRequestEx and InternetSendRequestByBitrate that leads to a heap-based buffer overflow and Remote Code Execution with SYSTEM privileges. This issue will occur only when untrusted communication is initiated with server. In cloud, Agent will always connect with trusted communication.",
                    "createdAt": "2021-06-17T05:50:40Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_40016",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-41773, CVE-2021-42013 - Apache HTTP Server Path Traversal",
                    "description": "##### Description\n\nA flaw was found in a change made to path normalization in Apache HTTP Server 2.4.49. An attacker could use a path traversal attack to map URLs to files outside the expected document root. If files outside of the document root are not protected by \"require all denied\" these requests can succeed. Additionally this flaw could leak the source of interpreted files like CGI scripts. This issue is known to be exploited in the wild. This issue reportedly only affects Apache 2.4.49 and not earlier versions. \n\nIn order to be vulnerable, administrators or vendors would require the use of \"Require all granted\" on a directory. For example, the following configuration would introduce the path traversal vulnerability on Apache 2.4.49:\n\n```\n<Directory />\n    AllowOverride none\n    Require all granted\n</Directory>\n``` \n\nIt is worth noting that some Linux distributions, such as Red Hat or CentOS, may leverage backported software. In the future this could lead to instances of 2.4.49 no longer being vulnerable. Administrators should ensure their systems are running the latest version or backported version via a direct authenticated session on the affected system. \n\nUpdate October 8, 2021: The Apache security advisory has been updated indicating that Apache HTTP server 2.4.50, tracked as CVE-2021-42013, contained an incomplete patch for CVE-2021-41773 and that users are encouraged to update to Apache 2.4.51.\n\n##### Related Intelligence\n\nRiskIQ Vulnerability Intelligence: [CVE-2021-41773](https://nvd.nist.gov/vuln/detail/CVE-2021-41773), [CVE-2021-42013](https://nvd.nist.gov/vuln/detail/CVE-2021-42013) \nSecurity Advisory: [Apache HTTP Server Update Notes](https://httpd.apache.org/security/vulnerabilities_24.html)\nRapid7 Vulnerability Analysis: [CVE-2021-41773](https://attackerkb.com/topics/1RltOPCYqE/cve-2021-41773/rapid7-analysis)\n\n##### Remediation\n\nAll systems running Apache 2.4.49 or Apache 2.4.50 should immediately be upgraded to version 2.4.51. If Apache HTTP cannot be updated immediately, Rapid7 has noted that a temporary workaround is to implement a filesystem directory directive with require all denied:\n\n```\n<Directory />\n    Require all denied\n</Directory>\n```\n",
                    "createdAt": "2021-10-05T07:59:48Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_43615",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-11667 - Zyxel Firewall Directory Traversal Vulnerability",
                    "description": "##### Description​\nRecently disclosed vulnerabilities in Zyxel firewall firmware are actively exploited. Firewall models with remote management or SSL VPN enabled (firmware versions below) are vulnerable to crafted URL attacks, allowing unauthorized file access and potential backdoor VPN connections.\n\nThe following Zyxel products are vulnerable if they are running firmware versions from 5.00 up to and including 5.38:\n- ATP series\n- USG FLEX series\n- USG20(W)-VPN series\n\nUpgrading to V5.39+ mitigates this vulnerability and a separate vulnerability, CVE-2024-42057. \n\nCVE-2024-42057 affects firewalls configured for User-Based-PSK authentication mode. If a valid user account exists with a username exceeding 28 characters, an unauthenticated attacker can exploit a command injection flaw in the IPSec VPN feature to execute OS commands on the device.\n\nThreat intelligence firm Sekoia has reported that ransomware operators are leveraging these vulnerabilities to gain initial access to compromised environments.\n\n##### Related Intelligence​\n- CVE: [CVE-2024-11667](https://security.microsoft.com/intel-explorer/cves/CVE-2024-11667/)\n- CVE: [CVE-2024-42057](https://security.microsoft.com/intel-explorer/cves/CVE-2024-42057/)\n- Security Advisory CVE-2024-11667: [Zyxel](https://www.zyxel.com/global/en/support/security-advisories/zyxel-security-advisory-protecting-against-recent-firewall-threats-11-27-2024)​\n- Security Advisory CVE-2024-42057: [Zyxel](https://www.zyxel.com/global/en/support/security-advisories/zyxel-security-advisory-for-multiple-vulnerabilities-in-firewalls-09-03-2024) \n- Vulnerability Writeup, IoC CVE-2024-11667: [Sekoia Blog](https://blog.sekoia.io/helldown-ransomware-an-overview-of-this-emerging-threat/)​\n\n##### Remediation​\nFollow [Zyxel's documentation guidance on how to apply a new version patch, in this case, V5.3.9 or higher to address the noted vulnerabilities.](https://mysupport.zyxel.com/hc/en-us/articles/360008504319--ZyWALL-USG-Firmware-Upgrade-Procedure)\n\nAdditionally, for [optional hardening, reference Zyxel's documentation on best practices to secure a distributed network infrastructure.](https://community.zyxel.com/en/discussion/10920/best-practices-to-secure-a-distributed-network-infrastructure/p1?new=1) \n\nIn the event that a version upgrade is not feasible, it is recommended to disable remote access to your device until the firmware is patched. Additional guidance advises change admin passwords in conjunction with performing the upgrade to V5.3.9 or later.",
                    "createdAt": "2025-02-26T08:53:36Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250560100",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Exim 21Nails Multiple Vulnerabilities",
                    "description": "##### Description\nThe Qualys Research Team discovered multiple critical vulnerabilities in the Exim mail server, some of the which can be chained together to obtain full remote unauthenticated code execution and gain root privileges. Successful exploitation of these vulnerabilities would allow a remote attacker to gain full root privileges on the target server and execute commands to install programs, modify data, and create new accounts. 21 CVEs have been issued and collectively Qualys has dubbed them 21Nails. \n\n**Local vulnerabilities**\n- [CVE-2020-28007](https://nvd.nist.gov/vuln/detail/CVE-2020-28007): Link attack in Exim's log directory\n- [CVE-2020-28008](https://nvd.nist.gov/vuln/detail/CVE-2020-28008): Assorted attacks in Exim's spool directory\n- [CVE-2020-28014](https://nvd.nist.gov/vuln/detail/CVE-2020-28014): Arbitrary file creation and clobbering\n- [CVE-2021-27216](https://nvd.nist.gov/vuln/detail/CVE-2021-27216): Arbitrary file deletion\n- [CVE-2020-28011](https://nvd.nist.gov/vuln/detail/CVE-2020-28011): Heap buffer overflow in queue_run()\n- [CVE-2020-28010](https://nvd.nist.gov/vuln/detail/CVE-2020-28010): Heap out-of-bounds write in main()\n- [CVE-2020-28013](https://nvd.nist.gov/vuln/detail/CVE-2020-28013): Heap buffer overflow in parse_fix_phrase()\n- [CVE-2020-28016](https://nvd.nist.gov/vuln/detail/CVE-2020-28016): Heap out-of-bounds write in parse_fix_phrase()\n- [CVE-2020-28015](https://nvd.nist.gov/vuln/detail/CVE-2020-28015): New-line injection into spool header file (local)\n- [CVE-2020-28012](https://nvd.nist.gov/vuln/detail/CVE-2020-28012): Missing close-on-exec flag for privileged pipe\n- [CVE-2020-28009](https://nvd.nist.gov/vuln/detail/CVE-2020-28009): Integer overflow in get_stdinput()\n**Remote vulnerabilities**\n- [CVE-2020-28017](https://nvd.nist.gov/vuln/detail/CVE-2020-28017): Integer overflow in receive_add_recipient()\n- [CVE-2020-28020](https://nvd.nist.gov/vuln/detail/CVE-2020-28020): Integer overflow in receive_msg()\n- [CVE-2020-28023](https://nvd.nist.gov/vuln/detail/CVE-2020-28023): Out-of-bounds read in smtp_setup_msg()\n- [CVE-2020-28021](https://nvd.nist.gov/vuln/detail/CVE-2020-28021): New-line injection into spool header file (remote)\n- [CVE-2020-28022](https://nvd.nist.gov/vuln/detail/CVE-2020-28022): Heap out-of-bounds read and write in extract_option()\n- [CVE-2020-28026](https://nvd.nist.gov/vuln/detail/CVE-2020-28026): Line truncation and injection in spool_read_header()\n- [CVE-2020-28019](https://nvd.nist.gov/vuln/detail/CVE-2020-28019): Failure to reset function pointer after BDAT error\n- [CVE-2020-28024](https://nvd.nist.gov/vuln/detail/CVE-2020-28024): Heap buffer underflow in smtp_ungetc()\n- [CVE-2020-28018](https://nvd.nist.gov/vuln/detail/CVE-2020-28018): Use-after-free in tls-openssl.c\n- [CVE-2020-28025](https://nvd.nist.gov/vuln/detail/CVE-2020-28025): Heap out-of-bounds read in pdkim_finish_bodyhash()\n\n##### Related Intelligence\n- Security Advisory: [Exim.org](https://www.exim.org/static/doc/security/CVE-2020-qualys/CVE-2020-28026-FGETS.txt)\n- Initial Disclosure: [Qualys](https://blog.qualys.com/vulnerabilities-threat-research/2021/05/04/21nails-multiple-vulnerabilities-in-exim-mail-server)\n\n##### Remediation\nUpdate Exim to version 4.94.2 or higher by using the package manager included with your OS.",
                    "createdAt": "2023-01-11T08:16:16Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58347",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-26084 - Atlassian Confluence Server Webwork OGNL Injection",
                    "description": "##### Description\n\nAn OGNL injection vulnerability exists that would allow an authenticated user, and in some instances unauthenticated user, to execute arbitrary code on a Confluence Server or Data Center instance. \n\n##### Related Intelligence\n\nCVE: [CVE-2021-26084](https://nvd.nist.gov/vuln/detail/CVE-2021-26084) \nSecurity Advisory: [Confluence Advisory](https://confluence.atlassian.com/doc/confluence-security-advisory-2021-08-25-1077906215.html)\nBugTracker: [Atlassian Ticket](https://jira.atlassian.com/browse/CONFSERVER-67940)\nDetailed Writeup: [HttpVoid](https://github.com/httpvoid/writeups/blob/main/Confluence-RCE.md)\nPoC Exploit: [Exploit-DB](https://www.exploit-db.com/exploits/50243)\n\n##### Remediation\n\nDownload the latest Confluence version as per the above Security Advisory via the [Confluence Download Archives](https://www.atlassian.com/software/confluence/download-archives) and follow the upgrade steps provide by [Confluence Support](https://confluence.atlassian.com/doc/upgrading-confluence-4578.html) to remediate this vulnerability.\n\nA temporary workaround script for known vulnerable endpoints can be found at [cve-2021-26084-update.sh](https://confluence.atlassian.com/doc/files/1077906215/1077916296/2/1629936383093/cve-2021-26084-update.sh).",
                    "createdAt": "2021-08-27T06:26:49Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_42422",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-33766 - Microsoft Exchange Server ECP Authentication Bypass Information Disclosure Vulnerability (ProxyToken)",
                    "description": "##### Description\n\nIn a recently disclosed vulnerability writeup, researchers described their process in identifying a vulnerability within the Microsoft Exchange Control Panel (ECP) which allowed for bypassing authentication. By issuing crafted authentication requests to the affected system, remote attackers can bypass authentication to ECP. Such access can provide the ability for remote attackers to interact with emails pertaining to a target and forward them to an email address controlled by the attacker. Researchers noted that the vulnerability was patched by Microsoft as part of the July 2021 Exchange cumulative update.\n\n##### Related Intelligence\n\nCVE: [CVE-2021-33766](https://nvd.nist.gov/vuln/detail/CVE-2021-33766)\nCVE: [CVE-2021-31196](https://nvd.nist.gov/vuln/detail/CVE-2021-31196)\nSecurity Advisory: [Microsoft Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-33766)\nTechnical Vulnerability Writeup: [PROXYTOKEN: AN AUTHENTICATION BYPASS IN MICROSOFT EXCHANGE SERVER](https://www.zerodayinitiative.com/blog/2021/8/30/proxytoken-an-authentication-bypass-in-microsoft-exchange-server)\n\n##### Remediation\n\nMicrosoft recommends that organizations apply the July 2021 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Microsoft Exchange Server 2019 Cumulative Update 8\n- Microsoft Exchange Server 2016 Cumulative Update 19\n- Microsoft Exchange Server 2013 Cumulative Update 23\n- Microsoft Exchange Server 2016 Cumulative Update 20\n- Microsoft Exchange Server 2019 Cumulative Update 9\n\nOrganizations not running one of the supported versions for the July 2021 security update must upgrade to a supported version above and then apply the update.",
                    "createdAt": "2021-08-30T05:52:46Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_42489",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-3602 - OpenSSL 3 Buffer Overflow on Certificate Validation of Email Address",
                    "description": "##### Description\nA buffer overrun can be triggered in X.509 certificate verification, specifically in name constraint checking. Note that this occurs after certificate chain signature verification and requires either a\nCA to have signed the malicious certificate or for the application to continue certificate verification despite failure to construct a path to a trusted issuer. An attacker can craft a malicious email address to overflow attacker-controlled bytes on the stack. This buffer overflow could result in a crash (causing a denial of service) or potentially remote code execution.\n\nWe have no evidence of this issue being exploited as of the time of release of this advisory (November 1st 2022). Due to mitigations in place by most modern platforms OpenSSL has not identified any paths that allow remote code execution. However, OpenSSL is distributed as source code and is unable to verify that every potential platform and compiler combination arrange buffers in a way to mitigate the risk of remote code execution.\n\nOur detection works very well on web sites by reading HTTP headers, but other remote protocols do not advertise their OpenSSL version. Due to this limited visibility, we strongly recommend logging into each internet facing system and running `openssl version`to determine the patch level. Most Linux distros have not made the switch to OpenSSL 3 and are not vulnerable. \n\nPopular Operating Systems known to use OpenSSL 3:\n- Red Hat Enterprise Linux 9\n- Rocky Linux 9\n- CentOS Stream 9\n- Fedora 36\n- Alpine Linux 3.15+\n- Amazon Linux 2022\n- Ubuntu 22.04\n- Ubuntu 22.10\n- Kali 2022.3\n- Linux Mint 21\n- Debian 12\n\n##### Related Intelligence\n- CVE: [CVE-2022-3602](https://nvd.nist.gov/vuln/detail/CVE-2022-3602)\n- CVE: [CVE-2022-3786](https://nvd.nist.gov/vuln/detail/CVE-2022-3786)\n- Security Advisory: [OpenSSL](https://www.openssl.org/news/secadv/20221101.txt)\n- FAQs [OpenSSL Blog](https://www.openssl.org/blog/blog/2022/11/01/email-address-overflows/)\n- OpenSSL 3 Distro and Application List: [NCSC](https://github.com/NCSC-NL/OpenSSL-2022/blob/main/software/README.md)\n- Docker Advisory: [Container Search Tools](https://www.docker.com/blog/security-advisory-critical-openssl-vulnerability/)\n- Vulnerability Writeup: [Splunk](https://www.splunk.com/en_us/blog/security/nothing-puny-about-cve-2022-3602.html)\n- OpenSSL Library Scanner: [GitHub](https://github.com/MalwareTech/SpookySSLTools)\n\n##### Remediation\nUse your Linux distribution's package manager to upgrade the OS's OpenSSL package and restart the computer. OpenSSL is often packaged within another application, so please check any vendor provided apps for updates from the vendor.\n\nMicrosoft Defender for Cloud customers can find vulnerable OpenSSL versions by following the instructions in [this post](https://techcommunity.microsoft.com/t5/microsoft-defender-for-cloud/new-openssl-v3-vulnerability-prepare-with-microsoft-defender-for/ba-p/3666487).",
                    "createdAt": "2022-11-01T05:17:49Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57927",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Unauthenticated Kubelet API",
                    "description": "##### Description\nThe kubelet is an agent running on each node, which interacts with container runtime to launch pods and report metrics for nodes and pods. Each kubelet in the cluster exposes an API, which you can use to start and stop pods, and perform other operations. If an unauthorized user gains access to this API (on any node) and can run code on the cluster, they can compromise the entire cluster.\n\n##### Related Intelligence\nVendor Docs: [Kubernetes.io](https://kubernetes.io/docs/reference/access-authn-authz/kubelet-authn-authz/)\nThreat Intel: [Shadowserver](https://www.shadowserver.org/news/over-380-000-open-kubernetes-api-servers/)\nThreat Intel: [Cyble](https://www.bleepingcomputer.com/news/security/over-900-000-kubernetes-instances-found-exposed-online/)\nBest Practices: [Aquasec](https://www.aquasec.com/cloud-native-academy/kubernetes-in-production/kubernetes-security-best-practices-10-steps-to-securing-k8s/)\n\n##### Remediation\nRestrict access with a firewall as this service is **not** meant to be exposed to others over the network. If remote access is required, place it behind an authenticated proxy following the directions below.\n\nTo disable anonymous access and send `401 Unauthorized` responses to unauthenticated requests:\n-   start the kubelet with the `--anonymous-auth=false` flag\n\nTo enable X509 client certificate authentication to the kubelet's HTTPS endpoint:\n-   start the kubelet with the `--client-ca-file` flag, providing a CA bundle to verify client certificates with\n-   start the apiserver with `--kubelet-client-certificate` and `--kubelet-client-key` flags\n-   see the [apiserver authentication documentation](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#x509-client-certs) for more details\n\nTo enable API bearer tokens (including service account tokens) to be used to authenticate to the kubelet's HTTPS endpoint:\n-   ensure the `authentication.k8s.io/v1beta1` API group is enabled in the API server\n-   start the kubelet with the `--authentication-token-webhook` and `--kubeconfig` flags\n-   the kubelet calls the `TokenReview` API on the configured API server to determine user information from bearer tokens",
                    "createdAt": "2022-07-07T05:56:08Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_55821",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-21709 - Microsoft Exchange Server Elevation of Privilege",
                    "description": "##### Description \nExchange does not implement sufficient measures to prevent multiple failed authentication attempts within in a short time frame, making it more susceptible to brute force attacks. Microsoft encourages the use of strong passwords that are more difficult for an attacker to brute force. \n\n##### Related Intelligence\n- CVE: [CVE-2023-21709](https://nvd.nist.gov/vuln/detail/CVE-2023-21709)\n- Security Advisory: [Microsoft](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-21709)\n- Exchange Blog: [Microsoft](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-august-2023-exchange-server-security-updates/ba-p/3892811)\n\n##### Remediation \nMicrosoft recommends that organizations apply the Aug 2023 security update to impacted Exchange Servers **AND** to run specific PowerShell commands. The security update is available for the following versions:\n\n- Exchange Server 2019 [CU12](https://www.microsoft.com/download/details.aspx?familyID=5ffd5bed-1305-4505-b21a-caf4913d03da) and [CU13](https://www.microsoft.com/download/details.aspx?familyID=593a50a5-595a-43b4-a258-2c97a910b87f)\n- Exchange Server 2016 [CU23](https://www.microsoft.com/download/details.aspx?familyID=026d6264-dc26-4482-aad7-c7f8e250e872)\n- [Fixed patches for non-english systems](https://techcommunity.microsoft.com/t5/exchange-team-blog/re-release-of-august-2023-exchange-server-security-update/ba-p/3900025)\n\nAdditionally, [this](https://aka.ms/CVE-2023-21709ScriptDoc) script **must** be run after patching to remove the TokenCacheModule from Exchange. Alternatively, users can follow the \nPowerShell commands from the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-21709) instead of running the script.",
                    "createdAt": "2023-09-08T05:09:32Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59789",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-26427 Microsoft Exchange Server Remote Code Execution Vulnerability",
                    "description": "##### Description \nA remote code execution vulnerability exists in Microsoft Exchange Server. This vulnerability's attack is limited at the protocol level to a logically adjacent topology. This means it cannot simply be done across the internet, but instead needs something specific tied to the target. Good examples would include the same shared physical network (such as Bluetooth or IEEE 802.11), logical network (local IP subnet), or from within a secure or otherwise limited administrative domain (MPLS, secure VPN to an administrative network zone). From this point their attack allows changes to be made within the target Exchange server. The scope change is due to the attack on the network level triggering an effect on the OS level of the target system.\n\n##### Related Intelligence\nCVE: [CVE-2021-26427](https://nvd.nist.gov/vuln/detail/CVE-2021-26427) \nSecurity Advisory: [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-26427)\n\n##### Remediation\nMicrosoft recommends that organizations apply the Oct 2021 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU 10\n- Exchange 2016 CU 21\n- Exchange 2013 CU 23\n- Exchange 2019 CU 11\n- Exchange 2016 CU 22\n\nPlease see the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-26427) for a download links.",
                    "createdAt": "2021-10-22T08:38:35Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_44425",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Microsoft Patches Four 0-Day Remote Code Execution Vulnerabilities in Exchange Server (Patch)",
                    "description": "##### Description \nAs part of their April 2021 Patch Tuesday release, Microsoft patched several remote code execution vulnerabilities within Microsoft Exchange. Microsoft has noted that all of the CVEs related to Exchange have an exploitability assessment score of \"Exploitation More Likely\". Additionally, two of the CVEs--CVE-2021-28480 and CVE-2021-28481--are marked as not requiring any privileges nor user interaction to exploit. It is worth noting that Microsoft has not observed active exploitation of these vulnerabilities prior to the official patch release. \n\nProducts Affected:\n- Exchange Server 2019\n- Exchange Server 2016\n- Exchange Server 2013\n\nThis attack surface insight, highlights all instances of Microsoft Exchange 2013, 2016, and 2019 Cumulative Updates (CUs) are supported with an official patch. \n\n##### Related Intelligence\nCVEs: [CVE-2021-28480](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28480), [CVE-2021-28481](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28481), [CVE-2021-28482](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28482), [CVE-2021-28483](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28483)\n\nSecurity Advisory: [Microsoft Security Advisory](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-april-2021-exchange-server-security-updates/ba-p/2254617)  \n\nPoC Exploit Code: [Github - CVE-2021-28480] (https://gist.github.com/testanull/9ebbd6830f7a501e35e67f2fcaa57bda)\n\n##### Remediation\nTo address these vulnerabilities, organizations need to apply the April security patch for their supported Cumulative Update:\n- Exchange Server 2019: [CU8](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064) and [CU9](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064).\n- Exchange Server 2016: [CU19](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064) and [CU20](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064)\n- Exchange Server 2013: [CU23](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064)\n\n",
                    "createdAt": "2021-04-16T06:39:49Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_35944",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-23131 Zabbix Auth Bypass with SAML Configuration",
                    "description": "##### Description\nIn the case of instances where the SAML SSO authentication is enabled (non-default), session data can be modified by a malicious actor, because a user login stored in the session was not verified. Malicious unauthenticated actors may exploit this issue to escalate privileges and gain admin access to Zabbix Frontend. To perform the attack, SAML authentication is required to be enabled and the actor has to know the username of Zabbix user (or use the guest account, which is disabled by default).\n\nThe same Zabbix software also contain the vulnerability CVE-2022-23134. Possible view of the setup pages is possible by unauthenticated users if the configuration file already exists. \n\n##### Related Intelligence\nCVE: [CVE-2022-23131](https://nvd.nist.gov/vuln/detail/CVE-2022-23131)\nCVE: [CVE-2022-23134](https://nvd.nist.gov/vuln/detail/CVE-2022-23134)\nSecurity Advisory: [Zabbix](https://blog.zabbix.com/zabbix-security-advisories-regarding-cve-2022-23131-and-cve-2022-23134/19720/)\nVulnerability Writeup: [SonarSource](https://blog.sonarsource.com/zabbix-case-study-of-unsafe-session-storage)\nPoC Exploit: [GitHub](https://github.com/Mr-xn/cve-2022-23131)\n\n##### Remediation\nOn Linux systems, use your distribution's package manager to apply updates for your version of Zabbix. \n- [RHEL/CentOS based distros](https://www.zabbix.com/documentation/5.4/en/manual/installation/upgrade/packages/rhel_centos)\n- [Debian/Ubuntu based distros](https://www.zabbix.com/documentation/5.4/en/manual/installation/upgrade/packages/debian_ubuntu)",
                    "createdAt": "2022-03-29T05:09:44Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_52762",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-21745 - Microsoft Exchange Server Authenticated Privilege Escalation and Code Execution",
                    "description": "##### Description\nThese vulnerabilities were addressed in the January 2023 monthly patch.\n\n**CVE-2023-21745:**\nAn authenticated attacker could achieve exploitation through an OWA web session by calling a PowerShell remote session within the server. The specific flaw exists within the PowerShell endpoint as the process does not properly restrict user-supplied arguments before using them to create an instance of an object. An attacker can leverage this vulnerability to disclose information in the context of SYSTEM. The PowerShell service does NOT need to be exposed to remote servers to be vulnerable, as Exchange allows PowerShell commands within the web session.\n\n**CVE-2023-21762:**\nAn authenticated attacker exploiting this vulnerability could allow the disclosure of NTLM hashes. This vulnerability's attack is limited at the protocol level to a logically adjacent topology, and it allows  escalation of privileges. An attacker must first obtain the ability to execute low-privileged code on the target system in order to exploit this vulnerability, such as using phished credentials to connect to an Exchange server. The specific flaw exists within the GetTorusCmdletConfigurationEntries and TorusUpdateInitialSessionState functions. The functions load a library from an unsecured location. An attacker can leverage this vulnerability to escalate privileges and execute arbitrary code in the context of SYSTEM.\n\n**CVE-2023-21763 and CVE-2023-21764:**\nAuthenticated elevation of privilege to the SYSTEM user.\n\n##### Related Intelligence\n- CVE: [CVE-2023-21745](https://nvd.nist.gov/vuln/detail/CVE-2023-21745)\n- CVE: [CVE-2023-21762](https://nvd.nist.gov/vuln/detail/CVE-2023-21762)\n- CVE: [CVE-2023-21763](https://nvd.nist.gov/vuln/detail/CVE-2023-21763)\n- CVE: [CVE-2023-21764](https://nvd.nist.gov/vuln/detail/CVE-2023-21764)\n- Security Advisory: [Microsoft Security Advisory](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-january-2023-exchange-server-security-updates/ba-p/3711808)\n\n##### Remediation \nMicrosoft recommends that organizations apply the January 2023 security update to impacted Exchange Servers.  The security update is available for the following versions:\n- Exchange 2019 CU 12\n- Exchange 2019 CU 11\n- Exchange 2016 CU 23\n- Exchange 2016 CU 22\n- Exchange 2013 CU 23\n\nPlease see the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-21745) for download links.",
                    "createdAt": "2023-03-01T09:50:27Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58672",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-42115 - Exim Unauthenticated Remote Code Execution",
                    "description": "##### Description\n\nThe developers behind Exim have issued an update which patches an unauthenticated remote code execution. The specific flaw exists within the SMTP service, which listens on TCP port 25 by default. The issue results from the lack of proper validation of user-supplied data, which can result in a write past the end of a buffer. An attacker can leverage this vulnerability to execute code in the context of the service account.\n\nThe Exim team also patched several other vulnerabilities, including:\n\n- CVE-2023-42114 - Exim NTLM Challenge Out-Of-Bounds Read Information Disclosure Vulnerability\n- CVE-2023-42116 - Exim SMTP Challenge Stack-based Buffer Overflow Remote Code Execution Vulnerability\n\nAs of October 2, 2023, the EXIM team has not implemented fixes for the following reported vulnerabilities:\n\n- CVE-2023-42117 - Exim Improper Neutralization of Special Elements Remote Code Execution Vulnerability\n- CVE-2023-42118 - Exim libspf2 Integer Underflow Remote Code Execution Vulnerability\n- CVE-2023-42119 - Exim dnsdb Out-Of-Bounds Read Information Disclosure Vulnerability\n\n##### Related Intelligence\n\n- CVE: [CVE-2023-42115](https://nvd.nist.gov/vuln/detail/CVE-2023-42115)\n- CVE: [CVE-2023-42114](https://nvd.nist.gov/vuln/detail/CVE-2023-42114)\n- CVE: [CVE-2023-42116](https://nvd.nist.gov/vuln/detail/CVE-2023-42116)\n- CVE: [CVE-2023-42117](https://nvd.nist.gov/vuln/detail/CVE-2023-42117)\n- CVE: [CVE-2023-42118](https://nvd.nist.gov/vuln/detail/CVE-2023-42118)\n- CVE: [CVE-2023-42119](https://nvd.nist.gov/vuln/detail/CVE-2023-42119)\n- Security Advisory: [Exim Security Advisory](https://www.exim.org/static/doc/security/CVE-2023-zdi.txt)\n\n##### Remediation\nExim users should upgrade to the latest versions available, 4.96.1 or 4.97. It is worth noting that all versions prior to 4.96.1 are considered obsolete. ",
                    "createdAt": "2024-08-01T09:18:03Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60234",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-10374 Paessler PRTG Network Monitor Unauthenticated Remote Code Execution",
                    "description": "##### Description\nWith a carefully crafted POST request, a possible attacker can perform an RCE by executing a UNC path on the PRTG core server system with the security context of the PRTG core server service, without the need of an authenticated session.\n\nBy utilizing the *what* parameter of the screenshot function that is used in the [Contact Support form](https://www.paessler.com/manuals/prtg/support_contact_support#attach) in PRTG, for example, an attacker is able to inject a crafted, URI-compatible UNC path that is executed as part of the caller chain down to the Chromium engine to create the screenshot.\n\n##### Related Intelligence\nCVE: [CVE-2020-10374](https://nvd.nist.gov/vuln/detail/CVE-2020-10374)\nRelease Notes: [Paessler.com](https://www.paessler.com/prtg/history/prtg-20#20.1.57.1745)\n\n##### Remediation\nUpdate to version 20.1.57.1745 or newer by following the [vendor's documentation.](https://www.paessler.com/manuals/prtg/auto_update) Please consider enabling automatic updates for internet facing systems.",
                    "createdAt": "2022-02-08T08:43:04Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_51450",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-29357 - Microsoft SharePoint Server 2019 Authentication Bypass",
                    "description": "##### Description\nA vulnerability in SharePoint Server 2019 allows a remote attacker to bypass authentication by abusing a flaw inside the ValidateTokenIssuer method. A flawed cryptographic signature verification of the JWT token allows attackers to bypass the auth check and impersonate a given user on the system. Successful exploitation can result a full compromise of the SharePoint instance.\n\n##### Related Intelligence\n- CVE: [CVE-2023-29357](https://nvd.nist.gov/vuln/detail/CVE-2023-29357)\n- Security Advisory: [MSRC](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-29357)\n- Initial Disclosure: [Nguyễn Tiến Giang (@testanull) of STAR Labs SG  via Zero Day Initiative](https://www.zerodayinitiative.com/advisories/ZDI-23-882/)\n- Vulnerability Writeup:[VNPT](https://sec.vnpt.vn/2023/08/phan-tich-cve-2023-29357-microsoft-sharepoint-validatetokenissuer-authentication-bypass-vulnerability/)\n- PoC: [GitHub](https://github.com/Chocapikk/CVE-2023-29357)\n\n##### Remediation\nMicrosoft recommends that organizations apply the June 2023 security update from [KB 5002402](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-sharepoint-server-2019-june-13-2023-kb5002402-c5d58925-f7be-4d16-a61b-8ce871bbe34d).",
                    "createdAt": "2023-08-31T07:08:39Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59783",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-0688 Microsoft Exchange Memory Corruption Vulnerability",
                    "description": "##### Description \nA remote code execution vulnerability exists in Microsoft Exchange software when the software fails to properly handle objects in memory\n\n##### Related Intelligence\nCVE: [CVE-2020-0688](https://nvd.nist.gov/vuln/detail/CVE-2020-0688) \nSecurity Advisory: [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2020-0688)  \n\n##### Remediation\nOrganizations should upgrade to the latest version of Microsoft Exchange Server",
                    "createdAt": "2021-02-24T03:48:07Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29637",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-4448 IBM WebSphere Application Server Remote Code Execution Vulnerability",
                    "description": "##### Description \nIBM WebSphere Application Server Network Deployment 7.0, 8.0, 8.5, and 9.0 could allow a remote attacker to execute arbitrary code on the system with a specially-crafted sequence of serialized objects from untrusted sources.  Additionally, IBM noted that failed exploitation attempts can potentially lead to a denial of service condition.\n\n##### Related Intelligence\nCVE: [CVE-2020-4448](https://nvd.nist.gov/vuln/detail/CVE-2020-4448)\nSecurity Advisory: [IBM Security Bulliten](https://www.ibm.com/support/pages/security-bulletin-remote-code-execution-vulnerability-websphere-application-server-nd-cve-2020-4448)\n\n##### Remediation\nFor WebSphere Application Server ND traditional and WebSphere Application Server ND Hypervisor Edition IBM recommends Upgrade to minimal fix pack levels as required by interim fix and then apply Interim Fix [PH25216](https://www.ibm.com/support/pages/node/6220320) or:\n\n- For V9.0.0.0 through 9.0.5.3: Apply Fix Pack 9.0.5.4 or later.\n- For V8.5.0.0 through 8.5.5.17: Apply Fix Pack 8.5.5.18 or later",
                    "createdAt": "2021-02-19T04:51:08Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29422",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-7609 Kibana Timelion Remote Code Execution Vulnerability",
                    "description": "##### Description \nKibana versions before 5.6.15 and 6.6.1 contain an arbitrary code execution flaw in the Timelion visualizer. An attacker with access to the Timelion application could send a request that will attempt to execute javascript code. This could possibly lead to an attacker executing arbitrary commands with permissions of the Kibana process on the host system.  Timelion is part of the default Kibana installation for Kibana 5.x and higher.\n\nImpacted version\n- Version 5 before 5.6.15 \n- Version 6 before 6.6.1\n\n##### Related Intelligence\n\nCVE: [CVE-2019-7609](https://nvd.nist.gov/vuln/detail/CVE-2019-7609)\n\nProof of Concept Code: \n\n[GitHub mpgn](https://github.com/mpgn/CVE-2019-7609)\n\n[GitHub LandGray](https://github.com/LandGrey/CVE-2019-7609)\n\nSecurity Advisories: \n\n[Elastic Advisory](https://discuss.elastic.co/t/elastic-stack-6-6-1-and-5-6-15-security-update/169077) \n\n[Joint Government Advisory: Further TTPs associated\nwith SVR cyber actors](https://www.ncsc.gov.uk/files/Advisory%20Further%20TTPs%20associated%20with%20SVR%20cyber%20actors.pdf)\n\n##### Used By\n\nRiskIQ CTI Profile: [The Dukes](https://community.riskiq.com/research?query=The%20Dukes) \n\nMITRE Actor Profile: [G0016](https://attack.mitre.org/groups/G0016/) \n\n##### Remediation\nElastic recommends that organizations upgrade to Kibana version 6.6.1 or 5.6.15. Organizations that are unable to upgrade should ensure that  Timelion is disabled by setting timelion.enabled to false in the kibana.yml configuration file.",
                    "createdAt": "2021-05-18T09:46:49Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_38887",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "[Potential] CVE-2021-44207 - Acclaim Systems USAHERDS Use of Hard-Coded Credentials Vulnerability",
                    "description": "##### Description​\nThe USAHERDS web application, part of the AgraGuard product suite developed by Acclaim Systems, is vulnerable due to hard-coded credentials. This flaw allows attackers to exploit static ValidationKey and DecryptionKey values used in the ViewState mechanism, enabling malicious payloads that bypass integrity checks and execute arbitrary code, potentially leading to full system compromise. The high attack complexity vulnerability is being exploited in the wild.\n\nVersions 7.4.0.1 and earlier (released before November 2021) are affected. Acclaim Systems released a patch in November 2021 to address this issue.\nA _*Potential*_ insight occurs when we are able to detect the software but are unable to determine if the system is running a vulnerable version of said software. Please manually check the system to see if it is running a vulnerable version. For USAHERDS we can detect that you are running 7.4 or earlier, but we cannot detect if your version of 7.4 is patched. \n\n##### Related Intelligence​\n- CVE: [CVE-2021-44207](https://security.microsoft.com/intel-explorer/cves/CVE-2021-44207/)\n- Vulnerability Disclosure: [GitHub](https://github.com/mandiant/Vulnerability-Disclosures/blob/master/MNDT-2021-0012/MNDT-2021-0012.md)\n- CVE-2021-44207 IoCs: [Mandiant](https://cloud.google.com/blog/topics/threat-intelligence/apt41-us-state-governments)\n\n##### Remediation​\nFor organizations using vulnerable versions (7.4.0.1 and earlier, with builds released before November 2021), update to a patched version. For guidance on updating the USAHERDS application, consult either\n1. [The developer of the USAHERDS application, Acclaim Systems](https://www.acclaimsystems.com/) or;\n2. [The provider of the USAHERDS application, NATC](https://www.tnatc.org/#software)",
                    "createdAt": "2025-01-24T04:29:52Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250231300",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-0618 - Microsoft SQL Server Reporting Services Remote Code Execution Vulnerability",
                    "description": "##### Description\nA remote code execution vulnerability exists in Microsoft SQL Server Reporting Services when it incorrectly handles page requests. An attacker who successfully exploited this vulnerability could execute code in the context of the Report Server service account. To exploit the vulnerability, an authenticated attacker would need to submit a specially crafted page request to an affected Reporting Services instance. This vulnerability is under active exploitation and PoCs are available. \n\n##### Related Intelligence\n- CVE: [CVE-2024-0618](https://security.microsoft.com/intel-explorer/cves/CVE-2020-0618/) \n- Security Advisory: [Microsoft](https://msrc.microsoft.com/update-guide/en-US/advisory/CVE-2020-0618)\n- Technical Analysis and PoC: [MDSec](https://www.mdsec.co.uk/2020/02/cve-2020-0618-rce-in-sql-server-reporting-services-ssrs/)\n- PoC: [Packet Storm](https://packetstorm.news/files/id/156707)  \n- PoC: [Packet Storm](https://packetstorm.news/files/id/159216)\n\n##### Remediation\nIdentify your SQL Server version or the version range it belongs to, as outlined in Microsoft’s Security Advisory, and then install the appropriate security update. Follow Microsoft's [documentation](https://learn.microsoft.com/en-us/sql/database-engine/install-windows/upgrade-sql-server?view=sql-server-ver16) in how to upgrade your SQL Server.",
                    "createdAt": "2025-01-25T03:17:48Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250241000",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-27850 - Apache Tapestry Remote Code Execution via Patch Bypass",
                    "description": "##### Description\n\nA bypass for a previously-patched vulnerability (CVE-2019-0195) for Apache Tapestry was identified by a security researcher which allowed them to obtain remote code execute via deserialization. The bypass, labeled as CVE-2021-27850, allows a remote attacker to request sensitive resources such as `/assets/something/services/AppModule.class` (which contains a HMAC secret key) by adding an additional slash to the resource. In using the obtained HMAC secret key, an attacker can then sign Java gadgets sent to the server to obtain code execution. \n\n##### Related Intelligence\n\nCVE: [CVE-2021-27850](https://nvd.nist.gov/vuln/detail/CVE-2021-27850) \n\nSecurity Advisory: [Apache Mailing List Advisory](https://lists.apache.org/thread.html/r237ff7f286bda31682c254550c1ebf92b0ec61329b32fbeb2d1c8751%40%3Cusers.tapestry.apache.org%3E)\n\nPublic POC: [GitHub - CVE-2021-27850 Exploit](https://github.com/kahla-sec/CVE-2021-27850_POC)\n\n##### Remediation\n\nThere are no current workarounds for this issue, users will need to perform an upgrade to address this vulnerability. Users of Apache Tapestry 5.4.x up to and including 5.6.1 should upgrade to version 5.6.2. Users of Apache Tapestry 5.7.0 should ensure that they are running version 5.7.1 or later.\n",
                    "createdAt": "2021-06-30T04:35:27Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_40614",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-29849 - Veeam Backup Enterprise Manager Authentication Bypass Vulnerability",
                    "description": "##### Description\nOn May 21, 2024, Veeam released a security advisory regarding an authentication bypass vulnerability in Veeam Backup Enterprise Manager (VBEM). This issue impacts the following listed versions of Veeam Backup & Replication running VBEM:\n\n- All versions before Veeam Backup & Replication 12.1.2.172\n\nThe authentication bypass vulnerability in VBEM allows unauthenticated users to log in as any user to the enterprise manager web interface. \n\nAnalysis by Summoning Team reported that the log file found at **C:ProgramDataVeeamBackupSvc.VeeamRestAPI.log** can show indications of exploitation activity on affected systems. Searching for and finding \"Validating Single Sign-On token. Service enpoint URL:\" in the log file indicates an exploitation attempt. \n\nPlease note that a proof-of-concept (PoC) has been released for this vulnerability. \n\n##### Related Intelligence\n- CVE: [CVE-2024-29849](https://security.microsoft.com/intel-explorer/cves/CVE-2024-29849/)\n- Security Advisory: [Veeam](https://www.veeam.com/kb4581)\n- PoC: [SinSinology](https://github.com/sinsinology/CVE-2024-29849)\n- Technical Analysis: [Summoning Team](https://summoning.team/blog/veeam-enterprise-manager-cve-2024-29849-auth-bypass/) \n\n##### Remediation\nA patch is available via Veeam Backup & Replication version **12.1.2.172**. VBEM users can update by following [these instructions](https://helpcenter.veeam.com/docs/backup/em/em_updating.html?ver=120). The download files for **12.1.2.172** can be found [here](https://www.veeam.com/kb4510). ",
                    "createdAt": "2024-06-26T03:50:33Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60222",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "SUNBURST Supply Chain Attack Against SolarWinds Orion Compromises Numerous Organizations",
                    "description": "##### Description \nOn December 13, 2020, researchers at FireEye disclosed an active supply chain attack against SolarWinds stemming back to spring 2020 or earlier. The attack consisted of breaching an update server for SolarWinds Orion and uploading a weaponized update package. SolarWinds has noted that SolarWinds Orion 2019.4 HF 5 through 2020.2.1 are impacted.\n\n##### Related Intelligence\nRiskIQ Article: [Supply Chain Attack Against SolarWinds Orion Compromises Numerous Organizations](https://community.riskiq.com/article/c98949a2)\n\n##### Remediation \nSolarWinds has released an emergency hotfix for the Orion platform. Organizations are strongly encouraged to ensure that their systems are running the latest version.",
                    "createdAt": "2021-02-19T04:10:00Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29397",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-1329 - Elementor Page Builder Plugin for WordPress File Upload and Execution",
                    "description": "##### Description\nThe Elementor Website Builder plugin for WordPress is vulnerable to unauthorized execution of several AJAX actions due to a missing capability check in the ~/core/app/modules/onboarding/module.php file that make it possible for attackers to modify site data in addition to uploading malicious files that can be used to obtain remote code execution, in versions 3.6.0 to 3.6.2.\n\n##### Related Intelligence\nCVE: [CVE-2022-1329](https://nvd.nist.gov/vuln/detail/CVE-2022-1329)\nInitial Disclosure and PoC: [PluginVulnerabilities](https://www.pluginvulnerabilities.com/2022/04/12/5-million-install-wordpress-plugin-elementor-contains-authenticated-remote-code-execution-rce-vulnerability/)\n\n##### Remediation\nUpdate to version 3.6.3 or greater through the WordPress admin interface.",
                    "createdAt": "2022-08-09T03:14:21Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56400",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-22518 - Atlassian Confluence Improper Authorization",
                    "description": "##### Description\nThis vulnerability allows an unauthenticated attacker to reset Confluence and create a Confluence instance administrator account. Using this account, an attacker can then perform all administrative actions that are available to Confluence instance administrator leading to a full loss of confidentiality, integrity and availability.\n\nThis has been observed exploited in the wild and has lead to systems infected with ransomware. \n\n##### Related Intelligence\nCVE: [CVE-2023-22518](https://ti.defender.microsoft.com/cves/CVE-2023-22518)\nSecurity Advisory: [Atlassian](https://confluence.atlassian.com/security/cve-2023-22518-improper-authorization-vulnerability-in-confluence-data-center-and-server-1311473907.html)\nActivity Profile: [Rapid7](https://www.rapid7.com/blog/post/2023/11/06/etr-rapid7-observed-exploitation-of-atlassian-confluence-cve-2023-22518/)\nThreat Intel: [Microsoft Defender Threat Intelligence](https://ti.defender.microsoft.com/articles/fba16cc8)\nVulnerability Writeup: [ProjectDiscovery](https://blog.projectdiscovery.io/atlassian-confluence-auth-bypass/)\nPoC: [GitHub](https://github.com/davidfortytwo/CVE-2023-22518/blob/main/CVE-2023-22518.py)\n\n##### Remediation\nUpgrade to the following versions or newer to address this vulnerability. \n- 7.19.16\n- 8.3.4\n- 8.4.4\n- 8.5.3\n- 8.6.1\n\nDownload the latest Confluence version from the [Confluence Download Archives](https://www.atlassian.com/software/confluence/download-archives) and follow the upgrade steps provide by [Confluence Support](https://confluence.atlassian.com/doc/upgrading-confluence-4578.html) to remediate this vulnerability.\n\nYou can mitigate the attack by blocking the following endpoints with a WAF:\n1. `/json/setup-restore.action`\n2. `/json/setup-restore-local.action`\n3. `/json/setup-restore-progress.action`",
                    "createdAt": "2023-11-09T02:53:50Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59937",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-50623 & CVE-2024-55956 - Cleo Harmony, VLTrader, and LexiCom Unauthenticated File Upload and Execution",
                    "description": "##### Description\nAn unrestricted file upload and download vulnerability was found in Cleo Harmony before 5.8.0.24, VLTrader before 5.8.0.24, and LexiCom before 5.8.0.24. An unauthenticated attacker could upload, import, and execute arbitrary bash or PowerShell commands on the host system by leveraging the default settings of the Autorun directory. An initial patch of 5.8.0.21 did not address all of these issues and Cleo recommends upgrading to version 5.8.0.24.\n\nThe vulnerability affects only the following products:\n- Cleo Harmony *(prior to version 5.8.0.24)*\n- Cleo VLTrader *(prior to version 5.8.0.24)*\n- Cleo LexiCom *(prior to version 5.8.0.24)*\n\nIncident response company Huntress has seen evidence of exploitation as early as December 3. On December 9th Huntress broke the news of exploitation and provided a detailed incident response report of attacker activity. Their writeup can be found [here](https://www.huntress.com/blog/threat-advisory-oh-no-cleo-cleo-software-actively-being-exploited-in-the-wild). Other attackers have begun exploiting this, including the Lace Tempest ransomware operators.\n\nHuntress advises checking application logs for signs of compromise, including requests to `autorun\\healthchecktemplate.txt` and `autorun\\healthcheck.txt`. Rapid7 has also observed exploitation with attackers dropping a Java backdoor. \n\nWatchTowr Labs was able to recreate the exploit and released a PoC for it. Their exploit tries to upload files to the `/Synchronization`endpoint of the applications web root.\n\n##### Related Intelligence\n- CVE: [CVE-2024-50623](https://security.microsoft.com/intel-explorer/cves/CVE-2024-50623/)\n- CVE: [CVE-2024-55956](https://security.microsoft.com/intel-explorer/cves/CVE-2024-55956/)\n- Security Advisory: [Cleo Support](https://support.cleo.com/hc/en-us/articles/28408134019735-Cleo-Product-Security-Update)\n- Threat Intel, IOCs, & Forensic Writeup: [Huntress](https://www.huntress.com/blog/threat-advisory-oh-no-cleo-cleo-software-actively-being-exploited-in-the-wild)\n- Additional Info on the 0day Vulnerability: [John Hammond x.com](https://x.com/i/web/status/1867017061601612153 )\n- Forensic Analysis of Java Backdoor: [Rapid7](https://www.rapid7.com/blog/post/2024/12/11/etr-modular-java-backdoor-dropped-in-cleo-exploitation-campaign/)\n- Vulnerability Writeup: [WatchTowr Labs](https://labs.watchtowr.com/cleo-cve-2024-50623/)\n- PoC: [GitHub - WatchTowr Labs](https://github.com/watchtowrlabs/CVE-2024-50623/)\n- Threat Intel: [Microsoft Intel Profile - Cleo File Transfer Exploitation](https://security.microsoft.com/intel-profiles/CVE-2024-50623)\n\n##### Remediation\nFollow the [vendor's documentation](https://support.cleo.com/hc/en-us/articles/360033708134-Updating-your-software) to install the latest supported version for your release. To address this vulnerability make sure to upgrade to these versions or higher:\n- Cleo Harmony 5.8.0.24\n- Cleo VLTrader 5.8.0.24\n- Cleo LexiCom 5.8.0.24",
                    "createdAt": "2024-12-19T09:05:12Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_243480100",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Microsoft Patches Four 0-Day Remote Code Execution Vulnerabilities in Exchange Server (Upgrade & Patch)",
                    "description": "##### Description \nAs part of their April 2021 Patch Tuesday release, Microsoft patched several remote code execution vulnerabilities within Microsoft Exchange. Microsoft has noted that all of the CVEs related to Exchange have an exploitability assessment score of \"Exploitation More Likely\". Additionally, two of the CVEs--CVE-2021-28480 and CVE-2021-28481--are marked as not requiring any privileges nor user interaction to exploit. It is worth noting that Microsoft has not observed active exploitation of these vulnerabilities prior to the official patch release. \n\nProducts Affected:\n- Exchange Server 2019\n- Exchange Server 2016\n- Exchange Server 2013\n\nThis attack surface insight, highlights all instances of Microsoft Exchange 2013, 2016, and 2019 Cumulative Updates (CUs) that are not currently supported with an official patch. \n\n##### Related Intelligence\nCVEs: [CVE-2021-28480](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28480), [CVE-2021-28481](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28481), [CVE-2021-28482](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28482), [CVE-2021-28483](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-28483)\n\nSecurity Advisory: [Microsoft Security Advisory](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-april-2021-exchange-server-security-updates/ba-p/2254617)  \n\n\nPoC Exploit Code: [Github - CVE-2021-28480] (https://gist.github.com/testanull/9ebbd6830f7a501e35e67f2fcaa57bda)\n\n##### Remediation\nTo address these vulnerabilities, organizations need to upgrade their Microsoft Exchange servers to the latest available cumulative update. The following cumulative updates support the April security patch:\n- Exchange Server 2019: [CU8](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064) and [CU9](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064).\n- Exchange Server 2016: [CU19](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064) and [CU20](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064)\n- Exchange Server 2013: [CU23](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064)\nAt this time Microsoft is not planning to support additional updates and has released a step-by-step guide to assist customers in migrating to the latest available cumulative update. This guide can be found at the following link: https://exupdatestepbystep.azurewebsites.net/\n",
                    "createdAt": "2021-04-16T06:24:18Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_35942",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-25276 SolarWinds Serv-U FTP Admin Vulnerability",
                    "description": "##### Description \nIn SolarWinds Serv-U before 15.2.2 Hotfix 1, there is a directory containing user profile files (that include users' password hashes) that is world readable and writable. An unprivileged Windows user (having access to the server's filesystem) can add an FTP user by copying a valid profile file to this directory. \n\n##### Related Intelligence\nRiskIQ Article: [Multiple Vulnerabilities Reported In SolarWinds Orion and Serv-U](https://community.riskiq.com/article/08a89f65)\nCVE: [mitre.org](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-25276)\n\n##### Remediation\nOrganizations should upgrade to Serv-U 15.2.2 Hotfix 1",
                    "createdAt": "2021-02-19T03:56:45Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29393",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-26134 - Atlassian Confluence Unauthenticated Remote Code Execution",
                    "description": "##### Description\nAtlassian has been made aware of current active exploitation of a critical severity unauthenticated remote code execution vulnerability in Confluence Data Center and Server. The OGNL injection vulnerability allows an unauthenticated user to execute arbitrary code on a Confluence Server or Data Center instance. Exploit code has been made public and there is mass exploitation observed. It appears that Confluence systems behind a proxy such as Apache or Nginx may have some level of resistance to this vulnerability. \n\n##### Related Intelligence\nCVE: [CVE-2022-26134](https://nvd.nist.gov/vuln/detail/CVE-2022-26134)\nSecurity Advisory: [Atlassian](https://confluence.atlassian.com/doc/confluence-security-advisory-2022-06-02-1130377146.html)\nInitial Disclosure: [Volexity](https://www.volexity.com/blog/2022/06/02/zero-day-exploitation-of-atlassian-confluence/)\nBug Tracker: [CONFSERVER-79000](https://jira.atlassian.com/browse/CONFSERVER-79000)\nVulnerability Writeup: [Rapid7](https://www.rapid7.com/blog/post/2022/06/02/active-exploitation-of-confluence-cve-2022-26134/)\nPoC: [GitHub](https://github.com/jbaines-r7/through_the_wire)\nThreat Intel: [Trend Micro](https://www.trendmicro.com/en_us/research/22/i/atlassian-confluence-vulnerability-cve-2022-26134-abused-for-cryptocurrency-mining-other-malware.html)\n\n##### Remediation\nVersions 7.4.17, 7.13.7, 7.14.3, 7.15.2, 7.16.4, 7.17.4 or 7.18.1 have been released to fix the issue.  Upgrade to one of those versions or newer to address this vulnerability.\n\nDownload the latest Confluence version from the [Confluence Download Archives](https://www.atlassian.com/software/confluence/download-archives) and follow the upgrade steps provide by [Confluence Support](https://confluence.atlassian.com/doc/upgrading-confluence-4578.html) to remediate this vulnerability.\n\nAtlassian previously suggested the following but have since removed it from their advisory. Use it at your own risk.\n`**If you are unable to take the above actions** implementing a WAF (Web Application Firewall) rule which blocks URLs containing `${` **may reduce your risk**.`",
                    "createdAt": "2022-06-03T04:48:25Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_54776",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023–38646 Metabase Unauthenticated Command Execution",
                    "description": "##### Description\nMetabase open source before 0.46.6.1 and Metabase Enterprise before 1.46.6.1 allow attackers to execute arbitrary commands on the server, at the server's privilege level. Authentication is not required for exploitation. The other fixed versions are 0.45.4.1, 1.45.4.1, 0.44.7.1, 1.44.7.1, 0.43.7.2, and 1.43.7.2. This has been observed to be exploited in the wild.\n\nAccording to Metabase this vulnerability allows attackers to do the following:\n1. Call `/api/session/properties` to get the setup token.\n2. Use the setup token to call `/api/setup/validate`.\n3. Take advantage of the missing checks to get H2 to execute commands on the host operating system.\n4. Open a reverse shell, create admin accounts, etc.\n\n##### Related Intelligence\n- CVE: [CVE-2023–38646](https://community.riskiq.com/cve-article/CVE-2023–38646/description)\n- Security Advisory: [Metabase.com](https://www.metabase.com/blog/security-advisory)\n- Post-Mortem Incident Summary: [Metabase.com](https://www.metabase.com/blog/security-incident-summary)\n- Vulnerability Writeup: [Assetnote.io](https://blog.assetnote.io/2023/07/22/pre-auth-rce-metabase/)\n- Vulnerability Writeup: [Shamooo](https://infosecwriteups.com/cve-2023-38646-metabase-pre-auth-rce-866220684396)\n- PoC: [GitHub](https://github.com/shamo0/CVE-2023-38646-PoC)\n\n##### Remediation\nUpdate Metabase to release (0.46.6.1 or 1.46.6.1), or any subsequent release after that. Vendor instructions on how to update can be found [here](https://www.metabase.com/docs/latest/installation-and-operation/upgrading-metabase).",
                    "createdAt": "2023-10-10T04:27:05Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59827",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-20025 - Cisco Small Business RV Routers Unauthenticated Remote Command Execution",
                    "description": "##### Description\nA vulnerability in the web-based management interface of Cisco Small Business RV016, RV042, RV042G, and RV082 Routers allows unauthenticated remote attacker to bypass authentication. This is due to improper validation of user input within incoming HTTP packets. A successful exploit could allow the attacker to bypass authentication and gain _root_ access on the underlying operating system.\n\nThese devices have reached end-of-life and will not be patched. A proof-of-concept exploit code has been created, although at the time of writing is has not been shared publicly. \n\n##### Related Intelligence\n- CVE: [CVE-2023-20025](https://nvd.nist.gov/vuln/detail/CVE-2023-20025)\n- CVE: [CVE-2023-20026](https://nvd.nist.gov/vuln/detail/CVE-2023-20026)\n- Security Advisory: [Cisco](https://sec.cloudapps.cisco.com/security/center/content/CiscoSecurityAdvisory/cisco-sa-sbr042-multi-vuln-ej76Pke5)\n\n##### Remediation\nCisco has not released and will not release software updates to address the vulnerabilities described in this advisory. Cisco Small Business RV016, RV042, RV042G, and RV082 Routers have entered the end-of-life process. Follow [Cisco's workaround](https://sec.cloudapps.cisco.com/security/center/content/CiscoSecurityAdvisory/cisco-sa-sbr042-multi-vuln-ej76Pke5) to disable remote management or replace the hardware with one that is not end-of-life.",
                    "createdAt": "2023-01-20T09:15:45Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58388",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-47246 - SysAid Help Desk Path Traversal to Remote Code Execution",
                    "description": "##### Description\nIn SysAid Help Desk before 23.3.36, a path traversal vulnerability leads to code execution after an attacker writes a file to the Tomcat webroot, as exploited in the wild by Lace Tempest in November 2023. Tomcat web shells have been observed being used along with malicious PowerShell commands. \n\nThe Huntress Research team was able to create a weaponized proof of concept to exploit the path traversal and file write vulnerability. This exists in the **doPost** method within the SysAid **com.ilient.server.UserEntry** class. By injecting a path traversal into the **accountID** parameter and supplying a zlib compressed WAR file webshell as the POST request body, an attacker can control where this webshell is written on the vulnerable server. The attacker can then request the webshell by browsing to the URL where it now resides to gain access to the server.\n\n##### Related Intelligence\n- CVE: [CVE-2023-47246](https://ti.defender.microsoft.com/cves/CVE-2023-47246/)\n- Security Advisory: [SysAid Blog](https://www.sysaid.com/blog/service-desk/on-premise-software-security-vulnerability-notification)\n- Threat Intel: [Microsoft](https://ti.defender.microsoft.com/articles/d028ff95)\n- Vulnerability Details: [Huntress](https://www.huntress.com/blog/critical-vulnerability-sysaid-cve-2023-47246)\n\n##### Remediation\nFollow the [SysAid documentation](https://documentation.sysaid.com/docs/latest-version-installation-files) to upgrade to the latest version for your release. Also check for evidence of exploitation using the indicators provided by [Microsoft's Threat Intel](https://ti.defender.microsoft.com/articles/d028ff95) or the [SysAid Blog](https://www.sysaid.com/blog/service-desk/on-premise-software-security-vulnerability-notification).",
                    "createdAt": "2023-11-29T10:24:57Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60003",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2014-9222 - RomPager Misfortune Cookie Auth Bypass",
                    "description": "##### Description\nAllegroSoft RomPager 4.34 and earlier, as used in many products from different vendors, allows remote attackers to gain privileges via a crafted cookie that triggers memory corruption, aka the \"Misfortune Cookie\" vulnerability. This vulnerability has been exploited in the wild for many years and is used in many embedded IoT devices.\n\n##### Related Intelligence\nCVE: [CVE-2014-9222](https://nvd.nist.gov/vuln/detail/CVE-2014-9222)\nCVE: [CVE-2014-9223](https://nvd.nist.gov/vuln/detail/CVE-2014-9223)\nSecurity Advisory: [CheckPoint](https://sc1.checkpoint.com/misfortune-cookie/index.html)\nVulnerability Writeup: [NCC Group](https://research.nccgroup.com/wp-content/uploads/2020/07/porting-the-misfortune-cookie-exploit-whitepaper.pdf)\nPoC: [ExploitDB](https://www.exploit-db.com/exploits/39739)\nNmap Module: [http-vuln-misfortune-cookie](https://nmap.org/nsedoc/scripts/http-vuln-misfortune-cookie.html)\nMetasploit Module: [auxiliary/admin/http/allegro_rompager_auth_bypass](https://github.com/rapid7/metasploit-framework/blob/master/modules/auxiliary/admin/http/allegro_rompager_auth_bypass.rb)\n\n##### Remediation\nUpgrade to version 4.35 or higher. Not all manufacturers have updated their devices with the latest RomPager software component. In some cases, manufacturers continue to make and sell products with software components that are over 13 years old, which can expose products to security concerns. Allegro Software is a software component supplier to product manufacturers. Allegro Software does not have the ability to upgrade or patch customer’s devices. If you have a product that is affected please contact the product manufacturer to obtain a firmware update.",
                    "createdAt": "2022-06-01T06:19:35Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_54650",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-37149 - GLPI Remote Code Execution Through SQLi in Plugin Loader",
                    "description": "##### Description\nGLPI is an open-source asset and IT management software package that provides ITIL Service Desk features, licenses tracking and software auditing. An authenticated technician user can upload a malicious PHP script and hijack the plugin loader to execute this malicious script. Versions from 0.85 to 10.0.15 are affected.\n##### Related Intelligence\n- CVE: [CVE-2024-37149](https://security.microsoft.com/intel-explorer/cves/CVE-2024-37149/) \n- Security Advisory: [Github](https://github.com/glpi-project/glpi/security/advisories/GHSA-cwvp-j887-m4xh)\n- Vulnerability Writeup and PoC: [Sensepost](https://sensepost.com/blog/2024/from-a-glpi-patch-bypass-to-rce/)\n##### Remediation\nFollow the vendor's [documentation](https://glpi-install.readthedocs.io/en/latest/install/index.html#) to upgrade to version 10.0.16 or higher.",
                    "createdAt": "2025-01-21T08:33:00Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250170400",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-3396 - Atlassian Confluence Widget Connector macro Path Traversal and Remote Code Execution",
                    "description": "##### Description\nThe Widget Connector macro in Atlassian Confluence Server before version 6.6.12 (the fixed version for 6.6.x), from version 6.7.0 before 6.12.3 (the fixed version for 6.12.x), from version 6.13.0 before 6.13.3 (the fixed version for 6.13.x), and from version 6.14.0 before 6.14.2 (the fixed version for 6.14.x), allows remote attackers to achieve path traversal and remote code execution on a Confluence Server or Data Center instance via server-side template injection.\n\n##### Related Intelligence\nCVE: [CVE-2019-3396](https://nvd.nist.gov/vuln/detail/CVE-2019-3396)\nAtlassian Advisory: [Confluence Security Advisory - 2019-03-20](https://confluence.atlassian.com/doc/confluence-security-advisory-2019-03-20-966660264.html)\nPublic PoC: https://www.exploit-db.com/exploits/46731 \n\n##### Remediation\nConfluence administrators should ensure that they are running the most current version of Confluence. CVE-2019-3396 was fixed in the following updates: \n\n* 6.12.3\n* 6.14.2\n* 6.6.12\n* 6.13.3\n\nA workaround for systems that cannot be updated is to disable the WebDAV and Widget Connector add-ons. Atlassian noted that \"If you disable the Widget Connector plugin, the Widget Connector macro will not be available. This macro is used to display content from websites like YouTube, Vimeo, and Twitter. Users will see an 'unknown macro' error. If you disable the WebDAV plugin, you will not be able to connect to Confluence using a WebDAV client. Disabling this plugin will also automatically disable the Office Connector plugin, which means Office Connector features such as Import from Word, and Edit in Office will not be available. Note that because WebDAV is not required to edit files from Confluence 6.11 and later, you will still be able to edit files in those versions.\"",
                    "createdAt": "2022-08-16T06:17:20Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56537",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Elementor Pro for WordPress Authenticated Privilege Escalation if Installed with WooCommerce",
                    "description": "##### Description\nThis vulnerability only affects the Pro version and not the free community edition. It also requires the WooCommerce WordPress plugin installed for this to be exploited.\n\nThe Elementor Pro plugin for WordPress is vulnerable to unauthorized data modification due to a missing capability check on the update_page_option function in versions up to, and including, 3.11.6. This makes it possible for authenticated attackers with subscriber-level capabilities to update arbitrary site options, which can lead to privilege escalation.\n\n##### Related Intelligence\nCVE: [None]\nVulnerability Writeup: [Jerome Bruandet at NinTechNet](https://blog.nintechnet.com/high-severity-vulnerability-fixed-in-wordpress-elementor-pro-plugin/)\nThreat Intel: [Patchstack](https://patchstack.com/articles/critical-elementor-pro-vulnerability-exploited/)\n\n##### Remediation\nUpdate this plugin to version 3.11.7 or greater through your sites's WordPress admin interface.\n\n##### Indicators of Compromise\nCheck your file system for the following filenames that have been observed in the wild:\n-  wp-resortpack.zip\n-   wp-rate.php\n-   lll.zip",
                    "createdAt": "2023-04-07T08:58:33Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59107",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "VagabonKit",
                    "description": "Vagabon is a kit we’ve identified being frequently used to impersonate Paypal in phishing campaigns.",
                    "createdAt": "2023-01-04T10:58:59Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_30713",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-35211 - SolarWinds Serv-U Remote Memory Escape Vulnerability",
                    "description": "##### Description\n\nOn July 9, 2021, SolarWinds released a hotfix (HF) for their Serv-U FTP and Serv-U Managed File Transfer service which contained a fix for a remote code execution vulnerability via a memory escape. According to the SolarWinds security advisory, \"Microsoft has provided evidence of limited, targeted customer impact, though SolarWinds does not currently have an estimate of how many customers may be directly affected by the vulnerability\". It is worth noting that in order for the Serv-U vulnerability to exist, SSH must be enabled. Please note that this insight surfaces Serv-U instances where SSH has also been detected\n\n##### Related Intelligence\n\nRiskIQ Article: [Microsoft discovers threat actor targeting SolarWinds Serv-U software with 0-day exploit](https://community.riskiq.com/article/c9defafd/description)\n\nCVE: [CVE-2021-35211](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-35211)\n\nSecurity Advisory: [SolarWinds Serv-U Remote Memory Escape Vulnerability](https://www.solarwinds.com/trust-center/security-advisories/cve-2021-35211)\n\n##### Used By\n\n[DEV-0322](https://www.microsoft.com/security/blog/2021/07/13/microsoft-discovers-threat-actor-targeting-solarwinds-serv-u-software-with-0-day-exploit/)\n\n##### Remediation\n\nOrganizations leveraging Serv-U should ensure that they are running at least version 15.2.3 Hotfix2 OR 15.2.4. \n\nOrganizations that cannot immediately update should ensure that SSH is disabled on the host running Serv-U, as SSH is a component required for full exploitation.",
                    "createdAt": "2021-07-13T08:33:37Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_40898",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-24086 Magento Unauthenticated Remote Code Execution",
                    "description": "##### Description\nAn unauthenticated remote code execution vulnerability has been found due to improper input validation. This new vulnerability impacts versions 2.3.3-p1 to 2.3.7-p2 and 2.4.0 to 2.4.3-p1, and it has been exploited in the wild with additional attacks forthcoming. Magento 2.3.3 and lower are not affected at this time.\n\n##### Related Intelligence\nCVE: [CVE-2022-24086](https://nvd.nist.gov/vuln/detail/CVE-2022-24086) \nSecurity Bulletin: [Adobe APSB22-12](https://helpx.adobe.com/security/products/magento/apsb22-12.html)\nRelease Notes: [Magento](https://support.magento.com/hc/en-us/articles/4426353041293-Security-updates-available-for-Adobe-Commerce-APSB22-12)\nSecurity Advisory: [Sansec](https://sansec.io/research/magento-2-cve-2022-24086)\n\n##### Remediation\nFollow the [vendor's instructions](https://support.magento.com/hc/en-us/articles/360028367731) for applying the patch. Alternate instructions can be found [here](https://gist.github.com/wigman/171f9314d692d23330591d20cec3a9fd).",
                    "createdAt": "2022-02-16T09:52:35Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_51683",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-41082 & CVE-2022-41040 - Microsoft Exchange Server Authenticated SSRF and PowerShell RCE",
                    "description": "##### Description \nTwo 0day vulnerabilities have been observed in very limited attacks in the wild for Microsoft Exchange 2013, 2016, and 2019. Chained together, these can lead an authenticated attacked to user server side request forgery to initiate a remote PowerShell command on the Exchange server. Common tactics an attacker can use are to phish users or leverage credential stuffing attacks to obtain authentication. Some are calling these vulnerabilities ProxyNotShell.\n\nMicrosoft released a fix on Nov 8th 2022, see the remediation and detection guidance below. Microsoft Exchange Online has detections and mitigation in place to protect customers. Microsoft is also monitoring these already deployed detections for malicious activity and will take necessary response actions to protect customers.\n\n##### Related Intelligence\nCVE: [CVE-2022-41080](https://nvd.nist.gov/vuln/detail/CVE-2022-41080) \nCVE: [CVE-2022-41082](https://nvd.nist.gov/vuln/detail/CVE-2022-41082) \nCVE: [CVE-2022-41040](https://nvd.nist.gov/vuln/detail/CVE-2022-41040) \nSecurity Advisory: [Microsoft Security Advisory](https://msrc-blog.microsoft.com/2022/09/29/customer-guidance-for-reported-zero-day-vulnerabilities-in-microsoft-exchange-server/)\nInitial Disclosure: [GTSC](https://gteltsc.vn/blog/warning-new-attack-campaign-utilized-a-new-0day-rce-vulnerability-on-microsoft-exchange-server-12715.html)\nAdditional Guidance: [Microsoft Security Threat Intel](https://www.microsoft.com/security/blog/2022/09/30/analyzing-attacks-using-the-exchange-vulnerabilities-cve-2022-41040-and-cve-2022-41082/)\nMitigation: [Exchange On-premises Mitigation Tool v2 script](https://microsoft.github.io/CSS-Exchange/Security/EOMTv2/) \nOfficial patch: [Microsoft](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-november-8-2022-kb5019758-2b3b039b-68b9-4f35-9064-6b286f495b1d)\nVulnerability Writeup: [ZDI](https://www.zerodayinitiative.com/blog/2022/11/14/control-your-types-or-get-pwned-remote-code-execution-in-exchange-powershell-backend)\nPoC: [GitHub](https://github.com/testanull/ProxyNotShell-PoC)\nThreat Intel: [MDTI Play Ransomware](https://community.riskiq.com/article/462b5d7d)\nThreat Intel: [Crowdstrike](https://www.crowdstrike.com/blog/owassrf-exploit-analysis-and-recommendations/)\nThreat Intel: [Rapid7](https://www.rapid7.com/blog/post/2022/12/21/cve-2022-41080-cve-2022-41082-rapid7-observed-exploitation-of-owassrf-in-exchange-for-rce/)\n\n##### Remediation \nMicrosoft recommends that organizations apply the Nov 2022 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU 11\n- Exchange 2016 CU 23\n- Exchange 2013 CU 23\n- Exchange 2019 CU 12\n- Exchange 2016 CU 22\n\nPlease see the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-41040) for a download links.\n\n*Workaround* \nAt the time of initial publication, September 30th 2022, no official patch had been released by Microsoft. The following is mitigation advice given at the time. **Now that a patch is available, it is critical to apply it instead of using this workaround.**\n\nSelf hosted Exchange administrators are encouraged to create a rewrite policy to specifically block requests contain Proxyshell-like strings. The [Exchange On-premises Mitigation Tool v2 script](https://microsoft.github.io/CSS-Exchange/Security/EOMTv2/) has been shared to create a rewrite policy, or you can manually follow the most up-to-date directions provided by Microsoft [here](https://msrc-blog.microsoft.com/2022/09/29/customer-guidance-for-reported-zero-day-vulnerabilities-in-microsoft-exchange-server/).\n\n##### Detection \nLike Proxyshell detection, analysts can inspect log content containing the following pattern:  \n```'powershell.*autodiscover.json.*@.*200```\n  \nIn addition to inspecting logs, analysts should look for the presence of newly created or potentially malicious aspx and ashx files within 'MicrosoftExchange ServerV15FrontEndHttpProxyowaauth' as observed in recent attacks.\n\nAdditional detections for customers of Microsoft Sentinel, Defender for Endpoint, and Antivirus can be found [here](https://msrc-blog.microsoft.com/2022/09/29/customer-guidance-for-reported-zero-day-vulnerabilities-in-microsoft-exchange-server/).",
                    "createdAt": "2022-09-30T05:08:06Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57384",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Kaswara Addon for WPBakery WordPress Plugin CVE-2021-24284",
                    "description": "##### Description\nThe plugin allows unauthenticated arbitrary file upload via the 'uploadFontIcon' AJAX action to the plugin's icon directory. A supplied zipfile can be unzipped in the wp-content/uploads/kaswara/fonts_icon directory with no checks for malicious files such as PHP.  The issue has been confirmed in version up to 2.3.1 by Robin Goodfellow. In v3.x the uploadFontIcon AJAX action does not exist anymore, but other actions can be used to achieve the same goal. \n\n##### Related Intelligence\nCVE: [CVE-2021-24284](https://nvd.nist.gov/vuln/detail/CVE-2021-24284)\nSecurity Advisory: [wpscan.com](https://wpscan.com/vulnerability/8d66e338-a88f-4610-8d12-43e8be2da8c5)\nThreat Intel: [WordFence](https://www.wordfence.com/blog/2022/07/attacks-on-modern-wpbakery-page-builder-addons-vulnerability/)\nForensic Writeup: [Jetpack](https://jetpack.com/blog/vulnerable-kaswara-modern-wpbakery-plugin/)\n\n##### Remediation\nRemove this plugin immediately and begin incident response procedures.  The plugin is no longer being maintained and no patch will be available.\n\n*Indicators of Compromise*\nThe uploaded files are usually located in /wp-content/uploads/kaswara/ (check all folders there), but can be put anywhere via a path traversal vector.\n- /wp-content/uploads/kaswara /fonts_icon/jg4/coder.php\n- /wp-content/uploads/kaswara/icons/brt/t.php\n- /wp-content/uploads/kaswara/icons/kntl/img.php\n- /wp-content/uploads/kaswara/fonts_icon/15/icons.php\n-  [xxx]_young.zip where [xxx] varies and typically consists of 3 characters like ‘svv_young’\n-  inject.zip\n-  king_zip.zip\n-  null.zip\n-  plugin.zip\n- a57bze8931.zip, extracted to a57bze8931.php\n- the string **;if(ndsw==** injected into javascript files\n\nThis POST request has been commonly seen in web logs:\n- /wp-admin/admin-ajax.php?action=uploadFontIcon HTTP/1.1",
                    "createdAt": "2022-07-18T08:23:22Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56074",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "ASI: CVE-2023-40044 - WS_FTP Server Ad Hoc Transfer Unauthorized Deserialization",
                    "description": "##### Description\nIn WS_FTP Server versions prior to 8.7.4 and 8.8.2, a pre-authenticated attacker could leverage a .NET deserialization vulnerability in the Ad Hoc Transfer module to execute remote commands on the underlying WS_FTP Server operating system. An attacker can craft a malicious HTTP POST request with a crafted payload to trigger arbitrary command injection. Exploitation has been observed in the wild and Microsoft recommend's patching as soon as possible.\n\nSystems that have disabled the ad hoc transfer HTTP module are not cannot be exploited by this vulnerability. This does not affect the WS_FTP file transfer services running by default on port 21 or 22.\n\n##### Related Intelligence\n- CVE: [CVE-2023-40044](https://nvd.nist.gov/vuln/detail/CVE-2023-40044)\n- CVE: [CVE-2023-42657](https://nvd.nist.gov/vuln/detail/CVE-2023-42657)\n- Security Advisory: [Progress](https://community.progress.com/s/article/WS-FTP-Server-Critical-Vulnerability-September-2023)\n- Initial Disclosure and Detailed Writeup: [Assetnote](https://www.assetnote.io/resources/research/rce-in-progress-ws-ftp-ad-hoc-via-iis-http-modules-cve-2023-40044)\n\n##### Remediation\nUpgrade to one of the versions listed below by using the full installer, which will bring the system down while it updates. \n\nWS_FTP Server 2020.0.4 (8.7.4) \n- [Upgrade Documentation](https://community.progress.com/s/article/How-do-I-upgrade-WS-FTP-Server)\n- [WS_FTP Server 2020 release notes](https://docs.ipswitch.com/WS_FTP_Server2020/ReleaseNotes/index.htm)|\nWS_FTP Server 2022.0.2 (8.8.2)\n- [Upgrade Documentation](https://community.progress.com/s/article/How-do-I-upgrade-WS-FTP-Server)\n- [WS_FTP Server 2022 release notes](https://docs.ipswitch.com/WS_FTP_Server2022/ReleaseNotes/index.htm)\n\nAs a workaround to applying patches, admins may disable the ad hoc transfer module by following this [vendor documentation](https://community.progress.com/s/article/Removing-or-Disabling-the-WS-FTP-Server-Ad-hoc-Transfer-Module).",
                    "createdAt": "2023-10-05T02:53:11Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59821",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-11073 Paessler PRTG Network Monitor Unauthenticated Remote Code Execution",
                    "description": "##### Description\nA Remote Code Execution vulnerability exists in PRTG Network Monitor before 19.4.54.1506 that allows attackers to execute code due to insufficient sanitization when passing arguments to the HttpTransactionSensor.exe binary. In order to exploit the vulnerability, remote authenticated administrators need to create a new HTTP Transaction Sensor and set specific settings when the sensor is executed.\n\n##### Related Intelligence\nCVE: [CVE-2019-11073](https://nvd.nist.gov/vuln/detail/CVE-2019-11073)\nRelease Notes: [Paessler.com](https://www.paessler.com/prtg/history/prtg-19#19.4.54.1506)\nVulnerability Writeup: [Sensepost.com](https://sensepost.com/blog/2020/being-stubborn-pays-off-pt.-2-tale-of-two-0days-on-prtg-network-monitor/)\n\n##### Remediation\nUpdate to version 19.4.54.1506 or newer by following the [vendor's documentation.](https://www.paessler.com/manuals/prtg/auto_update) Please consider enabling automatic updates for internet facing systems.",
                    "createdAt": "2022-02-08T08:42:44Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_51449",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-15846 - Exim SNI Unauthenticated Remote Command Execution Vulnerability",
                    "description": "##### Description\nThe SMTP Delivery process in Exim 4.92.1 has a Buffer Overflow, allowing unauthenticated remote attackers to execute arbitrary code as root. In the default runtime configuration, this is exploitable with crafted Server Name Indication (SNI) data during a TLS negotiation. In other configurations, it is exploitable with a crafted client TLS certificate.\n\nTo exploit the vulnerability the attacker needs a crafted client TLS certificate or a crafted SNI. While the first attack vector needs a non-default runtime configuration, the latter one should work with the default runtime config.\n\n##### Related Intelligence\n- CVE: [CVE-2019-15846](https://nvd.nist.gov/vuln/detail/CVE-2019-15846)\n- Security Advisory: [Exim.org](https://www.exim.org/static/doc/security/CVE-2019-15846.txt)\n- PoC: [GitHub](https://github.com/synacktiv/Exim-CVE-2019-15846)\n- Vulnerability Writeup: [Synacktiv](https://www.synacktiv.com/en/publications/scraps-of-notes-on-exploiting-exim-vulnerabilities.html)\n\n##### Remediation\nUpdate Exim to version 4.92.2 or higher by using the package manager included with your OS.",
                    "createdAt": "2023-01-11T07:16:30Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58345",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-28310 & CVE-2023-32031 - Microsoft Exchange Server Authenticated Remote Code Execution",
                    "description": "##### Description \nAn authenticated user can achieve remote code execution via a PowerShell remoting session.  This is similar to recent Exchange vulnerabilities that have public exploit code available and have been exploited in the wild. \n\n##### Related Intelligence\n- CVE: [CVE-2023-28310](https://nvd.nist.gov/vuln/detail/CVE-2023-28310)\n- CVE: [CVE-2023-32031](https://nvd.nist.gov/vuln/detail/CVE-2023-32031)\n- Security Advisory: [Microsoft](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-june-13-2023-kb5026261-c4abbd97-5afe-4229-9ecf-a0b7c0002a5d)\n\n##### Remediation \nMicrosoft recommends that organizations apply the June 2023 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU 13\n- Exchange 2019 CU 12\n- Exchange 2016 CU 23\n\nPlease see the [Microsoft Security Advisory](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-june-13-2023-kb5026261-c4abbd97-5afe-4229-9ecf-a0b7c0002a5d) for download links.",
                    "createdAt": "2023-06-19T03:50:47Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59424",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-18935 - Progress Telerik UI for ASP.NET AJAX Deserialization Vulnerability",
                    "description": "##### Description\n\nProgress Telerik UI for ASP.NET AJAX through 2019.3.1023 contains a .NET deserialization vulnerability in the RadAsyncUpload function. This is exploitable when the encryption keys are known due to the presence of CVE-2017-11317 or CVE-2017-11357, or other means. Exploitation can result in remote code execution. (As of 2020.1.114, a default setting prevents the exploit. In 2019.3.1023, but not earlier versions, a non-default setting can prevent exploitation.)\n\n##### Related Intelligence\n\nRiskIQ Vulnerability Intelligence: [CVE-2019-18935](https://nvd.nist.gov/vuln/detail/CVE-2019-18935) \nCVE: [CVE-2019-18935](https://nvd.nist.gov/vuln/detail/CVE-2019-18935)\nSecurity Advisory: [Progress Telerik Allows JavaScriptSerializer Deserialization](https://www.telerik.com/support/kb/aspnet-ajax/details/allows-javascriptserializer-deserialization)\nMetasploit Module: [Packet storm](https://packetstormsecurity.com/files/159653/Telerik-UI-ASP.NET-AJAX-RadAsyncUpload-Deserialization.html)\nPoC: [GitHub - CVE-2019-18935](https://github.com/noperator/CVE-2019-18935)\n\n##### Used By\n\n- [Blue Mockingbird](https://redcanary.com/blog/blue-mockingbird-cryptominer/)\n\n##### Remediation\n\nDue to the routine exploitation in the wild, organizations should immediately update their installed versions of Progress Telerik UI to the latest possible version. \n",
                    "createdAt": "2021-11-08T01:14:45Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_44978",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-33891 - Apache Spark Command Injection",
                    "description": "##### Description\nThe Apache Spark UI offers the possibility to enable ACLs via the configuration option spark.acls.enable. **If enabled**, a code path in HttpSecurityFilter can allow someone to perform impersonation by providing an arbitrary user name. An unauthenticated user is then able to pass in arbitrary shell commands and execute them with the same permissions as the Spark service account. If Spark ACLs are *not* enabled then the vulnerable code is not called and exploit attempts should fail.\n\nVersions Affected:\n-   3.0.3 and earlier\n-   3.1.1 to 3.1.2\n-   3.2.0 to 3.2.1\n\n##### Related Intelligence\nCVE: [CVE-2022-33891](https://nvd.nist.gov/vuln/detail/CVE-2022-33891)\nSecurity Advisory: [Apache Spark](https://spark.apache.org/security.html)\nPoC: [GitHub](https://github.com/HuskyHacks/cve-2022-33891)\n\n##### Remediation\nUpdate to Spark 3.1.3, 3.2.2, or 3.3.0 or later.\n\n*Workaround*\nIn the conf/spark-defaults.conf file set `spark.acls.enable false` to mitigate this vulnerability. This is the default value so it may already be set to false.\n\n*Indicator of Compromise*\nCheck web logs for requests to a URL containing `/?doAs=` with commands being passed in after the equal sign.\n- http://localhost:8080/?doAs=injected-command ",
                    "createdAt": "2022-07-28T09:38:59Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56260",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Command and Control Server Detected",
                    "description": "##### Description\nCommand and Control, also called C&C or C2, is a centralized server or computer that attackers use to issue commands to other systems in order to control malware and bots running on those systems, as well as to receive reports from them. It acts as an administration panel to one or more compromised systems. Common ways of communicating to a C2 server include HTTP, HTTPS, DNS, and ICMP. Many C2 systems can provide real-time, interactive shells to the attacker through the C2 server to the client.\n\nThis insight detects the server that sends commands to compromised client systems and it does not detect compromised clients. When a Command and Control web component has been detected, it indicates that system may have been compromised and is being used for nefarious purposes. Some corporate security teams have been known to purchase these tools for offensive security testing. \n\n##### Related Intelligence\n- Threat Intel: [Hunting Meterpreter](https://ti.defender.microsoft.com/articles/0682e78a)\n- Threat Intel: [Hunting Cobalt Strike](https://msrc-blog.microsoft.com/2022/10/13/hunting-for-cobalt-strike-mining-and-plotting-for-fun-and-profit/)\n- Threat Intel: [Fingerprinting Sliver](https://ti.defender.microsoft.com/articles/b1406335)\n- Threat Intel: [Bumblebee](https://ti.defender.microsoft.com/articles/0b211905/)\n- Threat Intel: [Trickbot](https://www.microsoft.com/en-us/security/blog/2022/03/16/uncovering-trickbots-use-of-iot-devices-in-command-and-control-infrastructure/)\n- Threat Intel: [Fingerprinting Brute Ratel C4](https://ti.defender.microsoft.com/articles/f2563c0d)\n- Threat Intel: [ViperJS](https://ti.defender.microsoft.com/articles/f3179571)\n\n##### Remediation\nWork with the system administrator responsible for the host and begin incident response practices immediately. Other systems communicating with this host may be compromised and under its control. To see which tools was detected, view the components detected on each asset from this Insight.",
                    "createdAt": "2022-12-05T08:00:35Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58184",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-21529 - Microsoft Exchange Server Authenticated Remote Code Execution",
                    "description": "##### Description \nMultiple vulnerabilities were addressed in the February 2023 monthly patch. There are few public details at this time, but an authenticated user can exploit these vulnerabilities to execute code in the context of the SYSTEM user. It is likely that one of the companies who responsibly disclosed a vulnerability will release additional details in the near future, and that may lead to public exploitation.\n\n##### Related Intelligence\n- CVE: [CVE-2023-21529](https://nvd.nist.gov/vuln/detail/CVE-2023-21529)\n- CVE: [CVE-2023-21706](https://nvd.nist.gov/vuln/detail/CVE-2023-21706)\n- CVE: [CVE-2023-21707](https://nvd.nist.gov/vuln/detail/CVE-2023-21707)\n- CVE: [CVE-2023-21710](https://nvd.nist.gov/vuln/detail/CVE-2023-21710)\n- Security Advisory: [Microsoft Security Advisory](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-february-14-2023-kb5023038-2e60d338-dda3-46ed-aed1-4a8bbee87d23)\n- Vuln Intel: [Starlabs_sg](https://twitter.com/starlabs_sg/status/1626132758367174656)\n- Vuln Intel: [Zero Day Initiative](https://www.zerodayinitiative.com/advisories/ZDI-23-162/)\n\n##### Remediation \nMicrosoft recommends that organizations apply the February 2023 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU 12\n- Exchange 2019 CU 11\n- Exchange 2016 CU 23\n- Exchange 2013 CU 23\n\nPlease see the [Microsoft Security Advisory](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-february-14-2023-kb5023038-2e60d338-dda3-46ed-aed1-4a8bbee87d23) for download links.",
                    "createdAt": "2023-03-02T04:02:04Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58673",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2017-9833 BOA Webserver Directory Traversal Vulnerability",
                    "description": "##### Description\nIt was found that BOA Webserver 0.94.14rc21 allows for unauthenticated directory traversal vulnerability with elevated privileges. Unauthenticated attackers can issue HTTP GET requests via the FILECAMERA variable to any file of their choosing.\n\nWhile this vulnerability has been assigned a CVSS score 7.5 by NIST, it is important to note that attackers could potentially retrieve file data which could lead to a breach of the running system. Multiple public PoCs have been released for CVE-2017-9833, making exploitation trivial.\n\n##### Related Intelligence\nCVE: [CVE-2017-9833](https://nvd.nist.gov/vuln/detail/CVE-2017-9833)\nPoC: [Exploit-DB](https://www.exploit-db.com/exploits/42290)\n\n##### Remediation\nAs Boa is largely integrated with firmware on embedded devices and on a wide variety of systems, administrators may need to contact vendors or view product download pages for a potential firmware update. ",
                    "createdAt": "2022-11-08T05:11:01Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57958",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "ASI: CVE-2023-22515 - Confluence Privilege Escalation",
                    "description": "##### Description\n\nAtlassian has been made aware of an issue reported by a handful of customers where external attackers may have exploited a previously unknown vulnerability in publicly accessible Confluence Data Center and Server instances to create unauthorized Confluence administrator accounts and access Confluence instances. Atlassian Cloud sites are not affected by this vulnerability. If your Confluence site is accessed via an atlassian.net domain, it is hosted by Atlassian and is not vulnerable to this issue. Confluence versions under 8.0 are not affected by this vulnerability.\n\nThe following versions of Confluence are considered vulnerable:\n\n- 8.0.0\n- 8.0.1\n- 8.0.2\n- 8.0.3\n- 8.1.0\n- 8.1.3\n- 8.1.4\n- 8.2.0\n- 8.2.1\n- 8.2.2\n- 8.2.3\n- 8.3.0\n- 8.3.1\n- 8.3.2\n- 8.4.0\n- 8.4.1\n- 8.4.2\n- 8.5.0\n- 8.5.1\n\nIt is worth noting that his vulnerability has been observed as exploited in the wild. Per Atlassian, \"Atlassian has been made aware of an issue reported by a handful of customers where external attackers may have exploited a previously unknown vulnerability in publicly accessible Confluence Data Center and Server instances to create unauthorized Confluence administrator accounts and access Confluence instances.\"\n\n##### Related Intelligence\n\n- CVE: [CVE-2023-22515](https://ti.defender.microsoft.com/cves/CVE-2023-22515)\n- Confluence FAQ: [CVE-2023-22515](https://confluence.atlassian.com/kb/faq-for-cve-2023-22515-1295682188.html)\n- Security Advisory: [Atlassian Security Advisory](https://confluence.atlassian.com/security/cve-2023-22515-privilege-escalation-vulnerability-in-confluence-data-center-and-server-1295682276.html)\n\n##### Remediation\n\nConfluence administrators should immediately update to one of the available patched versions: \n\n- 8.3.3 or later\n- 8.4.3 or later\n- 8.5.2 or later\n\nAtlassian has released a temporary workaround for instances that cannot be upgraded. Users can mitigate known attack vectors for this vulnerability by blocking access to the `/setup/*` endpoints on Confluence instances. This is possible at the network layer or by making the following changes to Confluence configuration files.\n\nOn each node, modify `/<confluence-install-dir>/confluence/WEB-INF/web.xml` and add the following block of code (just before the `</web-app>` tag at the end of the file):\n\n```\n<security-constraint>\n     <web-resource-collection>\n       <url-pattern>/setup/*</url-pattern>\n\t   <http-method-omission>*</http-method-omission>\n\t</web-resource-collection>\n   <auth-constraint />\n</security-constraint>\n```\n\nThe mitigation prevents any Confluence administrators from triggering Confluence setup actions, this includes setting up Confluence from scratch or migrating to and from Data Center. If these actions are required you will need to remove these lines from the web.xml file. Please re-add these lines if you are not running a fixed version of Confluence.",
                    "createdAt": "2023-10-05T03:15:20Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59822",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-9315 Oracle iPlanet Web Server 7.0.x has Incorrect Access Control",
                    "description": "##### Description \nOracle iPlanet Web Server 7.0.x has Incorrect Access Control for admingui/version URIs in the Administration console, as demonstrated by unauthenticated read access to encryption keys.\n\n##### Related Intelligence\nCVE: [CVE-2020-9315](https://nvd.nist.gov/vuln/detail/CVE-2020-9315)\n\n##### Remediation\nOracle iPlanet Web Server (v7.0.x) is considered End of Life (EOL), there is no plan to support nor distribute a patch for this vulnerability.",
                    "createdAt": "2021-02-19T04:52:02Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29427",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-4577 - PHP for Windows CGI Argument Injection",
                    "description": "##### Description\nPHP on Windows contains an argument injection vulnerability within the CGI module used by Apache web servers to run PHP code. When Unicode characters get converted to ASCII, PHP performs a best fit mapping and converts a special Unicode dash (0xAD) into an ASCII dash (0x2D). Apache escapes the dangerous 0x2D character, but not 0xAD. A malicious user is able to inject commands that are executed by PHP and run in the context of the web server. This has been patched in recent versions of PHP so that PHP no longer maps this value to a hyphen used by command line arguments.\n\nSo far, It is only believed to impact Windows systems and only those with the CGI module enabled. A PoC has been released and ransomware campaigns have been observed exploiting this in the wild.\n\nVulnerable Versions:\n- PHP 8.3.x before 8.3.8\n- PHP 8.2.x before 8.2.20\n- PHP 8.1.x before 8.1.29\n\n##### Related Intelligence\n- CVE: [CVE-2024-4577](https://security.microsoft.com/vulnerabilities/vulnerability/CVE-2024-4577/overview)\n- Security Advisory: [PHP Security Advisory](https://github.com/php/php-src/security/advisories/GHSA-3qgc-jrrr-25jv)\n- Vulnerability Writeup: [Devcore](https://devco.re/blog/2024/06/06/security-alert-cve-2024-4577-php-cgi-argument-injection-vulnerability-en/)\n- PoC: [WatchTowr](https://labs.watchtowr.com/no-way-php-strikes-again-cve-2024-4577/)\n- Threat Intel: [Cyble](https://cyble.com/blog/cve-2024-4577-ongoing-exploitation-of-a-critical-php-vulnerability/)\n\n##### Remediation\nDownload the latest version of [PHP](https://www.php.net/downloads) and install the latest supported version for your release. This vulnerability was fixed in the following versions:\n- 8.3.8\n- 8.2.20\n- 8.1.29",
                    "createdAt": "2024-06-18T06:17:30Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60217",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "REvil Ransomware Actors Exploit Kaseya VSA Software in Broad Supply Chain Attack",
                    "description": "##### Description \nOn July 2, 2021, IT management software company Kaseya announced that malicious actors were leveraging an unknown vulnerability in their VSA remote monitoring and management software to deliver Ransomware to customer organizations.  The attack vector has been identified and Kaseya is working on mitigating it.  \n\n##### Related Intelligence\nSecurity Advisories: \n\n[Kaseya Security Advisory](https://helpdesk.kaseya.com/hc/en-gb/articles/4403440684689)\n\n[DHS CISA - FBI Advisory](https://us-cert.cisa.gov/ncas/current-activity/2021/07/04/cisa-fbi-guidance-msps-and-their-customers-affected-kaseya-vsa)\n\n##### Used By\nREvil Ransomware Group\n\n##### Remediation\nKeseya strongly recommends that their on-premises customers’ VSA servers remain offline until further notice.",
                    "createdAt": "2021-07-03T06:22:15Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_40685",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-2884 - GitLab Authenticated Code Execution from Import API",
                    "description": "##### Description\nA critical vulnerability in GitLab CE/EE affecting all versions starting from 11.3.4 before 15.1.5, all versions starting from 15.2 before 15.2.3, all versions starting from 15.3 before 15.3.1 allows an an authenticated user to achieve remote code execution via the Import from GitHub API endpoint. This was reported by [yvvdwf](https://hackerone.com/yvvdwf) through the HackerOne bug bounty program.\n\n##### Related Intelligence\nCVE: [CVE-2022-2884](https://nvd.nist.gov/vuln/detail/CVE-2022-2884)\nSecurity Advisory: [GitLab](https://about.gitlab.com/releases/2022/08/22/critical-security-release-gitlab-15-3-1-released/#Remote%20Command%20Execution%20via%20Github%20import)\n\n##### Remediation\nFollow [GitLab's directions](https://about.gitlab.com/update/) for upgrading to the latest version based on your deployment method. \n\n*Workaround -Disable GitHub import*\nLogin using an administrator account to your GitLab installation and perform the following:\n1.  Click \"Menu\" -> \"Admin\".\n2.  Click \"Settings\" -> \"General\".\n3.  Expand the \"Visibility and access controls\" tab.\n4.  Under \"Import sources\" disable the \"GitHub\" option.\n5.  Click \"Save changes\".",
                    "createdAt": "2022-08-26T07:53:08Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56821",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "ASI: CVE-2023-42115 - Exim Unauthenticated Remote Code Execution",
                    "description": "##### Description\n\nThe developers behind Exim have issued an update which patches an unauthenticated remote code execution. The specific flaw exists within the SMTP service, which listens on TCP port 25 by default. The issue results from the lack of proper validation of user-supplied data, which can result in a write past the end of a buffer. An attacker can leverage this vulnerability to execute code in the context of the service account.\n\nThe Exim team also patched several other vulnerabilities, including:\n\n- CVE-2023-42114 - Exim NTLM Challenge Out-Of-Bounds Read Information Disclosure Vulnerability\n- CVE-2023-42116 - Exim SMTP Challenge Stack-based Buffer Overflow Remote Code Execution Vulnerability\n\nAs of October 2, 2023, the EXIM team has not implemented fixes for the following reported vulnerabilities:\n\n- CVE-2023-42117 - Exim Improper Neutralization of Special Elements Remote Code Execution Vulnerability\n- CVE-2023-42118 - Exim libspf2 Integer Underflow Remote Code Execution Vulnerability\n- CVE-2023-42119 - Exim dnsdb Out-Of-Bounds Read Information Disclosure Vulnerability\n\n##### Related Intelligence\n\n- CVE: [CVE-2023-42115](https://nvd.nist.gov/vuln/detail/CVE-2023-42115)\n- CVE: [CVE-2023-42114](https://nvd.nist.gov/vuln/detail/CVE-2023-42114)\n- CVE: [CVE-2023-42116](https://nvd.nist.gov/vuln/detail/CVE-2023-42116)\n- CVE: [CVE-2023-42117](https://nvd.nist.gov/vuln/detail/CVE-2023-42117)\n- CVE: [CVE-2023-42118](https://nvd.nist.gov/vuln/detail/CVE-2023-42118)\n- CVE: [CVE-2023-42119](https://nvd.nist.gov/vuln/detail/CVE-2023-42119)\n- Security Advisory: [Exim Security Advisory](https://www.exim.org/static/doc/security/CVE-2023-zdi.txt)\n\n##### Remediation\nExim users should upgrade to the latest versions available, 4.96.1 or 4.97. It is worth noting that all versions prior to 4.96.1 are considered obsolete. \n\n",
                    "createdAt": "2023-10-02T07:01:33Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59815",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-24706 - CouchDB Remote Privilege Escalation",
                    "description": "##### Description\nAn attacker can access an improperly secured default installation without authenticating and gain admin privileges due to a default cookie value of monster for the Erlang port mapper daemon (EPMD) port. The EPMD service is only used for multi-node installs for node communication and installations that do not expose this distribution port to external access are not vulnerable.\n\nIt is believed that remote code execution is possible with this vulnerablity, and that mass exploitation may begin soon. Block the EPMD port 4369 with a firewall as soon as possible and apply upgrades when you can.\n\nCouchDB [3.2.2](https://docs.couchdb.org/en/stable/whatsnew/3.2.html#release-3-2-2) and onwards will refuse to start with the former default erlang cookie value of monster. Installations that upgrade to this versions are forced to choose a different value. In addition, all binary packages have been updated to bind epmd as well as the CouchDB distribution port to 127.0.0.1 and/or ::1 respectively.\n\n##### Related Intelligence\nCVE: [CVE-2022-24706](https://nvd.nist.gov/vuln/detail/CVE-2022-24706)\nSecurity Advisory: [CouchDB.org](https://docs.couchdb.org/en/stable/cve/2022-24706.html)\nPoC: [GitHub](https://github.com/sadshade/CVE-2022-24706-CouchDB-Exploit)\n\n##### Remediation\nUpgrading depends on the method used to install CouchDB. Linux systems can use the OS package manager, snap users can use snap, Docker users can get a new container, and Windows users can reinstall from the vendor website. It's recommended to backup your data and fully read the [vendor's upgrade guide](https://docs.couchdb.org/en/3.2.0/install/upgrading.html) before performing the upgrade.\n\nA temporary mitigation is to place the CouchDB system behind a firewall and to block the EPMD port 4369 TCP for all non 127.0.0.1 loopback networks. It is also recommended to block all other non-essential ports inbound. Changing the EPMD cookie value may be another temporary mitigation if firewalling is not possible.",
                    "createdAt": "2022-05-26T07:51:46Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_54503",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Microsoft Exchange Arbitrary Command Execution via Vulnerability Chaining (ProxyShell)",
                    "description": "##### Description\n\nDuring Pwn2Own 2021--and as demonstrated during Black Hat USA--researchers discovered that by chaining several vulnerabilities within Microsoft Exchange they could achieve unauthenticated arbitrary command execution, dubbed ProxyShell. Specifically, by leveraging path confusion, privilege escalation, and post-authentication arbitrary file write vulnerabilities, the researchers successfully obtained the ability to remotely run arbitrary commands on affected Exchange systems. It is worth noting that several PoC exploits have been published and active ProxyShell scanning has been reported within the broader security community. \n\n##### Related Intelligence\nCVE: [CVE-2021-34473](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-34473),  [CVE-2021-34523](https://nvd.nist.gov/vuln/detail/CVE-2021-34523), [CVE-2021-31207](https://nvd.nist.gov/vuln/detail/CVE-2021-34473)\n\nMicrosoft Update Description: [KB5001779](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-april-13-2021-kb5001779-8e08f3b3-fc7b-466c-bbb7-5d5aa16ef064)\n\nTechnical Exploit Writeup: [FROM PWN2OWN 2021: A NEW ATTACK SURFACE ON MICROSOFT EXCHANGE - PROXYSHELL!](https://www.zerodayinitiative.com/blog/2021/8/17/from-pwn2own-2021-a-new-attack-surface-on-microsoft-exchange-proxyshell)\n\nPoCs: [Github - Metasploit ProxyShell](https://github.com/rapid7/metasploit-framework/blob/master/modules/exploits/windows/http/exchange_proxyshell_rce.rb), [Github - ProxyShell-PoC](https://github.com/dmaasland/proxyshell-poc.git)\n\n##### Remediation\n\nMicrosoft recommends that organizations apply the April 2021 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU9\n- Exchange 2019 CU8\n- Exchange 2016 CU 20\n- Exchange 2016 CU 19\n- Exchange 2013 CU 23\n\nOrganizations not running one of the supported versions for the May 2021 security update must upgrade to a supported version above and then apply the update.\n",
                    "createdAt": "2021-08-19T07:49:10Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_42199",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-25135 - vBulletin Unauthenticated Arbitrary Code Execution of Unserialized Data",
                    "description": "##### Description\nvBulletin before 5.6.9 PL1 allows an unauthenticated remote attacker to execute arbitrary code via a crafted HTTP request that triggers deserialization. This occurs because verify_serialized checks that a value is serialized by calling unserialize and then checking for errors. The fixed versions are 5.6.7 PL1, 5.6.8 PL1, and 5.6.9 PL1. \n\nThis has public exploit code available and has been exploited in the wild.  \n\n##### Related Intelligence\n- CVE: [CVE-2023-25135](https://nvd.nist.gov/vuln/detail/CVE-2023-25135)\n- Security Advisory: [vBulletin Forum](https://forum.vbulletin.com/forum/vbulletin-announcements/vbulletin-announcements_aa/4473890-vbulletin-5-6-9-security-patch)\n- Vulnerability Writeup and Exploit: [Ambionics](https://www.ambionics.io/blog/vbulletin-unserializable-but-unreachable)\n- PoC Exploit [Ambionics GitHub](https://github.com/ambionics/vbulletin-exploits/blob/main/vbulletin-rce-cve-2023-25135.py)\n\n##### Remediation\nFollow the instructions from the [vBulletin announcement](https://forum.vbulletin.com/forum/vbulletin-announcements/vbulletin-announcements_aa/4473890-vbulletin-5-6-9-security-patch) to download and apply updated files. Since the PL1 fix can appear to still be vulnerable to many scanners, we recommend to update to version 5.7.0 or higher.",
                    "createdAt": "2023-04-20T02:17:35Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59225",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "VMware Identity Manager Unauthenticated Remote Code Execution Vulnerabilities",
                    "description": "##### Description\nCVE-2022-22954: VMware Workspace ONE Access and Identity Manager contain an unauthenticated remote code execution vulnerability due to server-side template injection. This is under active exploitation and should be addressed immediately.\n\nCVE-2022-22957 and CVE-2022-22958: VMware Workspace ONE Access, Identity Manager and vRealize Automation contain two remote code execution vulnerabilities. A malicious actor with administrative access can trigger deserialization of untrusted data through malicious JDBC URI which may result in remote code execution.\n\nCVE-2022-22959: VMware Workspace ONE Access, Identity Manager and vRealize Automation contain a cross site request forgery vulnerability. A malicious actor can trick a user through a cross site request forgery to unintentionally validate a malicious JDBC URI.\n\nCVE-2022-22960: VMware Workspace ONE Access, Identity Manager and vRealize Automation contain a privilege escalation vulnerability due to improper permissions in support scripts, and a malicious actor with local access can escalate privileges to root.\n\n##### Related Intelligence\nCVE: [CVE-2022-22954](https://nvd.nist.gov/vuln/detail/CVE-2022-22954)\nSecurity Advisory: [VMware VMSA-2022-0011](https://www.vmware.com/security/advisories/VMSA-2022-0011.html)\nThreat Intel: [Twitter @bad_packets](https://twitter.com/bad_packets/status/1514293472697585669)\nPoC: [GitHub SherlockSecurity](https://github.com/sherlocksecurity/VMware-CVE-2022-22954)\nPoC: [GitHub Chocapikk](https://github.com/Chocapikk/CVE-2022-22954)\nCISA Alert: [cisa.gov](https://www.cisa.gov/uscert/ncas/current-activity/2022/05/18/cisa-issues-emergency-directive-and-releases-advisory-related)\n\n##### Remediation\nPlease see the VMware Hotfix Download Locations table within their [KB 88099](https://kb.vmware.com/s/article/88099) article for a list of vulnerable versions, the associated patches, and installation instructions.\n\n*Workaround instructions* - from VMware article [KB 88098](https://kb.vmware.com/s/article/88098)\n1.  Login as sshuser and sudo to root level access\n2.  Download the [_HW-154129-applyWorkaround.py_](https://vmware-gs.my.salesforce.com/sfc/p/f40000003u6t/a/5G0000002Nla/9COLfZG7uu8iDjLoZTis5Ltzmd1H87iToXs9uLZF8IU) script to the virtual appliance and run it\n3.  Run the Python script using this command:\n\t`python3 HW-154129-applyWorkaround.py`",
                    "createdAt": "2022-04-19T04:10:57Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_53423",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Telnet Service Exposure",
                    "description": "##### Description\nDevices with Telnet exposed to the internet increase an organization's attack surface. Telnet is unencrypted and any remote logins will transmit their credentials in clear text. These credentials can be read by any network device in the middle of the client and server. Telnet has been replaced by newer protocols like SSH.\n\n##### Related Intelligence\n- Best Practices: [CISA](https://www.cisa.gov/news-events/news/securing-network-infrastructure-devices)\n- Threat Intel: [CSO Online - Mirai botnet](https://www.csoonline.com/article/3258748/the-mirai-botnet-explained-how-teen-scammers-and-cctv-cameras-almost-brought-down-the-internet.html)\n- Threat Intel: [Dark Reading - HEH botnet](https://www.darkreading.com/vulnerabilities-threats/new-heh-botnet-targets-exposed-telnet-services)\n\n##### Remediation\nTelnet should never be accessible on the internet.  Log into the device using an encrypted or secure connection and disable the telnet service. Make sure there is another method of access such as SSH, and place that behind a VPN or local network connection if possible.",
                    "createdAt": "2023-01-06T04:17:06Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58315",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-31198 Microsoft Exchange Remote Code Execution Vulnerability",
                    "description": "##### Description \nA remote code execution vulnerability exists in Microsoft Exchange Server.  Successful exploitation of this vulnerability would require a user to take action before the vulnerability can be exploited.  Microsoft has not released any further details surrounding the vulnerability.\n\n##### Related Intelligence\nCVE: [CVE-2021-31198](https://nvd.nist.gov/vuln/detail/CVE-2021-31198)\n\nSecurity Advisory: [Microsoft Security Advisory](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2021-31198)\n\n##### Remediation\nMicrosoft recommends that organizations apply the May 2021 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU9\n- Exchange 2019 CU8\n- Exchange 2016 CU 20\n- Exchange 2016 CU 19\n- Exchange 2013 CU 23\n\nOrganizations not running one of the supported versions for the May 2021 security update must upgrade to a supported version above and then apply the update.- ",
                    "createdAt": "2021-05-11T10:11:57Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_38430",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-22205 - GitLab Image Validation Remote Code Execution",
                    "description": "##### Description\n\nAn issue has been discovered in GitLab CE/EE affecting all versions starting from 11.9 to 13.8.8, 13.9 to 13.9.6, and 13.10 to 13.10.3. GitLab was not properly validating image files that is passed to a file parser which resulted in a remote command execution. This is due to a vulnerability in the Exiftool component used by GitLab.  This has been seen being exploited in the wild.\n\n##### Related Intelligence\n\nCVE: [CVE-2021-22205](https://nvd.nist.gov/vuln/detail/CVE-2021-22205)\nSecurity Advisory: [GitLab](https://about.gitlab.com/releases/2021/04/14/security-release-gitlab-13-10-3-released/#Remote-code-execution-when-uploading-specially-crafted-image-files)\nBug Bounty: [HackerOne](https://hackerone.com/reports/1154542)\nVulnerability Writeup: [Conviso](https://blog.convisoappsec.com/en/a-case-study-on-cve-2021-22204-exiftool-rce/)\nMetasploit Module: [exploit/multi/http/gitlab_exif_rce](https://www.rapid7.com/db/modules/exploit/multi/http/gitlab_exif_rce/)\n\n##### Remediation\n\nFollow [GitLab's directions](https://about.gitlab.com/update/) for upgrading to the latest version based on your deployment method. Once upgraded we recommend looking for unexpected GitLab admin accounts and changed admin settings.  Initially, this vulnerability was thought to only impact authenticated users.  A best practice is to disable self-registration of new users and to put your GitLab instance behind a VPN, Azure Application Gateway, or other similar protections.",
                    "createdAt": "2021-11-10T08:35:27Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_45051",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "DNSpooq - dnsmasq Cache Poisoning and Buffer Overflow Vulnerabilities",
                    "description": "##### Description\nOn January 19, 2021, JSOF researchers disclosed multiple vulnerabilities within dnsmasq, dubbed DNSpooq. Specifically, dnsmasq versions under 2.83 are susceptible to DNS Cache Poisoning  and buffer overflows. A CVSSv3 score of 8.1 has been assigned to DNSpooq and the US CISA has marked  the issue as requiring a low skill level to exploit by remote attackers.\n\n##### Related Intelligence\nRiskIQ Article: [DNSpooq: JSOF Researchers Discover Cache Poisoning and Buffer Overflows in dnsmasq](https://community.riskiq.com/article/ca98c704)\n\nCVEs: [CVE-2020-25681](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25681), [CVE-2020-25682](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25682), [CVE-2020-25683](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25683), [CVE-2020-25684](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25684), [CVE-2020-25685](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25685), [CVE-2020-25686](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25686), [CVE-2020-25687](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25687)\n\n##### Remediation\nIt is recommended that organizations upgrade to the latest stable version of dnsmasq (2.83) if possible.",
                    "createdAt": "2021-02-19T04:06:18Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29396",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-28871 Authorization Bypass and Remote Code Execution in Monitorr 1.7.6",
                    "description": "##### Description \nA Remote Code Execution (RCE) vulnerability in Monitorr v1.7.6m in upload.php allows for an unauthorized person to execute arbitrary code on the server-side via an insecure file upload.\n\n##### Related Intelligence\nCVE: [CVE-2020-28871](https://nvd.nist.gov/vuln/detail/CVE-2020-28871#vulnCurrentDescriptionTitle)\n\n##### Remediation\nMonitorr v.1.7.6m users should update to the latest version as soon as possible. Users should ensure that their software deletes the installation files right after the installation, does input sanitization and output encoding of user input, and checks file uploads properly.",
                    "createdAt": "2021-06-22T08:07:21Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_40246",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-22005 Microsoft SharePoint Chart Deserialization Remote Code Execution",
                    "description": "##### Description\nThis vulnerability allows authenticated remote attackers to execute arbitrary code on affected installations of Microsoft SharePoint Server. The specific flaw exists within the processing of charts and any user with the ability to create charts can exploit this. Tampering with client-side data can trigger the deserialization of untrusted data. An attacker can leverage this vulnerability to execute code in the context of the SharePoint web server process.\n\n##### Related Intelligence\nCVE: [CVE-2022-22005](https://nvd.nist.gov/vuln/detail/CVE-2022-22005) \nSecurity Advisory: [MSRC](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-22005)\nVulnerability Disclosure: [Zero Day Initiative](https://www.zerodayinitiative.com/advisories/ZDI-22-352/)\n\n##### Remediation\nMicrosoft recommends that organizations apply the Feb 2022 security update to impacted SharePoint Servers.  The security update is available for the following versions:\n\n- SharePoint Subscription Edition\n- SharePoint 2019\n- SharePoint 2016\n- SharePoint 2013 SP 1\n\nPlease see the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-22005) for a download links.",
                    "createdAt": "2022-03-01T08:10:26Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_51926",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-16278 - Nostromo Web Server (nhttpd) Remote Code Execution",
                    "description": "##### Description​\nNostromo, also known as nhttpd, is an open-source web server software vulnerable to remote code execution due to a directory path traversal vulnerability in the function http_verify. The vulnerability, which entails inadequate URL checks, allows unauthenticated actors to craft a HTTP POST request to exploit the vulnerability. The vulnerability was discovered in 2019, and continues to be under active exploitation.\n\n##### Related Intelligence​\n- CVE: [CVE-2019-16278](https://security.microsoft.com/intel-explorer/cves/CVE-2019-16278/)\n- ChangeLog Notes: [Developer: nazgul](https://www.nazgul.ch/dev/nostromo_cl.txt)​\n- PoC: [Exploit Database](https://www.exploit-db.com/exploits/47837)\n- Metasploit Module: [GitHub](https://github.com/rapid7/metasploit-framework/blob/master/modules/exploits/multi/http/nostromo_code_exec.rb) \n- Vulnerability Writeup: [GitHub](https://github.com/jas502n/CVE-2019-16278/)​\n\n##### Remediation​\nFollow the [developer's documentation to apply the latest version patch, 1.9.7 or higher, for Nostromo.](https://www.nazgul.ch/dev/)",
                    "createdAt": "2025-01-10T03:55:28Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_243580300",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-21972 Critical Unauthenticated RCE Vulnerability Patched in VMware vSphere",
                    "description": "##### Description \nThe vSphere Client (HTML5) contains a remote code execution vulnerability within the vCenter vROps (vRealize Operations) plugin.  A malicious actor with network access to port 443 may exploit this issue to execute commands with unrestricted privileges on the underlying operating system that hosts vCenter Server.\n\nVMware has indicated that the following product version are affected by CVE-2021-21972:\n- vCenter Server        7.0\n- vCenter Server        6.7\n- vCenter Server        6.5\n- Cloud Foundation (vCenter Server)        4.x\n- Cloud Foundation (vCenter Server)        3.x\n\n##### Related Intelligence\nRiskIQ Article: [CVE-2021-21972: Critical Unauthenticated RCE Vulnerability Patched in VMware vSphere](https://staging.community.riskiq.com/article/6949f941)\nCVE: [CVE-2021-21972](https://nvd.nist.gov/vuln/detail/CVE-2021-21972) \nSecurity Advisory: [VMware Security Advisory](https://www.vmware.com/security/advisories/VMSA-2021-0002.html)  \nPoC Code: [Github](https://github.com/NS-Sp4ce/CVE-2021-21972), [Github](https://github.com/QmF0c3UK/CVE-2021-21972-vCenter-6.5-7.0-RCE-POC), [Github](https://github.com/horizon3ai/CVE-2021-21972)\n\n##### Remediation\nOrganizations are strongly encouraged to investigate their running version of vCenter Server. If possible, it is recommended to implement VMware's released software updates. If updates cannot be immediately applied, VMware has released the following workaround for CVE-2021-21972:\n[VMware Knowledge Base](https://kb.vmware.com/s/article/82374)",
                    "createdAt": "2021-03-02T03:46:41Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29885",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-11202 - Rancher hard coded credentials",
                    "description": "##### Description\n\nAn issue was discovered that affects the following versions of Rancher: v2.0.0 through v2.0.13, v2.1.0 through v2.1.8, and v2.2.0 through 2.2.1. When Rancher starts for the first time, it creates a default admin user with a well-known password. After initial setup, the Rancher administrator may choose to delete this default admin user. If Rancher is restarted, the default admin user will be recreated with the well-known default password. An attacker could exploit this by logging in with the default admin credentials. This can be mitigated by deactivating the default admin user rather than completing deleting them.\n\n##### Related Intelligence\n\nCVE: [CVE-2019-11202](https://nvd.nist.gov/vuln/detail/CVE-2019-11202) \nSecurity Advisory: [Rancher Announcement](https://forums.rancher.com/t/rancher-release-v2-1-9-addresses-rancher-cve-2019-11202/14059)\n\n##### Remediation\n\nRancher supports both upgrade and rollback starting with v2.0.2. Please note the version you would like to [upgrade](https://rancher.com/docs/rancher/v2.x/en/upgrades/) or [rollback](https://rancher.com/docs/rancher/v2.x/en/backups/rollbacks/) to change the Rancher version.\n\nDue to the HA improvements introduced in the v2.1.0 release, the Rancher helm chart is the only supported method for installing or upgrading Rancher. Please use the Rancher helm chart to install HA Rancher. For details, see the [HA Install - Installation Outline](https://rancher.com/docs/rancher/v2.x/en/installation/ha/#installation-outline).\n",
                    "createdAt": "2021-09-24T01:40:06Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_43329",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-17638 Jenkins Server Vulnerability May Lead to Sensitive Data Leak",
                    "description": "##### Description \nA remote unauthenticated attacker could view HTTP response headers containing sensitive data. The vulnerability is within the underlying Jetty (v9.4.27) server, which is bundled within several Jenkins builds.​ CVE-2019-17638 has been issued for the underlying Jetty vulnerability.\n\n##### Related Intelligence\nRiskIQ Article: [Jenkins Server Vulnerability May Lead to Sensitive Data Leak](https://community.riskiq.com/article/af77a475)\nCVE: [CVE-2019-17638](https://nvd.nist.gov/vuln/detail/CVE-2019-17638) \nSecurity Advisory: [Jenkins Security Advisory](https://www.jenkins.io/security/advisory/2020-08-17/)\n\n##### Remediation\nUpgrade to the appropriate patched version:\n- Jenkins weekly should be updated to version 2.243\n- Jenkins LTS should be updated to version 2.235.5",
                    "createdAt": "2021-02-19T04:49:16Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29411",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-23277 Microsoft Exchange Server Remote Code Execution Vulnerability",
                    "description": "##### Description \nA remote code execution vulnerability exists in Microsoft Exchange Server. As an authenticated user, the attacker could attempt to trigger malicious code in the context of the server's account through a network call.\n\n##### Related Intelligence\nCVE: [CVE-2022-23277](https://nvd.nist.gov/vuln/detail/CVE-2022-23277) \nSecurity Advisory: [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-23277)\n\n##### Remediation\nMicrosoft recommends that organizations apply the March 2022 security update to impacted Exchange Servers. The security update is available for the following versions:\n\n- Exchange 2013 CU 23\n- Exchange 2016 CU 21\n- Exchange 2016 CU 22\n- Exchange 2019 CU 10\n- Exchange 2019 CU 11\n\nPlease see the Security Updates section of the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-26427) page for download links.",
                    "createdAt": "2022-03-25T08:39:23Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_52678",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-30781 - Gitea Command Injection in git fetch remote",
                    "description": "##### Description\nGitea before 1.16.7 does not escape git fetch remote which can lead to a remote command execution on the system. A malicious attacker can supply arguments to the ```git remote add``` and ```git fetch``` commands to inject arbitrary shell commands.\n\n##### Related Intelligence\nCVE: [CVE-2022-33891](https://nvd.nist.gov/vuln/detail/CVE-2022-33891)\nSecurity Advisory: [Gitea](https://blog.gitea.io/2022/05/gitea-1.16.7-is-released/)\nVulnerability Writeup: [E99p1ant](https://tttang.com/archive/1607/)\nPoC: [GitHub](https://github.com/wuhan005/CVE-2022-30781)\nPoC: [Metasploit](https://packetstormsecurity.com/files/168400/Gitea-1.16.6-Remote-Code-Execution.html)\n\n##### Remediation\nUpdate to Gitea 1.16.8 or later by following the [vendor's instructions](https://docs.gitea.io/en-us/upgrade-from-gitea/) for your chosen method of installation.",
                    "createdAt": "2022-09-19T04:06:05Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57165",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-39361 - Cacti SQL Injection in Graph_View.php",
                    "description": "##### Description\nA SQL injection vulnerability was discovered in graph_view.php for Cacti version 1.2.24 and below. The vulnerable page allows a remote attacker to exploit this vulnerability to gain admin privileges and remote code execution. After SQLi exploitation, it is possible to achieve remote code execution by altering the 'path_php_binary' value in the database.\n\nSystems created using version prior to 0.8.7 have a guest user that by default does not need to provide authentication to view the graph_view.php page. By default in 0.8.7 and later, the \"guest\" user is not enabled, effectively disabling \"guest\" (Unauthenticated) access to Cacti.\n\nA proof of concept for the SQLi was released with the security advisory. Cacti has been targeted previously in [widespread exploitations of CVE-2022-46169](https://www.bleepingcomputer.com/news/security/hackers-exploit-cacti-critical-bug-to-install-malware-open-reverse-shells/) and it is possible that this SQLi vulnerability will be targeted in the near future.\n\n##### Related Intelligence\n- CVE: [CVE-2023-39361](https://nvd.nist.gov/vuln/detail/CVE-2023-39361)\n- Security Advisory and PoC: [Cacti GHSA](https://github.com/Cacti/cacti/security/advisories/GHSA-6r43-q2fw-5wrg)\n\n##### Remediation\nThis is fixed in Cacti 1.2.25 and Cacti 1.3. Upgrade to one of these versions or higher to address the vulnerability. For instances of 1.2.x running under PHP < 7.0, a further change [a8d59e8](https://github.com/Cacti/cacti/commit/a8d59e8fa5f0054aa9c6981b1cbe30ef0e2a0ec9) is also required. To upgrade Cacti, follow these steps from the [vendor](https://github.com/Cacti/documentation/blob/develop/Upgrading-Cacti.md).\n\nDisabling the guest account prevents unauthenticated attacks and may reduce risk exposure for future vulnerabilities. Please see the [vendor's documentation](https://docs.cacti.net/User-Management.md) on how to check for guest users and disable them.",
                    "createdAt": "2023-09-14T08:21:01Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59792",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Oct 2024 Multiple LiteSpeed Cache WordPress Plugin Vulnerabilities",
                    "description": "##### Description\n**CVE-2024-44000:** A critical unauthenticated account takeover vulnerability in LiteSpeed Cache, which allows unauthenticated users to gain authentication access to user accounts by exploiting a HTTP response headers leak on the debug log file. This vulnerability affects versions before 6.5.0.1.\n\n**CVE-2024-50550:** A rare case of unauthenticated privilege escalation vulnerability in LiteSpeed Cache, which allows unauthenticated users to gain administrator-level access by exploiting a weak security hash check used in the plugin's user simulation feature. This vulnerability affects versions before 6.5.2 and only affects those who have a very specific Crawler configuration. For more detail, please refer to [LiteSpeed's security advisory](https://blog.litespeedtech.com/2024/10/29/crawler-patch-for-wordpress-cache-plugin/).\n\n**CVE-2024-47374:** An unauthenticated stored cross-site scripting (XSS) vulnerability in LiteSpeed Cache, which allows unauthenticated users to steal sensitive information or perform privilege escalation by a single HTTP request. This vulnerability affects versions before 6.5.1.\n\n**CVE-2024-28000:** A critical unauthenticated privilege escalation vulnerability in LiteSpeed Cache, which allows unauthenticated users to gain administrator-level access by exploiting a weak security hash in the plugin's user simulation feature. This vulnerability affects versions before 6.4.\n\n##### Related Intelligence\n- CVE: [CVE-2024-44000](https://security.microsoft.com/intel-explorer/cves/CVE-2024-44000/) \n- CVE: [CVE-2024-50550](https://security.microsoft.com/intel-explorer/cves/CVE-2024-50550/) \n- CVE: [CVE-2024-47374](https://security.microsoft.com/intel-explorer/cves/CVE-2024-47374/)\n- CVE: [CVE-2024-28000](https://security.microsoft.com/intel-explorer/cves/CVE-2024-28000/)\n- Security Advisory (CVE-2024-50550): [LiteSpeed](https://blog.litespeedtech.com/2024/10/29/crawler-patch-for-wordpress-cache-plugin/)\n- Vulnerability Writeup and PoC (CVE-2024-44000): [Patchstack](https://patchstack.com/articles/critical-account-takeover-vulnerability-patched-in-litespeed-cache-plugin/)\n- Vulnerability Writeup and PoC (CVE-2024-50550): [Patchstack](https://patchstack.com/articles/rare-case-of-privilege-escalation-patched-in-litespeed-cache-plugin/)\n- Vulnerability Writeup and PoC (CVE-2024-47374): [Patchstack](https://patchstack.com/articles/unauthenticated-stored-xss-vulnerability-in-litespeed-cache-plugin-affecting-6-million-sites/)\n- Vulnerability Writeup and PoC (CVE-2024-28000): [Patchstack](https://patchstack.com/articles/critical-privilege-escalation-in-litespeed-cache-plugin-affecting-5-million-sites?_s_id=cve)\n- Vulnerability Writeup (CVE-2024-47374): [Ostorlab](https://blog.ostorlab.co/litespeed-cache,cve-2024-47374.html)\n- PoC (CVE-2024-44000): [Github](https://github.com/absholi7ly/CVE-2024-44000-LiteSpeed-Cache)\n- PoC (CVE-2024-44000): [Github](https://github.com/geniuszly/CVE-2024-44000)\n- PoC (CVE-2024-28000): [Github](https://github.com/ebrasha/CVE-2024-28000)\n\n##### Remediation\nFollow the vendor's [documentation](https://wordpress.org/plugins/litespeed-cache/#installation) to upgrade LiteSpeed Cache to version 6.5.2 or higher.",
                    "createdAt": "2025-03-04T08:19:39Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250630200",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-3236 - Sophos XG Firewall Remote Code Execution",
                    "description": "##### Description\nA code injection vulnerability allowing remote code execution was discovered in the User Portal and Webadmin of Sophos Firewall v19.0 MR1 (19.0.1) and older. Sophos has observed this vulnerability being exploited to target a small set of specific organizations, primarily in the South Asia region. They have informed each of these organizations directly. Sophos will provide further details as they continue to investigate.\n\n##### Related Intelligence\nCVE: [CVE-2022-3236](https://nvd.nist.gov/vuln/detail/CVE-2022-3236)\nSecurity Advisory: [Sophos](https://www.sophos.com/en-us/security-advisories/sophos-sa-20220923-sfos-rce)\n\n##### Remediation\nNo action is required for Sophos Firewall customers with the \"Allow automatic installation of hotfixes\" feature enabled on remediated versions. The setting is enabled by default.\n\nFrom your Sophos XG advanced shell run this command to check for, download, and install the latest updates:\n`./scripts/u2d/u2d_get_dr.sh`\n\nIf automatic hotfix installation is disabled, follow [these instructions from Sophos](https://support.sophos.com/support/s/article/KB-000043853?language=en_US) to re-enable it. Use the commands from that article to confirm the hotfix was applied. Once automatic hotfix installation is enabled the firewall checks for hotfixes every thirty minutes and after any restart.\n\n*Workaround*\nDisable WAN access to the User Portal and Webadmin by following [device access best practices](https://docs.sophos.com/nsg/sophos-firewall/18.5/Help/en-us/webhelp/onlinehelp/AdministratorHelp/Administration/DeviceAccess/index.html \"https://docs.sophos.com/nsg/sophos-firewall/18.5/Help/en-us/webhelp/onlinehelp/AdministratorHelp/Administration/DeviceAccess/index.html\") and instead use VPN and/or Sophos Central for remote access and management.",
                    "createdAt": "2022-09-23T04:23:27Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57279",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "VMware vRealize Automation Unauthenticated Remote Code Execution Vulnerabilities",
                    "description": "##### Description\nCVE-2022-22957 and CVE-2022-22958: VMware Workspace ONE Access, Identity Manager and vRealize Automation contain two remote code execution vulnerabilities. A malicious actor with administrative access can trigger deserialization of untrusted data through malicious JDBC URI which may result in remote code execution.\n\nCVE-2022-22959: VMware Workspace ONE Access, Identity Manager and vRealize Automation contain a cross site request forgery vulnerability. A malicious actor can trick a user through a cross site request forgery to unintentionally validate a malicious JDBC URI.\n\nCVE-2022-22960: VMware Workspace ONE Access, Identity Manager and vRealize Automation contain a privilege escalation vulnerability due to improper permissions in support scripts, and a malicious actor with local access can escalate privileges to root.\n\n##### Related Intelligence\nCVE: [CVE-2022-22957](https://nvd.nist.gov/vuln/detail/CVE-2022-22957)\nSecurity Advisory: [VMware VMSA-2022-0011](https://www.vmware.com/security/advisories/VMSA-2022-0011.html)\nCISA Alert: [cisa.gov](https://www.cisa.gov/uscert/ncas/current-activity/2022/05/18/cisa-issues-emergency-directive-and-releases-advisory-related)\n\n##### Remediation\nPlease see the VMware Hotfix Download Locations table within their [KB 88099](https://kb.vmware.com/s/article/88099) article for a list of vulnerable versions, the associated patches, and installation instructions.\n\n*Workaround instructions* - from VMware article [KB 88098](https://kb.vmware.com/s/article/88098)\n1.  Login as sshuser and sudo to root level access\n2.  Download the [_HW-154129-applyWorkaround.py_](https://vmware-gs.my.salesforce.com/sfc/p/f40000003u6t/a/5G0000002Nla/9COLfZG7uu8iDjLoZTis5Ltzmd1H87iToXs9uLZF8IU) script to the virtual appliance and run it\n3.  Run the Python script using this command:\n\t`python3 HW-154129-applyWorkaround.py`",
                    "createdAt": "2022-04-19T04:11:16Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_53424",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-28995 - Solarwinds Serv-U Path Traversal Enables Sensitive File Read",
                    "description": "##### Description\nSolarWinds Serv-U 15.4.2 HotFix 1 (version 15.4.2.126) and prior was susceptible to a directory transversal vulnerability that would allow access to read sensitive files on the host machine. The path-traversal filter only checks the appropriate slashes for the platform which is`/` on Linux and `` on Windows. After passing the path-traversal filter an incorrect slash is corrected by the system, allowing a file path traversal to take place.  This was corrected in Serv-U version 15.4.2 HotFix 2 (version 15.4.2.157). PoC code is available as this is very easy to exploit, and it has been observed exploited in the wild.\n\n##### Related Intelligence\n- CVE: [CVE-2024-28995](https://security.microsoft.com/intel-explorer/cves/CVE-2024-28995/description)\n- Security Advisory: [Solarwinds Trust Center](https://www.solarwinds.com/trust-center/security-advisories/cve-2024-28995)\n- Vulnerability Writeup: [Rapid7's AttackerKB](https://attackerkb.com/topics/2k7UrkHyl3/cve-2024-28995/rapid7-analysis)\n- Threat Intel: [Greynoise](https://www.labs.greynoise.io/grimoire/2024-06-solarwinds-serv-u/)\n- Metasploit Module: [auxiliary/gather/solarwinds_servu_fileread_cve_2024_28995](https://github.com/rapid7/metasploit-framework/blob/master/modules/auxiliary/gather/solarwinds_servu_fileread_cve_2024_28995.rb)\n\n##### Remediation\nFor installation instructions and how to apply the hotfix, please refer to [this link](https://support.solarwinds.com/SuccessCenter/s/article/Serv-U-15-4-2-Hotfix-2-Release-Notes) in order to upgrade your system to version 15.4.2 HotFix 2, also seen as 15.4.2.157.",
                    "createdAt": "2024-07-10T03:02:19Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60228",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "SMBv1 Service Exposure",
                    "description": "The original SMB1 protocol is nearly 30 years old , and like much of the software made in the 80’s, it was designed for a world that no longer exists. A world without malicious actors, without vast sets of important data, without near-universal computer usage. See the following link for reasons why you should not use SMBv1 along with ways to disable it.\n\n[Stop Using SMBv1](https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858)",
                    "createdAt": "2021-03-16T10:28:38Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_19991",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-36537 - ZK Framework Unauthenticated Local File Retrieval Vulnerability",
                    "description": "##### Description\nZK AuUploader servlets contains a security vulnerability which can be exploited to retrieve the content of a file located in the web context. This includes files normally hidden from the user located in WEB-INF, such as web.xml, zk.xml, etc. In the unsecure versions, an attacker may send a forged request to the /zkau/upload endpoint. If the forged request contains the nextURI parameter, the AuUploader will try to forward the request internally, and output the document found if any into the response.\n\nSince this is an internal forward, it can access documents located in restricted WEB-INF folder, which exposes internal files such as web.xml, zk.xml and other files located in this directory.\n\n##### Related Intelligence\n- CVE: [CVE-2022-36537](https://nvd.nist.gov/vuln/detail/CVE-2022-36537)\n- Security Bulletin: [ZK-5150](https://tracker.zkoss.org/browse/ZK-5150)\n- Technical Analysis: [Numen Cyber Labs](https://medium.com/numen-cyber-labs/cve-2022-36537-vulnerability-technical-analysis-with-exp-667401766746)\n- PoC: [GitHub](https://github.com/numencyber/Vulnerability_PoC/tree/main/CVE-2022-36537)\n\n##### Remediation\nZKOSS has released several patches for this vulnerability in the following versions: \n\n* 9.6.2\n* 9.6.0.2 (security release)\n* 9.5.1.4 (security release)\n* 9.0.1.3 (security release)\n* 8.6.4.2 (security release)\n\nIf patches cannot be applied, the ZK Security Bulletin [ZK-5150](https://tracker.zkoss.org/browse/ZK-5150) contains workarounds for corresponding versions. \n",
                    "createdAt": "2023-04-20T07:14:03Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59226",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-22527 - Atlassian Confluence Unauthenticated OGNL Injection",
                    "description": "##### Description\nAn OGNL template injection vulnerability on Confluence Data Center and Server allows an unauthenticated attacker to achieve remote code execution on 8.x versions released before Dec. 5, 2023. A malicious HTTP POST request to the /template/aui/text-inline.vm URI with a specially crafted body allows command injection. A Confluence server spawning a command line process such as bash or cmd.exe strongly indicates a compromised system.\n\nThis has been observed exploited in the wild and should be remediated immediately.\n\n##### Related Intelligence\nCVE: [CVE-2023-22527](https://ti.defender.microsoft.com/cves/CVE-2023-22527)\nSecurity Advisory: [Atlassian](https://confluence.atlassian.com/security/cve-2023-22527-rce-remote-code-execution-vulnerability-in-confluence-data-center-and-confluence-server-1333990257.html)\nFAQ: [Atlassian](https://confluence.atlassian.com/kb/faq-for-cve-2023-22527-1332810917.html)\nVulnerability Writeup: [ProjectDiscovery](https://blog.projectdiscovery.io/atlassian-confluence-ssti-remote-code-execution/)\nPoC: [Martin Hsu](https://twitter.com/_0xf4n9x_/status/1749377689545294113)\n\n##### Remediation\nUpgrade to the following versions or newer to address this vulnerability. \n- 8.5.5 LTS\n- 8.7.2 (Data Center Only)\n\nDownload the latest Confluence version from the [Confluence Download Archives](https://www.atlassian.com/software/confluence/download-archives) and follow the upgrade steps provide by [Confluence Support](https://confluence.atlassian.com/doc/upgrading-confluence-4578.html) to remediate this vulnerability.  ",
                    "createdAt": "2024-01-23T07:45:13Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60039",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-1040 Sophos XG Firewall Remote Code Execution",
                    "description": "##### Description\nAn authentication bypass vulnerability allowing remote code execution was discovered in the User Portal and Webadmin of Sophos Firewall and responsibly disclosed to Sophos. It was reported via the Sophos bug bounty program by an external security researcher.\n\nThere is no action required for Sophos Firewall customers with the \"Allow automatic installation of hotfixes\" feature enabled. Enabled is the default setting. Vulnerability applies to Sophos Firewall v18.5 MR3 (18.5.3) and older.\n\nSophos has observed this vulnerability being used to target a small set of specific organizations primarily in the South Asia region. We have informed each of these organizations directly. \n\n##### Related Intelligence\nCVE: [CVE-2022-1040](https://nvd.nist.gov/vuln/detail/CVE-2022-1040)\nSecurity Advisory: [Sophos](https://www.sophos.com/en-us/security-advisories/sophos-sa-20220325-sfos-rce)\nThreat Intel: [Volexity](https://www.volexity.com/blog/2022/06/15/driftingcloud-zero-day-sophos-firewall-exploitation-and-an-insidious-breach/)\nPoC: [GitHub](https://github.com/CronUp/Vulnerabilidades/blob/main/CVE-2022-1040_checker)\nPoC and Writeup: [Viettel Blog](https://blog.viettelcybersecurity.com/cve-2022-1040-sophos-xg-firewall-authentication-bypass/)\nThreat Intel: [Recorded Future](https://www.recordedfuture.com/chinese-state-sponsored-group-ta413-adopts-new-capabilities-in-pursuit-of-tibetan-targets)\n\n##### Remediation\nFrom your Sophos XG advanced shell run this command to check for, download, and install the latest updates:\n`./scripts/u2d/u2d_get_dr.sh`\n\nIf automatic hotfix installation was disabled, follow [these instructions from Sophos](https://support.sophos.com/support/s/article/KB-000043853?language=en_US) to re-enable it. Use the commands from that article to confirm the hotfix was applied. Once automatic hotfix installation is enabled the firewall checks for hotfixes every thirty minutes and after any restart.\n\n*Workaround*\nDisable WAN access to the User Portal and Webadmin by following [device access best practices](https://docs.sophos.com/nsg/sophos-firewall/18.5/Help/en-us/webhelp/onlinehelp/AdministratorHelp/Administration/DeviceAccess/index.html \"https://docs.sophos.com/nsg/sophos-firewall/18.5/Help/en-us/webhelp/onlinehelp/AdministratorHelp/Administration/DeviceAccess/index.html\") and instead use VPN and/or Sophos Central for remote access and management.",
                    "createdAt": "2022-04-22T07:41:53Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_53487",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-6340 - Drupal Remote Code Execution of REST API",
                    "description": "##### Description\n\nSome field types do not properly sanitize data from non-form sources in Drupal 8.5.x before 8.5.11 and Drupal 8.6.x before 8.6.10. This can lead to arbitrary PHP code execution in some cases. \n\n**A site is only affected by this if ONE of the following conditions is met**:\n-   The site has the Drupal 8 core RESTful Web Services (rest) module enabled and allows GET, PATCH or POST requests. **OR**\n-   The site has another web services module enabled, like [JSON:API](https://www.drupal.org/project/jsonapi) in Drupal 8, or [Services](https://www.drupal.org/project/services) or [RESTful Web Services](https://www.drupal.org/project/restws) in Drupal 7.\n\n##### Related Intelligence\n\nCVE: [CVE-2019-6340](https://nvd.nist.gov/vuln/detail/CVE-2019-6340) \nSecurity Advisory: [SA-CORE-2019-003](https://www.drupal.org/sa-core-2019-003)\nPoC Exploits: [Exploit-DB](https://www.exploit-db.com/exploits/46452/)\n[Exploit-DB](https://www.exploit-db.com/exploits/46459/)\n[Metasploit](https://www.exploit-db.com/exploits/46510/)\n\n##### Remediation\n\nDownload the latest Confluence version as per the above Security Advisory via the [Confluence Download Archives](https://www.atlassian.com/software/confluence/download-archives) and follow the upgrade steps provide by [Confluence Support](https://confluence.atlassian.com/doc/upgrading-confluence-4578.html) to remediate this vulnerability.",
                    "createdAt": "2021-12-08T08:13:41Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_46232",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-22515 - Confluence Privilege Escalation",
                    "description": "##### Description\n\nAtlassian has been made aware of an issue reported by a handful of customers where external attackers may have exploited a previously unknown vulnerability in publicly accessible Confluence Data Center and Server instances to create unauthorized Confluence administrator accounts and access Confluence instances. Atlassian Cloud sites are not affected by this vulnerability. If your Confluence site is accessed via an atlassian.net domain, it is hosted by Atlassian and is not vulnerable to this issue. Confluence versions under 8.0 are not affected by this vulnerability.\n\nThe following versions of Confluence are considered vulnerable:\n\n- 8.0.0\n- 8.0.1\n- 8.0.2\n- 8.0.3\n- 8.1.0\n- 8.1.3\n- 8.1.4\n- 8.2.0\n- 8.2.1\n- 8.2.2\n- 8.2.3\n- 8.3.0\n- 8.3.1\n- 8.3.2\n- 8.4.0\n- 8.4.1\n- 8.4.2\n- 8.5.0\n- 8.5.1\n\nIt is worth noting that his vulnerability has been observed as exploited in the wild. Per Atlassian, \"Atlassian has been made aware of an issue reported by a handful of customers where external attackers may have exploited a previously unknown vulnerability in publicly accessible Confluence Data Center and Server instances to create unauthorized Confluence administrator accounts and access Confluence instances.\"\n\n##### Related Intelligence\n\n- CVE: [CVE-2023-22515](https://ti.defender.microsoft.com/cves/CVE-2023-22515)\n- Confluence FAQ: [CVE-2023-22515](https://confluence.atlassian.com/kb/faq-for-cve-2023-22515-1295682188.html)\n- Security Advisory: [Atlassian Security Advisory](https://confluence.atlassian.com/security/cve-2023-22515-privilege-escalation-vulnerability-in-confluence-data-center-and-server-1295682276.html)\n- Vulnerability Writeup: [AttackerKB](https://attackerkb.com/topics/Q5f0ItSzw5/cve-2023-22515/rapid7-analysis)\n\n##### Remediation\n\nConfluence administrators should immediately update to one of the available patched versions: \n\n- 8.3.3 or later\n- 8.4.3 or later\n- 8.5.2 or later\n\nDownload the latest Confluence version from the [Confluence Download Archives](https://www.atlassian.com/software/confluence/download-archives) and follow the upgrade steps provide by [Confluence Support](https://confluence.atlassian.com/doc/upgrading-confluence-4578.html) to remediate this vulnerability.\n\nAtlassian has released a temporary workaround for instances that cannot be upgraded. Users can mitigate known attack vectors for this vulnerability by blocking access to the `/setup/*` endpoints on Confluence instances. This is possible at the network layer or by making the following changes to Confluence configuration files.\n\nOn each node, modify `/<confluence-install-dir>/confluence/WEB-INF/web.xml` and add the following block of code (just before the `</web-app>` tag at the end of the file):\n\n```\n<security-constraint>\n     <web-resource-collection>\n       <url-pattern>/setup/*</url-pattern>\n\t   <http-method-omission>*</http-method-omission>\n\t</web-resource-collection>\n   <auth-constraint />\n</security-constraint>\n```\n\nThe mitigation prevents any Confluence administrators from triggering Confluence setup actions, this includes setting up Confluence from scratch or migrating to and from Data Center. If these actions are required you will need to remove these lines from the web.xml file. Please re-add these lines if you are not running a fixed version of Confluence.",
                    "createdAt": "2024-08-01T09:07:34Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60233",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "ASI: CVE-2023–38646 Metabase Unauthenticated Command Execution",
                    "description": "##### Description\nMetabase open source before 0.46.6.1 and Metabase Enterprise before 1.46.6.1 allow attackers to execute arbitrary commands on the server, at the server's privilege level. Authentication is not required for exploitation. The other fixed versions are 0.45.4.1, 1.45.4.1, 0.44.7.1, 1.44.7.1, 0.43.7.2, and 1.43.7.2. This has been observed to be exploited in the wild.\n\nAccording to Metabase this vulnerability allows attackers to do the following:\n1. Call `/api/session/properties` to get the setup token.\n2. Use the setup token to call `/api/setup/validate`.\n3. Take advantage of the missing checks to get H2 to execute commands on the host operating system.\n4. Open a reverse shell, create admin accounts, etc.\n\n##### Related Intelligence\n- CVE: [CVE-2023–38646](https://community.riskiq.com/cve-article/CVE-2023–38646/description)\n- Security Advisory: [Metabase.com](https://www.metabase.com/blog/security-advisory)\n- Post-Mortem Incident Summary: [Metabase.com](https://www.metabase.com/blog/security-incident-summary)\n- Vulnerability Writeup: [Assetnote.io](https://blog.assetnote.io/2023/07/22/pre-auth-rce-metabase/)\n- Vulnerability Writeup: [Shamooo](https://infosecwriteups.com/cve-2023-38646-metabase-pre-auth-rce-866220684396)\n- PoC: [GitHub](https://github.com/shamo0/CVE-2023-38646-PoC)\n\n##### Remediation\nUpdate Metabase to release (0.46.6.1 or 1.46.6.1), or any subsequent release after that. Vendor instructions on how to update can be found [here](https://www.metabase.com/docs/latest/installation-and-operation/upgrading-metabase).",
                    "createdAt": "2023-09-22T02:50:52Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59797",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-0604 - Microsoft SharePoint Remote Code Execution Vulnerability",
                    "description": "##### Description\nA remote code execution vulnerability exists in Microsoft SharePoint when the software fails to check the source markup of an application package. Specifically, an XML serialized payload can be sent to an affected system, where it will be executed within the SharePoint application pool context; leading to a full system compromise. It is also worth noting that this vulnerability has been--and is being--exploited in the wild. \n\n##### Related Intelligence\nCVE: [CVE-2019-0604](https://ti.defender.microsoft.com/cves/CVE-2019-0604)\nTechnical Writeup: [The ZDI - CVE-2019-0604](https://www.zerodayinitiative.com/blog/2019/3/13/cve-2019-0604-details-of-a-microsoft-sharepoint-rce-vulnerability)\nPublic PoC: [Github - CVE-2019-0604](https://github.com/k8gege/CVE-2019-0604)\nExploitation in the Wild: [Microsoft investigates Iranian attacks against the Albanian government](https://www.microsoft.com/security/blog/2022/09/08/microsoft-investigates-iranian-attacks-against-the-albanian-government/)\n\n##### Remediation\nSystem administrators should immediately update affected systems to the latest available SharePoint version.\n",
                    "createdAt": "2022-09-12T05:42:36Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57038",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-23917 - TeamCity Critical Auth Bypass",
                    "description": "##### Description\nA new critical security vulnerability, first identified on January 19, 2024, has been discovered in TeamCity On-Premises. If abused, the flaw may enable an unauthenticated attacker with HTTP(S) access to a TeamCity server to bypass authentication checks and gain administrative control of that TeamCity server. \n\nAll versions of TeamCity On-Premises from 2017.1 through 2023.11.2 are affected by this critical security vulnerability. To resolve this issue update your servers to 2023.11.3 or higher.\n\n##### Related Intelligence\n- CVE: [CVE-2024-23917](https://ti.defender.microsoft.com/cves/CVE-2024-23917/)\n- Security Advisory: [JetBrains TeamCity Blog](https://blog.jetbrains.com/teamcity/2024/02/critical-security-issue-affecting-teamcity-on-premises-cve-2024-23917/)\n\n##### Remediation\nTo update your server, [download the latest version](https://www.jetbrains.com/teamcity/download/other.html) (2023.11.3) or use the [automatic update](https://www.jetbrains.com/help/teamcity/upgrading-teamcity-server-and-agents.html#Automatic+Update) option within TeamCity.\n\nIf you are unable to update your server to version 2023.11.3, JetBrains have also released a security patch plugin so that you can still patch your environment. The security patch plugin can be downloaded using the link below and installed on TeamCity versions 2017.1 through 2023.11.2. It will patch the vulnerability described above.\n\nSecurity patch plugin: [TeamCity 2018.2+](https://download.jetbrains.com/teamcity/plugins/internal/fix_CVE_2024_23917.zip) | [TeamCity 2017.1, 2017.2, and 2018.1](https://download.jetbrains.com/teamcity/plugins/internal/fix_CVE_2024_23917_pre2018_2.zip)\n\nSee the [TeamCity plugin installation instructions](https://www.jetbrains.com/help/teamcity/installing-additional-plugins.html#Installing+Plugin+via+Web+UI) for information on installing the plugin.",
                    "createdAt": "2024-02-27T03:35:16Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60130",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-20021 - SonicWall Email Security Pre-Authentication Admin Account Creation Vulnerability",
                    "description": "##### Description \nA vulnerability in SonicWall Email Security version 10.0.9.x allows an attacker to create an administrative account by sending a crafted HTTP request to the remote host. The affected products are SonicWall On-premise Email Security (ES) 10.0.9 and earlier versions, and Hosted Email Security (HES) 10.0.9 and earlier versions.\n​\n##### Related Intelligence\nCVE: [CVE-2021-20021](https://nvd.nist.gov/vuln/detail/CVE-2021-20021)\nSecurity Advisory: [SonicWall Security Advisory](https://psirt.global.sonicwall.com/vuln-detail/SNWLID-2021-0007)\nMandiant Threat Research: [Zero-Day Exploits in SonicWall Email Security Lead to Enterprise Compromise](https://www.fireeye.com/blog/threat-research/2021/04/zero-day-exploits-in-sonicwall-email-security-lead-to-compromise.html)\nMS-ISAC Advisory: [Vulnerabilities in SonicWall Email Security](https://www.cisecurity.org/advisory/multiple-vulnerabilities-in-sonicwall-email-security-could-allow-for-arbitrary-code-execution_2021-055/)\n​\n##### Remediation\nSonicWall advises that On-premise Email Security Windows users should upgrade to 10.0.9.6103 and Appliance users should upgrade to 10.0.9.6105. Hotfix is available for download on mysonicwall.com. Hosted Email Security (HES) users are automatically upgraded to Hotfix 10.0.9.6103, and no action is required.",
                    "createdAt": "2021-04-14T09:48:00Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_35639",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-41038 - Microsoft SharePoint Server Authenticated Remote Code Execution Via Manage List",
                    "description": "##### Description\nA vulnerability in SharePoint Server allows an authenticated attacker with Manage List permissions could execute code remotely on the SharePoint Server.  An attacker with access to low-privilege credentials can leverage this vulnerability to execute code in the context of Administrator. This security update also improves the least-privileged configuration of the SharePoint farm service account in Microsoft SQL Server in SharePoint.\n\n##### Related Intelligence\n- CVE: [CVE-2022-38053](https://nvd.nist.gov/vuln/detail/CVE-2022-38053)\n- CVE: [CVE-2022-41036](https://nvd.nist.gov/vuln/detail/CVE-2022-41036)\n- CVE: [CVE-2022-41037](https://nvd.nist.gov/vuln/detail/CVE-2022-41037)\n- CVE: [CVE-2022-41038](https://nvd.nist.gov/vuln/detail/CVE-2022-41038)\n- Security Advisory: [MSRC](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-41038)\n\n##### Remediation\nMicrosoft recommends that organizations apply the October 2022 security update to impacted SharePoint Servers.  The security update is available for the following versions:\n\n- SharePoint Subscription Edition\n- SharePoint 2019\n- SharePoint 2016\n- SharePoint 2013 SP 1\n\nPlease see the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-41038) for a download links.",
                    "createdAt": "2022-10-13T02:29:48Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57559",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2019-10149 - Exim Command Execution Vulnerability",
                    "description": "##### Description\nA command execution vulnerability introduced in Exim version 4.87 allows a local attacker to execute commands as the root user by sending mail to a specially crafted mail address on localhost that will be interpreted by the expand_string function within the deliver_message() function. \n\nFor some non-default configurations remote exploitation is possible. For example, if the requirement for ‘verify = recipient’ ACL was removed from the [the default configuration](https://www.exim.org/exim-html-current/doc/html/spec_html/ch-the_default_configuration_file.html) file, or uncommenting out the ‘local_part_suffix under the userforward router in the default configuration, or if Exim was “configured to relay mail to a remote domain, as a secondary MX (Mail eXchange).”\n\n##### Related Intelligence\n- CVE: [CVE-2019-10149](https://nvd.nist.gov/vuln/detail/CVE-2019-10149)\n- Security Advisory: [Exim.org](https://www.exim.org/static/doc/security/CVE-2019-10149.txt)\n- Initial Disclosure: [Qualys](https://www.qualys.com/2019/06/05/cve-2019-10149/return-wizard-rce-exim.txt)\n- PoC: [GitHub](https://github.com/dhn/exploits/tree/master/CVE-2019-10149)\n- Metasploit module: [Rapid7](https://www.rapid7.com/db/modules/exploit/linux/local/exim4_deliver_message_priv_esc/)\n- Threat Intel: [NSA Sandworm Exploitation](https://media.defense.gov/2020/May/28/2002306626/-1/-1/0/CSA-Sandworm-Actors-Exploiting-Vulnerability-in-Exim-Transfer-Agent-20200528.pdf)\n\n##### Remediation\nUpdate Exim to version 4.92 or higher by using the package manager included with your OS.",
                    "createdAt": "2023-01-11T07:15:56Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58344",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-1301 SMBLost Remote Code Execution Vulnerability in SMBv1",
                    "description": "##### Description \nA Remote Code Execution (RCE) vulnerability in Microsoft Server Message Block version 1.0 (SMBv1) could allow an authenticated attacker to exploit the vulnerability by sending a specially crafted packet to the targeted server.\n\n##### Related Intelligence\nCVE: [CVE-2020-1301](https://nvd.nist.gov/vuln/detail/CVE-2020-1301) \nSecurity Advisory: [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2020-1301)\n\n##### Remediation\nApply the appropriate security patch or disable SMBv1",
                    "createdAt": "2021-02-19T04:50:06Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29416",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-12720 - vBulletin SQL Injection Leads to Remote Code Execution",
                    "description": "##### Description\n\nvBulletin before 5.5.6pl1, 5.6.0 before 5.6.0pl1, and 5.6.1 before 5.6.1pl1 has incorrect access control. By accessing the \"/ajax/api/content_infraction/getIndexableContent\" path, an external attacker can issue arbitrary SQL statements and obtain remote code execution. \n\n##### Related Intelligence\n\nCVE: [CVE-2020-12720](https://nvd.nist.gov/vuln/detail/CVE-2020-12720)\n\nSecurity Advisory: [vBulletin Announcement](https://forum.vbulletin.com/forum/vbulletin-announcements/vbulletin-announcements_aa/4445227-vbulletin-5-6-0-5-6-1-5-6-2-security-patch)\n\nPublic PoC: [Metasploit Pull Request](https://github.com/rapid7/metasploit-framework/pull/13512)\n\n##### Remediation\n\nOrganizations using vBulletin should ensure that they upgrade to the latest available [patch](https://members.vbulletin.com/patches.php)\n",
                    "createdAt": "2021-08-13T04:06:57Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_41994",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "ASI: CVE-2022-1329 - Elementor Page Builder Plugin for WordPress File Upload and Execution",
                    "description": "##### Description\nThe Elementor Website Builder plugin for WordPress is vulnerable to unauthorized execution of several AJAX actions due to a missing capability check in the ~/core/app/modules/onboarding/module.php file that make it possible for attackers to modify site data in addition to uploading malicious files that can be used to obtain remote code execution, in versions 3.6.0 to 3.6.2.\n\n##### Related Intelligence\nCVE: [CVE-2022-1329](https://nvd.nist.gov/vuln/detail/CVE-2022-1329)\nInitial Disclosure and PoC: [PluginVulnerabilities](https://www.pluginvulnerabilities.com/2022/04/12/5-million-install-wordpress-plugin-elementor-contains-authenticated-remote-code-execution-rce-vulnerability/)\n\n##### Remediation\nUpdate to version 3.6.3 or greater through the WordPress admin interface.",
                    "createdAt": "2022-08-05T10:00:50Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56359",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-46169 Cacti Unauthenticated Command Injection",
                    "description": "##### Description\nCacti version 1.2.22 and below has an unauthenticated command injection vulnerability which allows arbitrary remote code execution. The vulnerable file is remote_agent.php and it can be accessed without authentication. This vulnerability exists if a `poller_item` with the `action` type `POLLER_ACTION_SCRIPT_PHP` (`2`) is configured, which is commonly used in predefined templates like `Device - Uptime` or `Device - Polling Time`.\n\n##### Related Intelligence\n- CVE: [CVE-2022-46169](https://nvd.nist.gov/vuln/detail/CVE-2022-46169)\n- Security Advisory: [Cacti GHSA](https://github.com/Cacti/cacti/security/advisories/GHSA-6p93-p743-35gf)\n- PoC and Writeup: [GitHub](https://github.com/0xf4n9x/CVE-2022-46169)\n\n##### Remediation\nThis is fixed in Cacti 1.2.23 and Cacti 1.3. Upgrade to one of these versions or higher to address the vulnerability. For instances of 1.2.x running under PHP < 7.0, a further change [a8d59e8](https://github.com/Cacti/cacti/commit/a8d59e8fa5f0054aa9c6981b1cbe30ef0e2a0ec9) is also required. To upgrade Cacti, follow these steps from the [vendor](https://github.com/Cacti/documentation/blob/develop/Upgrading-Cacti.md).",
                    "createdAt": "2022-12-15T08:34:34Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58253",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-23897 - Jenkins Unauthenticated Arbitrary File Leakage",
                    "description": "##### Description\nJenkins has a built-in [command line interface (CLI)](https://www.jenkins.io/doc/book/managing/cli/) to access Jenkins from a script or shell environment and it can be reached over the Jenkins web server via HTTP requests.\n\nJenkins uses the [args4j library](https://github.com/kohsuke/args4j) to parse command arguments and options on the Jenkins controller when processing CLI commands. This command parser has a feature that replaces an `@` character followed by a file path in an argument with the file’s contents (`expandAtFiles`). This feature was enabled by default on vulnerable versions of Jenkins. It allows attackers to read arbitrary files on the Jenkins controller file system using the default character encoding of the Jenkins controller process.\n\n- Attackers with Overall/Read permission can read entire files.\n- Attackers **without** Overall/Read permission can read the first few lines of files. This includes files with stored credentials or SSH keys.\n\n##### Related Intelligence\n- CVE: [CVE-2024-23897](https://ti.defender.microsoft.com/cves/CVE-2024-23897/)\n- Security Advisory: [Jenkins 1/24](https://www.jenkins.io/security/advisory/2024-01-24/)\n- Vulnerability Writeup: [SonarSource](https://www.sonarsource.com/blog/excessive-expansion-uncovering-critical-security-vulnerabilities-in-jenkins/)\n- Vulnerability Writeup and PoC: [AttackerKB](https://attackerkb.com/topics/nGvoto1E9c/cve-2024-23897)\n- PoC: [GitHub](https://github.com/binganao/CVE-2024-23897/blob/main/poc.py)\n\n##### Remediation\n- Jenkins weekly should be updated/reinstalled to version [2.442](https://www.jenkins.io/doc/book/installing/)\n- Jenkins LTS should be updated to version [2.426.3](https://www.jenkins.io/doc/upgrade-guide/)\n\n**Workaround:**  \nDisabling access to the CLI is expected to prevent exploitation completely. Doing so is strongly recommended to administrators unable to immediately update to Jenkins 2.442, LTS 2.426.3. Applying this workaround does not require a Jenkins restart. For instructions, see the [documentation for this workaround](https://github.com/jenkinsci-cert/SECURITY-3314-3315/).",
                    "createdAt": "2024-02-06T06:11:05Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60095",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-45849 - Perforce Helix Core Unauthenticated Remote Code Execution over RPC",
                    "description": "##### Description\nWithin the RPC service of Perforce Helix Core an unauthenticated attacker can run arbitrary commands using the ```p4 bgtask```RPC call, possibly with superuser rights. This RPC service runs over TCP port 1666 by default and in vulnerable versions it does not properly check for authentication. Systems where the admin has not run ```p4 protect``` will treat all users as superusers thereby increasing the potency of this vulnerability. \n\n##### Related Intelligence\n- CVE: [CVE-2023-45849](https://ti.defender.microsoft.com/cves/CVE-2023-45849/)\n- Release Notes: [Perforce](https://www.perforce.com/perforce/doc.current/user/relnotes.txt)\n- Initial Disclosure: [Microsoft Security Blog](https://www.microsoft.com/en-us/security/blog/2023/12/15/patching-perforce-perforations-critical-rce-vulnerability-discovered-in-perforce-helix-core-server/)\n\n##### Remediation\nFollow the [Perforce Helix Core Admin Guide](https://www.perforce.com/manuals/p4sag/Content/P4SAG/chapter.upgrade.html) to upgrade to the latest version for your release. \n\nFixed versions include:\n- 2023.2 (2023.2/2519561) released on 2023/11/14\n- 2023.1 Patch 2 (2023.1/2513900) released on 2023/11/03\n\nAs a workaround or for system hardening admins can restrict access to the RPC service that by default runs on TCP port 1666. A system or network based firewall can be used to prevent access from untrusted networks. If remote access is needed please place Perforce behind an VPN. \n\nPerforce also recommends running [p4 protect](https://www.perforce.com/manuals/p4sag/Content/P4SAG/protections.when_to_set.html) immediately after installing Helix Server to enhance user permissions.",
                    "createdAt": "2023-12-14T03:45:26Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60011",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Hijacked NPM Package Version of ua-parser-js",
                    "description": "##### Description\n\nOn October 22, 2021, an advisory was created for the ua-parser-js NPM package, indicating that three versions of the package had been hijacked and published with malicious code. Users had noted that the malicious versions of the packages had attempted to download and execute malware from third-party sources. Per the advisory, \"Any computer that has this package installed or running should be considered fully compromised.\"\n\nThe affected versions of ua-parser-js are: \n\n- 0.7.29\n- 0.8.0\n- 1.0.0\n\n##### Related Intelligence\n\nCISA Alert: [CVE-2016-2569](https://us-cert.cisa.gov/ncas/current-activity/2021/10/22/malware-discovered-popular-npm-package-ua-parser-js)\nSecurity Advisory: [Embedded malware in ua-parser-js](https://github.com/advisories/GHSA-pjwm-rvh2-c87w)\nGitHub Security Issue: [Compromised npm packages of ua-parser-js](https://github.com/faisalman/ua-parser-js/issues/536)\n\n##### Remediation\n\nOrganizations impacted by this issue should immediately identify whether or not their systems have installed any of the affected versions. If affected versions are running on systems, organizations may need to invoke their incident response process to identify potential extent of system/environment compromise. The maintainers of ua-parser-js have released the following patched versions: \n\n- 0.7.30\n- 0.8.1\n- 1.0.1\n",
                    "createdAt": "2021-10-27T02:13:42Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_44538",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "GitLab Enterprise Edition SCIM Account Takeover and Stored Cross Site Scripting (XSS)",
                    "description": "##### Description\nCVE-2022-1680: An account takeover issue has been discovered in GitLab EE affecting all versions starting from 11.10 *before 14.9.5*, all versions starting from 14.10 *before 14.10.4*, all versions starting from 15.0 *before 15.0.1*. When group SAML SSO is configured, the SCIM feature (available only on Premium+ subscriptions) may allow any owner of a Premium group to invite arbitrary users through their username and email, then change those users' email addresses via SCIM to an attacker controlled email address and thus - in the absence of 2FA - take over those accounts. It is also possible for the attacker to change the display name and username of the targeted account. This vulnerability was discovered internally by a member of the GitLab team.\n\nCVE-2022-1940: A Stored Cross-Site Scripting vulnerability in Jira integration in GitLab EE affecting all versions from 13.11 prior to 14.9.5, 14.10 prior to 14.10.4, and 15.0 prior to 15.0.1 allows an attacker to execute arbitrary JavaScript code in GitLab on a victim's behalf via specially crafted Jira Issues.\n\n##### Related Intelligence\nCVE: [CVE-2022-1680](https://nvd.nist.gov/vuln/detail/CVE-2022-1680)\nCVE: [CVE-2022-1940](https://nvd.nist.gov/vuln/detail/CVE-2022-1940)\nSecurity Advisory: [GitLab](https://about.gitlab.com/releases/2022/06/01/critical-security-release-gitlab-15-0-1-released/)\n\n##### Remediation\nSelf-managed administrators can check whether `group_saml` is enabled by reviewing [\"Configuring Group SAML on a self-managed GitLab instance\"](https://docs.gitlab.com/ee/integration/saml.html#configuring-group-saml-on-a-self-managed-gitlab-instance).\n\nFollow [GitLab's directions](https://about.gitlab.com/update/) for upgrading to the latest version based on your deployment method. ",
                    "createdAt": "2022-06-10T03:19:25Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_55279",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-8620 ISC BIND 9 DDoS Vulnerability",
                    "description": "##### Description \nAn attacker who can establish a TCP connection with the server and send data on that connection can exploit this to trigger the assertion failure, causing the server to exit. \n\n##### Related Intelligence\nRiskIQ Article: [ISC Releases Patches Addressing Multiple Denial of Service Vulnerabilities in BIND 9](https://community.riskiq.com/article/4087d879) \nCVE: [CVE-2020-8620](https://nvd.nist.gov/vuln/detail/CVE-2020-8620) \nSecurity Advisory: [ISC Advisory](https://kb.isc.org/docs/cve-2020-8620) \n\n##### Remediation\nUpgrade to the patched release most closely related to your current version of BIND:\n- BIND 9.16.6\n- BIND 9.17.4",
                    "createdAt": "2021-02-19T04:48:06Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29406",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-2883 Vulnerability in the Oracle WebLogic Server product of Oracle Fusion Middleware",
                    "description": "##### Description \nEasily exploitable vulnerability that allows an unauthenticated attacker with network access via IIOP, T3 to compromise Oracle WebLogic Server. Successful exploitation of this vulnerability can result in takeover of the impacted Oracle WebLogic Server.\n\n##### Related Intelligence\nCVE: [CVE-2020-2883](https://nvd.nist.gov/vuln/detail/CVE-2020-2883)\nSecurity Advisory: [Oracle Security Alert](https://www.oracle.com/security-alerts/cpuapr2020.html) \n\n##### Remediation\nOracle advises organizations to immediately apply the April 2020 Critical Patch Update",
                    "createdAt": "2021-02-19T04:52:10Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29428",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2016-2569 - Squid Proxy Denial of Service Vulnerability",
                    "description": "##### Description\n\nSquid 3.x before 3.5.15 and 4.x before 4.0.7 does not properly append data to String objects, which allows remote servers to cause a denial of service (assertion failure and daemon exit) via a long string, as demonstrated by a crafted HTTP Vary header.\n\n##### Related Intelligence\n\nRiskIQ Vulnerability Intelligence: [CVE-2016-2569](https://nvd.nist.gov/vuln/detail/CVE-2016-2569)\nSecurity Advisory: [Squid Cache Vendor Advisory](http://www.squid-cache.org/Advisories/SQUID-2016_2.txt)\nPublic Analysis: [Github - CVE-2016-2569](https://github.com/amit-raut/CVE-2016-2569)\n\n##### Remediation\n\nOrganizations should ensure that they are running the latest Squid server version possible. The current stable version of Squid is version 5.2.",
                    "createdAt": "2021-10-19T04:03:03Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_44052",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Docker CVE-2019-5736 Container Escape",
                    "description": "##### Description\nDocker before 18.09.2 and other products allows attackers to overwrite the host runc binary (and consequently obtain host root access) by leveraging the ability to execute a command as root. This can be done with: (1) a new container with an attacker-controlled image, or (2) an existing container where the attacker has write access and can be attached with docker exec.\n\n##### Related Intelligence\nCVE: [CVE-2019-5736](https://nvd.nist.gov/vuln/detail/CVE-2019-5736)\nInitial Disclosure: [DragonSector](https://blog.dragonsector.pl/2019/02/cve-2019-5736-escape-from-docker-and.html)\nVulnerability Writeup: [Twistlock](https://unit42.paloaltonetworks.com/breaking-docker-via-runc-explaining-cve-2019-5736/)\nPoC: [GitHub](https://github.com/Frichetten/CVE-2019-5736-PoC)\n\n##### Remediation\nFor Linux systems upgrade Docker using your system's default package manager (such as apt, yum, dnf, etc). For all others, follow the [installation instructions](https://docs.docker.com/engine/install/) that matches your use case.",
                    "createdAt": "2022-07-01T04:54:32Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_55817",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-41277 Metabase Local File Inclusion",
                    "description": "##### Description\nMetabase versions x.40.0-x.40.4 contain a security issue with the custom GeoJSON map (`admin->settings->maps->custom maps->add a map`) support and potential local file inclusion. This allows an unauthenticated remote attacker to read local files with potentially confidential information such as /etc/ passwd or other app specific files.\n\n##### Related Intelligence\n- CVE: [CVE-2021-41277](https://nvd.nist.gov/vuln/detail/CVE-2021-41277)\n- Security Advisory: [GitHub GHSA](https://github.com/metabase/metabase/security/advisories/GHSA-w73v-6p7p-fpfr)\n- Vulnerability Writeup: [Can1337](https://infosecwriteups.com/tackling-cve-2021-41277-using-a-vulnerability-database-5e960b8a07c5)\n- PoC Code: [GitHub](https://github.com/tahtaciburak/CVE-2021-41277)\n\n##### Remediation\nUpdate Metabase to release (0.40.5 or 1.40.5), and any subsequent release after that (including x.41+). Vendor instructions on how to update can be found [here](https://www.metabase.com/docs/latest/installation-and-operation/upgrading-metabase).",
                    "createdAt": "2022-12-22T04:37:41Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58259",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "16Shop Admin Panel",
                    "description": "Vagabon is a kit we’ve identified being frequently used to impersonate Paypal in phishing campaigns.",
                    "createdAt": "2023-01-04T10:58:12Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_30711",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-46604 - Apache ActiveMQ OpenWire Broker Remote Code Execution",
                    "description": "##### Description\nThe Java OpenWire protocol marshaller is vulnerable to Remote Code Execution. This vulnerability may allow a remote attacker with network access to either a Java-based OpenWire broker or client to run arbitrary shell commands by manipulating serialized class types in the OpenWire protocol to cause either the client or the broker (respectively) to instantiate any class on the classpath.\n\nPublic exploitation code is available, and Microsoft Threat Intelligence and other security researchers have identified attacks exploiting this vulnerability to deliver ransomware and cryptomining.\n\nUsers are recommended to upgrade both brokers and clients to an ActiveMQ Classic version 5.15.16, 5.16.7, 5.17.6, or 5.18.3 which fixes this issue. Users of ActiveMQ Artemis need to upgrade to version 2.31.2 or higher.\n\n**ActiveMQ Artemis Details**\nActiveMQ Artemis supports the OpenWire protocol and therefore has dependencies from ActiveMQ Classic for this support. These dependencies include the vulnerable code. However, Artemis doesn’t ship Spring so there is currently no known exploit. Regardless, upgrading is still recommended.\n\n##### Related Intelligence\n- CVE: [CVE-2023-46604](https://ti.defender.microsoft.com/cves/CVE-2023-46604/)\n- Security Advisory: [Apache ActiveMQ](https://activemq.apache.org/security-advisories.data/CVE-2023-46604-announcement.txt)\n- Advisory Update: [Apache ActiveMQ News](https://activemq.apache.org/news/cve-2023-46604)\n- Threat Intel and IOCs: [Rapid7](https://www.rapid7.com/blog/post/2023/11/01/etr-suspected-exploitation-of-apache-activemq-cve-2023-46604/)\n- Threat Intel and IOCs: [TrendMicro](https://www.trendmicro.com/en_nz/research/23/k/cve-2023-46604-exploited-by-kinsing.html)\n\n##### Remediation\nFollow the [vendor's documentation](https://activemq.apache.org/components/artemis/documentation/latest/upgrading.html) to install the latest version for your release.",
                    "createdAt": "2023-12-06T10:01:16Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60005",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-1708 & CVE-2024-1709  - ConnectWise ScreenConnect Setup Wizard Auth Bypass",
                    "description": "##### Description\nConnectWise ScreenConnect 23.9.7 and prior are vulnerable to a critical severity authorization bypass and a high severity directory traversal attack. By adding a trailing slash to web requests at the `SetupWizard.aspx` URL, an attacker can bypass authorization and initiate the first time setup again, allowing them to create new admin users and fully control the system. \n\nConnectWise has made an update available to all ScreenConnect systems regardless of their licensing status. Ensure you are updated to 23.9.8 or higher as this is under active exploitation.\n\n##### Related Intelligence\n- CVE: [CVE-2024-1709](https://ti.defender.microsoft.com/cves/CVE-2024-1709/)\n- CVE: [CVE-2024-1708](https://ti.defender.microsoft.com/cves/CVE-2024-1708/)\n- Security Advisory: [ConnectWise Bulletin](https://www.connectwise.com/company/trust/security-bulletins/connectwise-screenconnect-23.9.8)\n- Vulnerability Writeup: [Huntress](https://www.huntress.com/blog/a-catastrophe-for-control-understanding-the-screenconnect-authentication-bypass)\n- Remediation and Hardening Guide: [Mandiant](https://services.google.com/fh/files/misc/connectwise-screenconnect-remediation-hardening-guide.pdf)\n- PoC: [WatchTowr](https://github.com/watchtowrlabs/connectwise-screenconnect_auth-bypass-add-user-poc)\n- Metasploit Module: [GitHub](https://github.com/rapid7/metasploit-framework/blob/b91430c8787fd0310296d7f068c9b40608c91954/modules/exploits/multi/http/connectwise_screenconnect_rce_cve_2024_1709.rb)\n\n##### Remediation\nFollow the [ConnectWise Bulletin](https://www.connectwise.com/company/trust/security-bulletins/connectwise-screenconnect-23.9.8) to install the latest version. We also recommend reading the [Huntress](https://www.huntress.com/blog/a-catastrophe-for-control-understanding-the-screenconnect-authentication-bypass) and [Mandiant](https://services.google.com/fh/files/misc/connectwise-screenconnect-remediation-hardening-guide.pdf) articles for information on how to check if a system has been compromised.",
                    "createdAt": "2024-02-27T03:26:23Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60131",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-33246 - Apache RocketMQ Broker Unauthenticated Remote Command Injection",
                    "description": "##### Description\nFor RocketMQ versions 5.1.0 and below there is a risk of remote command execution.  Several components of RocketMQ lack permission verification. An attacker can use the updateBrokerConfig function to inject and execute commands by sending a specially crafted packet to the RocketMQ broker. To prevent these attacks, users are recommended to upgrade to version 5.1.1 or above for using RocketMQ 5.x or 4.9.6 or above for using RocketMQ 4.x .\n\n##### Related Intelligence\n- CVE: [CVE-2023-33246](https://nvd.nist.gov/vuln/detail/CVE-2023-33246)\n- Security Advisory: [Apache RocketMQ mailing list](https://lists.apache.org/thread/1s8j2c8kogthtpv3060yddk03zq0pxyp)\n- Vulnerability Writeup: [Juniper](https://blogs.juniper.net/en-us/threat-research/cve-2023-33246-apache-rocketmq-remote-code-execution-vulnerability)\n- PoC: [GitHub](https://github.com/Malayke/CVE-2023-33246_RocketMQ_RCE_EXPLOIT)\n- PoC: [Metasploit module](https://www.rapid7.com/db/modules/exploit/multi/http/apache_rocketmq_update_config/)\n- Threat Intel: [VulnCheck](https://vulncheck.com/blog/rocketmq-exploit-payloads)\n\n##### Remediation\nFollow the [Apache RocketMQ Quickstart Guide](https://rocketmq.apache.org/docs/4.x/introduction/02quickstart/) to install the latest version for your release.",
                    "createdAt": "2023-10-27T02:15:36Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59905",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "NSA Warns of Russian Actors Targeting Vulnerable Exim Mail Servers",
                    "description": "##### Description \nOn May 28, 2020 the United States National Security Agency (NSA) released a Cyber Security Advisory that warned of a Russian Espionage campaign, associated with the Sandworm group, was actively exploiting Remote Code Execution vulnerabilities in the Exim mail transfer agent.\n\n##### Used By\nSandworm\n\n##### Related Intelligence\nCVE: [CVE-2019-10149](https://nvd.nist.gov/vuln/detail/CVE-2019-10149), [CVE-2019-15846](https://nvd.nist.gov/vuln/detail/CVE-2019-15846), [CVE-2019-16928](https://nvd.nist.gov/vuln/detail/CVE-2019-16928) \nSecurity Advisory: [NSA Cyber Security Advisory](https://media.defense.gov/2020/May/28/2002306626/-1/-1/0/CSA%20Sandworm%20Actors%20Exploiting%20Vulnerability%20in%20Exim%20Transfer%20Agent%2020200528.pdf) \n\n##### Remediation\nOrganizations running vulnerable instances should upgrade to the latest version of Exim Internet Mailer (version 4.93) immediately.",
                    "createdAt": "2021-02-19T04:51:19Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29423",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-30525 - ZyXEL OS Command Injection",
                    "description": "##### Description\nA critical command injection vulnerability in the CGI program of some firewall versions could allow an attacker to modify specific files and then execute some OS commands on a vulnerable device.\n\nThere are multiple other medium severity vulnerabilities also fixed by firmware update 5.30 as detailed in [this advisory](https://www.zyxel.com/support/multiple-vulnerabilities-of-firewalls-AP-controllers-and-APs.shtml)\n\n##### Related Intelligence\nCVE: [CVE-2022-30525](https://nvd.nist.gov/vuln/detail/CVE-2022-30525)\nSecurity Advisory: [Zyxel](https://www.zyxel.com/support/Zyxel-security-advisory-for-OS-command-injection-vulnerability-of-firewalls.shtml)\nAdditional Advisory: [Zyxel](https://www.zyxel.com/support/multiple-vulnerabilities-of-firewalls-AP-controllers-and-APs.shtml)\nPoC: [GitHub Chocapikk](https://github.com/Chocapikk/CVE-2022-30525-Reverse-Shell)\nPoC: [GitHub Iveresk](https://github.com/iveresk/cve-2022-30525)\n\n##### Remediation\nUpgrade to version 5.30 or higher by downloading the correct version for your model from \n[this site](https://www.zyxel.com/support/download_landing.shtml) and then logging into your Zyxel device's admin webpage to upload the new firmware.  If your model supports auto upgrades, we strongly advise enabling this to better protect against future vulnerabilities.",
                    "createdAt": "2022-06-06T02:14:15Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_54814",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-21980 - Microsoft Exchange Server Authenticated Privilege Escalation to Admin",
                    "description": "##### Description \nThree critical-rated Exchange vulnerabilities could allow an authenticated attacker to take over the mailboxes of all Exchange users. They could then read and send emails or download attachments from any mailbox on the Exchange server. \n\n##### Related Intelligence\nCVE: [CVE-2022-24477](https://nvd.nist.gov/vuln/detail/CVE-2022-24477) \nCVE: [CVE-2022-24516](https://nvd.nist.gov/vuln/detail/CVE-2022-24516) \nCVE: [CVE-2022-21980](https://nvd.nist.gov/vuln/detail/CVE-2022-21980) \nSecurity Advisory: [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-23277)\nExchange Blog: [August 2022 Exchange Updates](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-august-2022-exchange-server-security-updates/ba-p/3593862)\n\n##### Remediation\nThis update requires **both** applying the patch **and** enabling Windows Extended Protection in order to resolve this vulnerability.\n\n**Apply the August 2022 security update to impacted Exchange Servers.** Please see the Security Updates section of the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-21980) page for download links. \n\t\nThe security update is available for the following versions:\n\t- Exchange 2013 CU 23\n\t- Exchange 2016 CU 22 and CU 23\n\t- Exchange 2019 CU 11 and CU 12\n\n**Addressing some of CVEs released this month requires admins to enable [Windows Extended protection](https://docs.microsoft.com/iis/configuration/system.webserver/security/authentication/windowsauthentication/extendedprotection/) on your Exchange servers.** Please follow the instructions on the [Exchange Blog](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-august-2022-exchange-server-security-updates/ba-p/3593862) to enable this.",
                    "createdAt": "2022-08-11T07:00:03Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56424",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-24112 - Apache APISIX Default API Key",
                    "description": "##### Description\nAn attacker can abuse the batch-requests plugin to send requests to rewrite the X-REAL-IP header and bypass the IP restriction of Admin API. A default configuration of Apache APISIX (with default API key) is vulnerable to remote code execution. There is a check in the batch-requests plugin which overrides the client IP with its real remote IP, but due to a bug in the code this check can be bypassed.\n\n##### Related Intelligence\nCVE: [CVE-2022-24112](https://nvd.nist.gov/vuln/detail/CVE-2022-24112)\nSecurity Advisory: [Apache](https://apisix.apache.org/blog/2022/02/11/cve-2022-24112/)\nVulnerability Details: [Openwall Mailing List](https://www.openwall.com/lists/oss-security/2022/02/11/3)\nPoC: [GitHub](https://github.com/Mah1ndra/CVE-2022-24112)\n\n##### Remediation\nUpgrade to patch 2.12.1 or 2.10.4 LTS to address this vulnerability. \n\n*Workaround:*\nComment out `batch-requests` in the `conf/config.yaml` and `conf/config-default.yaml` files to disable this plugin, then restart APISIX. Changing the default API key also helps to mitigate the vulnerability.",
                    "createdAt": "2022-06-15T02:44:58Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_55371",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-42258 - BillQuick Web Suite SQL Injection",
                    "description": "ASI: CVE-2021-42258 - BillQuick Web Suite SQL Injection\n\n##### Description\n\nBQE BillQuick Web Suite 2018 through 2021 before 22.0.9.1 allows blind SQL injection for unauthenticated remote code execution, as exploited in the wild in October 2021 for ransomware installation. SQL injection can, for example, use the txtID (aka username) parameter. Successful exploitation can include the ability to execute arbitrary code as MSSQLSERVER$ via xp_cmdshell.\n\nHuntress discovered and reported this vulnerability to BQE, along with several other yet to be announced vulnerabilities.  Expect more patches from BQE to be released soon.\n\n##### Related Intelligence\n\nCVE: [CVE-2021-42258](https://nvd.nist.gov/vuln/detail/CVE-2021-42258) \nPatch Notes: [WebSuite2021LogFile_9_1.pdf](https://billquick.net/download/Support_Download/BQWS2021Upgrade/WebSuite2021LogFile_9_1.pdf)\nSecurity Advisory: [Huntress](https://www.huntress.com/blog/threat-advisory-hackers-are-exploiting-a-vulnerability-in-popular-billing-software-to-deploy-ransomware)\n\n##### Remediation\n\nThis is under active exploitation with further vulnerabilities reported to BQE that have yet to be made public.  Download the latest version of Web Suite 2021 from [BillQuick](https://www.bqe.com/products/billquick/support/downloads) and run it to upgrade.  If you are unable to upgrade we recommend placing your server behind a VPN and monitor it for unusual activity.\n\nAdditionally it is best practice to disable xp_cmdshell on MS SQL Server as it can be misused by attackers to execute malicious commands.  Disabling xp_cmdshell may provide additional protection as it has been an observed TTP for the threat actor exploiting BillQuick Web Suite.  You can follow [this guide for disabling it](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/xp-cmdshell-server-configuration-option?view=sql-server-ver15) from Microsoft.  ",
                    "createdAt": "2021-11-01T04:17:50Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_44649",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Researchers Discover Active Exploitation Against Accellion FTA Systems",
                    "description": "##### Description \nOn February 22, 2021, researchers at FireEye issued a report detailing their findings of an active campaign targeting Accellion File Transfer Appliance (FTA) systems. Specifically, the threat actors leveraged several 0days impacting the software to deploy web shells in order to initiate data exfiltration campaigns.\n\n##### Related Intelligence\nRiskIQ Article: [Researchers Discover Active Exploitation Against Accellion FTA Systems](https://community.riskiq.com/article/59396fa8)\n\nCVE: [CVE-2021-27101](https://nvd.nist.gov/vuln/detail/CVE-2021-27101), [CVE-2021-27102](https://nvd.nist.gov/vuln/detail/CVE-2021-27102), [CVE-2021-27103](https://nvd.nist.gov/vuln/detail/CVE-2021-27103), [CVE-2021-27104](https://nvd.nist.gov/vuln/detail/CVE-2021-27104) \n\n##### Remediation \nThe Accellion FTA platform is slated to reach end of support on April 30, 2021. Organizations are strongly encouraged to investigate if they are running out-of-date versions of Accellion's FTA. Accellion is recommending that their customers migrate to their new kiteworks platform. If operators are unable to migrate to kiteworks at the present point in time, it is highly recommended that connections to FTA systems are restricted to only approved/authorized IP addresses.",
                    "createdAt": "2021-02-24T03:49:23Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29628",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-32235 - Ghost CMS Path Traversal Allows Arbitrary File Read",
                    "description": "##### Description\nGhost before 5.42.1 allows remote attackers to read arbitrary files within the active theme's folder via /assets/built%2F..%2F..%2F/ directory traversal. This occurs in frontend/web/middleware/static-theme.js.  This attack can be used to read private SSH keys or other sensitive information, possibly leading to full system compromise.\n\n##### Related Intelligence\n- CVE: [CVE-2023-32235](https://nvd.nist.gov/vuln/detail/CVE-2023-32235)\n- Security Advisory: [GitHub Security Advisory](https://github.com/advisories/GHSA-wf7x-fh6w-34r6)\n- Vulnerability Writeup and PoC: [Snyk.io](https://security.snyk.io/vuln/SNYK-JS-GHOST-5497332)\n\n##### Remediation\nFollow the [Ghost Update Guide](https://ghost.org/docs/update-major-version/) to update to the latest version.",
                    "createdAt": "2023-07-19T05:22:52Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59644",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-42793 - TeamCity Unauthenticated Remote Code Execution",
                    "description": "##### Description\nThe vulnerability may enable an unauthenticated attacker with HTTP(S) access to a TeamCity server to perform a remote code execution (RCE) attack and gain administrative control of the TeamCity server. It has been fixed in version 2023.05.4 and has been observed being exploited in the wild.\n\n##### Related Intelligence\n- CVE: [CVE-2023-42793](https://nvd.nist.gov/vuln/detail/CVE-2023-42793)\n- Security Advisory: [JetBrains TeamCity Blog](https://blog.jetbrains.com/teamcity/2023/09/critical-security-issue-affecting-teamcity-on-premises-update-to-2023-05-4-now/)\n- Initial Disclosure: [Sonar's Vulnerability Research Team](https://www.sonarsource.com/blog/teamcity-vulnerability/)\n- Vulnerability Writeup and PoC: [AttackerKB](https://attackerkb.com/topics/1XEEEkGHzt/cve-2023-42793/rapid7-analysis)\n- Microsoft Defender Threat Intelligence: [Diamond Sleet Compromises TeamCity Servers](https://ti.defender.microsoft.com/articles/7985400e)\n- Microsoft Security Blog: [Multiple North Korean threat actors exploiting the TeamCity CVE-2023-42793 vulnerability](https://www.microsoft.com/en-us/security/blog/2023/10/18/multiple-north-korean-threat-actors-exploiting-the-teamcity-cve-2023-42793-vulnerability/)\n- PoC: [Metasploit](https://packetstormsecurity.com/files/174860/JetBrains-TeamCity-Unauthenticated-Remote-Code-Execution.html)\n\n##### Remediation\nTo update your server, [**download the latest version**](https://www.jetbrains.com/teamcity/download/other.html) (2023.05.4) or use the [**automatic update**](https://www.jetbrains.com/help/teamcity/upgrading-teamcity-server-and-agents.html#Automatic+Update) option within TeamCity.",
                    "createdAt": "2023-10-10T04:13:58Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59826",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-30158 - Microsoft SharePoint Server Authenticated Deserialization Remote Code Execution",
                    "description": "##### Description\nA vulnerability in SharePoint Server 2016 and 2019 allows authenticated attackers that are able to create a Site on the server to cause it to execute arbitrary code. The specific flaw exists within the `WizardConnectToDataStep4` class of the `Microsoft.Office.Server.Chart` assembly. The issue results from the lack of proper validation of user-supplied data, which can result in deserialization of untrusted data. An attacker with access to low-privilege credentials can leverage this vulnerability to execute code in the context of Administrator.\n\n##### Related Intelligence\nCVE: [CVE-2022-30158](https://nvd.nist.gov/vuln/detail/CVE-2022-30158) \nSecurity Advisory: [MSRC](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-30158)\nVulnerability Writeup: [SSD Disclosure](https://ssd-disclosure.com/ssd-advisory-microsoft-sharepoint-server-wizardconnecttodatastep4-deserialization-of-untrusted-data-rce/)\n\n##### Remediation\nMicrosoft recommends that organizations apply the June 2022 security update to impacted SharePoint Servers.  The security update is available for the following versions:\n\n- SharePoint Subscription Edition\n- SharePoint 2019\n- SharePoint 2016\n- SharePoint 2013 SP 1\n\nPlease see the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-30158) for a download links.",
                    "createdAt": "2022-09-13T07:42:02Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57049",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-47986 - IBM Aspera Faspex Unauthenticated Remote Code Execution",
                    "description": "##### Description\nVersions of IBM Aspera Faspex 4.4.2 PL1 and earlier could allow a remote attacker to execute arbitrary code on the system, caused by a YAML deserialization flaw. By sending a specially crafted obsolete API call, an attacker could exploit this vulnerability to execute arbitrary code on the system. This has public exploit code available and has been observed being exploited in the wild as early as February 3rd, 2023.\n\n*Our scanners can determine the version of Aspera Faspex that is running, but it cannot determine the patch level (PL). Please manually check any versions of 4.4.2 to determine if it is on PL2 or greater.*\n\n##### Related Intelligence\n- CVE: [CVE-2022-47986](https://nvd.nist.gov/vuln/detail/CVE-2022-47986)\n- Security Advisory: [IBM Support](https://www.ibm.com/support/pages/node/6952319)\n- Vulnerability Writeup: [AssetNote.io](https://blog.assetnote.io/2023/02/02/pre-auth-rce-aspera-faspex/)\n- PoC: [GitHub](https://github.com/ohnonoyesyes/CVE-2022-47986)\n\n##### Remediation\nApply patch 4.4.2 PL (Patch Level) 2 or higher as soon as possible. \n- [4.4.2 PL2 for Windows](http://www.ibm.com/support/fixcentral/quickorder?fixids=IBM_Aspera_Faspex_4.4.2_Windows_Patch_Level_2&product=ibm%2FOther%20software%2FIBM%20Aspera%20Faspex%20Server&source=dbluesearch&mhsrc=ibmsearch_a&mhq=faspex%204%26period%3B4%26period%3B2)\n- [4.4.2 PL2 for Linux](http://www.ibm.com/support/fixcentral/quickorder?fixids=IBM_Aspera_Faspex_4.4.2_Linux_Patch_Level_2&product=ibm%2FOther%20software%2FIBM%20Aspera%20Faspex%20Server&source=dbluesearch&mhsrc=ibmsearch_a&mhq=faspex%204%26period%3B4%26period%3B2)",
                    "createdAt": "2023-02-17T04:54:35Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58593",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-25641 - Cacti File Write, File Inclusion, and SQL Injection",
                    "description": "##### Description\n[CVE-2024-25641](https://github.com/Cacti/cacti/security/advisories/GHSA-7cmj-g5qc-pj88)\nAn arbitrary file write vulnerability, exploitable through the \"Package Import\" feature, allows authenticated users having the \"Import Templates\" permission to execute arbitrary PHP code on the web server.\n\n[CVE-2024-31459](https://github.com/Cacti/cacti/security/advisories/GHSA-cx8g-hvq8-p2rv)\nCacti provides an operational monitoring and fault management framework. Prior to version 1.2.27, there is a file inclusion issue in the `lib/plugin.php` file. Combined with SQL injection vulnerabilities, remote code execution can be implemented. There is a file inclusion issue with the `api_plugin_hook()` function in the `lib/plugin.php` file, which reads the plugin_hooks and plugin_config tables in database. The read data is directly used to concatenate the file path which is used for file inclusion. Version 1.2.27 contains a patch for the issue.\n\n[CVE-2024-31445](https://github.com/Cacti/cacti/security/advisories/GHSA-vjph-r677-6pcc)\nA SQL injection vulnerability in `automation_get_new_graphs_sql` function of `api_automation.php` allows authenticated users to exploit these SQL injection vulnerabilities to perform privilege escalation and remote code execution.\n\n##### Related Intelligence\n- CVE: [CVE-2024-25641](https://ti.defender.microsoft.com/cves/CVE-2024-25641/)\n- CVE: [CVE-2024-31459](https://ti.defender.microsoft.com/cves/CVE-2024-31459/)\n- CVE: [CVE-2024-31445](https://ti.defender.microsoft.com/cves/CVE-2024-31445/)\n- Security Advisory: [CVE-2024-25641](https://github.com/Cacti/cacti/security/advisories/GHSA-7cmj-g5qc-pj88)\n- Security Advisory: [CVE-2024-31459](https://github.com/Cacti/cacti/security/advisories/GHSA-cx8g-hvq8-p2rv)\n- Security Advisory: [CVE-2024-31445](https://github.com/Cacti/cacti/security/advisories/GHSA-vjph-r677-6pcc)\n\n##### Remediation\nUpgrade to Cacti 1.2.27 or higher to address these vulnerabilities. For instances of 1.2.x running under PHP < 7.0, a further change [a8d59e8](https://github.com/Cacti/cacti/commit/a8d59e8fa5f0054aa9c6981b1cbe30ef0e2a0ec9) may also required. To upgrade Cacti, follow these steps from the [vendor](https://github.com/Cacti/documentation/blob/develop/Upgrading-Cacti.md).",
                    "createdAt": "2024-05-29T09:01:09Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60196",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-6287 SAP Remotely Exploitable Code on NetWeaver (RECON) Vulnerability",
                    "description": "##### Description \nSAP NetWeaver AS JAVA (LM Configuration Wizard), versions - 7.30, 7.31, 7.40, 7.50, does not perform an authentication check which allows an attacker without prior authentication to execute configuration tasks to perform critical actions against the SAP Java system, including the ability to create an administrative user. If exploited, a remote, unauthenticated attacker can obtain unrestricted access to SAP systems through the creation of high-privileged users and the execution of arbitrary operating system commands with the privileges of the SAP service user account.\n\n##### Related Intelligence\nCVE: [CVE-2020-6287](https://nvd.nist.gov/vuln/detail/CVE-2020-6287) \nSecurity Advisory: [SAP Advisory](https://wiki.scn.sap.com/wiki/pages/viewpage.action?pageId=552599675)\n\n##### Remediation\nOrganizations should apply the SAP July 2020 security patch to address this vulnerability",
                    "createdAt": "2021-02-19T04:49:44Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29414",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Open Docker Daemon API Service",
                    "description": "##### Description\nBy default, Docker daemon creates a non-networked Unix domain socket at /var/run/docker.sock and only processes with root permission or Docker group membership can access it. If a client needs to access a Docker daemon remotely, Docker daemon can open a TCP socket and listens on port 2375 for REST API requests. \n\nThe default TCP socket provides unencrypted and unauthenticated access to the Docker daemon. Once malicious actors discover an unsecured Docker daemon, they can gain full control of the Docker platform and potentially compromise the entire host. There is no CVE as this is a misconfiguration.\n\n##### Related Intelligence\nVendor Docs: [Docker Security](https://docs.docker.com/engine/security/)\nMITRE ATT&CK: [T1552.007](https://attack.mitre.org/techniques/T1552/007/)\nThreat Intel: [Unit42](https://unit42.paloaltonetworks.com/attackers-tactics-and-techniques-in-unsecured-docker-daemons-revealed/)\nThreat Intel: [Aqua Sec](https://blog.aquasec.com/attack-techniques-autom-cryptomining-campaign)\nThreat Intel: [Trend Micro](https://www.trendmicro.com/en_us/research/20/j/metasploit-shellcodes-attack-exposed-docker-apis.html)\nWriteup: [Riccardo Ancarani](https://medium.com/@riccardo.ancarani94/attacking-docker-exposed-api-3e01ffc3c124)\n\n##### Remediation\n- Set Docker to only listen on locally, which is the default setting.\n- Restrict access with a firewall.\n- If remote access is required, follow [these instructions](https://docs.docker.com/engine/security/protect-access/) to protect it with SSH or a certificate based TLS-HTTPS connection.##### Description\nBy default, Docker daemon creates a non-networked Unix domain socket at /var/run/docker.sock and only processes with root permission or Docker group membership can access it. If a client needs to access a Docker daemon remotely, Docker daemon can open a TCP socket and listens on port 2375 for REST API requests. \n\nThe default TCP socket provides unencrypted and unauthenticated access to the Docker daemon. Once malicious actors discover an unsecured Docker daemon, they can gain full control of the Docker platform and potentially compromise the entire host. There is no CVE as this is a misconfiguration.\n\n##### Related Intelligence\nVendor Docs: [Docker Security](https://docs.docker.com/engine/security/)\nMITRE ATT&CK: [T1552.007](https://attack.mitre.org/techniques/T1552/007/)\nThreat Intel: [Unit42](https://unit42.paloaltonetworks.com/attackers-tactics-and-techniques-in-unsecured-docker-daemons-revealed/)\nThreat Intel: [Aqua Sec](https://blog.aquasec.com/attack-techniques-autom-cryptomining-campaign)\nThreat Intel: [Trend Micro](https://www.trendmicro.com/en_us/research/20/j/metasploit-shellcodes-attack-exposed-docker-apis.html)\nWriteup: [Riccardo Ancarani](https://medium.com/@riccardo.ancarani94/attacking-docker-exposed-api-3e01ffc3c124)\n\n\n##### Remediation\n- Set Docker to only listen on locally, which is the default setting.\n- Restrict access with a firewall.\n- If remote access is required, follow [these instructions](https://docs.docker.com/engine/security/protect-access/) to protect it with SSH or a certificate based TLS-HTTPS connection.",
                    "createdAt": "2022-06-28T07:17:06Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_55775",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-14882 Vulnerability in the Oracle WebLogic Server product of Oracle Fusion Middleware",
                    "description": "##### Description \nEasily exploitable vulnerability allows unauthenticated attacker with network access via HTTP to compromise Oracle WebLogic Server. Successful attacks of this vulnerability can result in takeover of Oracle WebLogic Server.\n\n##### Related Intelligence\nCVE: [CVE-2020-14882](https://nvd.nist.gov/vuln/detail/CVE-2020-14882) \nSecurity Advisory: [Oracle Security Alert](https://www.oracle.com/security-alerts/alert-cve-2020-14750.html)  \n\n##### Remediation\nOracle advises organizations to immediately apply the October 2020 Critical Patch Update",
                    "createdAt": "2021-02-19T04:52:14Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29429",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "[Potential] CyberPanel Remote Code Execution Vulnerabilities",
                    "description": "##### Description\n CVE-2024-51567: A vulnerability in the upgrademysqlstatus function in databases/views.py in CyberPanel (aka Cyber Panel) before 2.3.8 allows remote attackers to bypass authentication and execute arbitrary commands via /dataBases/upgrademysqlstatus by bypassing secMiddleware (which is only for a POST request) and using shell metacharacters in the statusfile property, as exploited in the wild in October 2024 by PSAUX. PoC exploit code has been made public and this has been exploited by different ransomware operators.\n \n CVE-2024-51378: A vulnerability in the getresetstatus in dns/views.py and ftp/views.py in CyberPanel (aka Cyber Panel) before 2.3.8 allows remote attackers to bypass authentication and execute arbitrary commands via /dns/getresetstatus or /ftp/getresetstatus by bypassing secMiddleware (which is only for a POST request) and using shell metacharacters in the statusfile property, as exploited in the wild in October 2024 by PSAUX. PoC exploit code has been made public and this has been exploited by different ransomware operators.\n \n##### Related Intelligence\n- CVE: [CVE-2024-51567](https://security.microsoft.com/intel-explorer/cves/CVE-2024-51567/) \n- Vulnerability Writeup: [DreyAnd](https://dreyand.rs/code/review/2024/10/27/what-are-my-options-cyberpanel-v236-pre-auth-rce)\n- PoC: [Github](https://github.com/XiaomingX/cve-2024-51567-poc/blob/main/CVE-2024-51567.py)\n- CVE: [CVE-2024-51378](https://security.microsoft.com/intel-explorer/cves/CVE-2024-51378/) \n- Vulnerability Writeup: [refr4g](https://attacke.rs/posts/cyberpanel-command-injection-vulnerability/)\n- PoC: [Github](https://github.com/refr4g/CVE-2024-51378/tree/main)\n- Security Advisory: [CyberPanel](https://cyberpanel.net/blog/detials-and-fix-of-recent-security-issue-and-patch-of-cyberpanel)\n\n##### Remediation\nFollow the vendor's [documentation](https://cyberpanel.net/KnowledgeBase/home/upgrade-cyberpanel/) to upgrade to version 2.3.8 or higher.",
                    "createdAt": "2025-01-24T04:36:37Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250230300",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-48788 - FortiClient EMS Unauthenticated SQLi to RCE",
                    "description": "##### Description\nFortiClient Endpoint Management Server (EMS) has a SQLi vulnerability that allows an unauthenticated attacker to attain remote code execution. The service named FMCDaemon.exe contains this vulnerability and runs on port 8013 by default. An attacker sending a specially crafted packet to this service can use the built-in xp_cmdshell ability of Microsoft SQL Server to attain remote code execution. This has been observed exploited in the wild and a proof of concept (PoC) exploit is publicly available.\n\n##### Related Intelligence\n- CVE: [CVE-2023-48788](https://ti.defender.microsoft.com/cves/CVE-2023-48788/)\n- Security Advisory: [Fortinet FG-IR-24-007](https://fortiguard.fortinet.com/psirt/FG-IR-24-007)\n- Vulnerability Writeup: [Horizon3.ai](https://www.horizon3.ai/attack-research/attack-blogs/cve-2023-48788-fortinet-forticlientems-sql-injection-deep-dive/)\n- Vulnerability Writeup part 2: [Horizon3.ai](https://www.horizon3.ai/attack-research/cve-2023-48788-revisiting-fortinet-forticlient-ems-to-exploit-7-2-x/)\n- PoC: [GitHub](https://github.com/horizon3ai/CVE-2023-48788)\n- Threat Intel: [Red Canary](https://redcanary.com/blog/cve-2023-48788/)\n- Threat Intel:[eSentire](https://www.esentire.com/security-advisories/widespread-exploitation-of-fortinet-vulnerability-cve-2023-48788)\n\n##### Remediation\nFollow the [vendor's guide](https://docs.fortinet.com/document/forticlient/7.2.1/ems-administration-guide/967431/upgrading-from-an-earlier-forticlient-ems-version) to upgrade to a patched software version. \n\nThose are:\n- FortiClientEMS versions 7.2.0 through 7.2.2 should upgrade to 7.2.3 or above\n- FortiClientEMS versions 7.0.1 through 7.0.10 should upgrade to 7.0.11 or above",
                    "createdAt": "2024-04-12T03:43:21Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60151",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "Entrolink PPX-AnyLink Remote Code Execution",
                    "description": "##### Description\n\nAn unspecified zero day vulnerability, probably in the web interface, is currently being exploited in the wild. According to an underground cybercrime forum post selling the exploit it is an unauthenticated root remote code execution vulnerability. There are reports of this linked to possible intrusions by ransomware gangs, and currently there is no patch from the vendor.\n\n##### Related Intelligence\n\nEntrolink Customer Center: [Notice](http://www.entrolink.com/home/m_board.php?ps_db=notice)\nSecurity Advisory: [Article](https://therecord.media/ransomware-gangs-are-abusing-a-zero-day-in-entrolink-vpn-appliances/)\n\n##### Remediation\n\nCurrently there is little known about the vulnerability and there is no security patch from the vendor.  We recommend checking if software updates are available.  Entrolink advises [blocking the web console ports](http://www.entrolink.com/home/board_data/notice/web_portal_%BC%AD%BA%F1%BD%BA_%B3%BB%B8%AE%B1%E2.pdf) and changing all passwords immediately.  ",
                    "createdAt": "2021-11-02T06:53:20Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_44751",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-7373 - vBulletin Unauthenticated Remote Code Execution",
                    "description": "##### Description\n\nvBulletin 5.5.4 through 5.6.2 allows remote command execution via crafted subWidgets data in an ajax/render/widget_tabbedcontainer_tab_panel request. NOTE: this issue exists because of an incomplete fix for CVE-2019-16759.  This vulnerability has been publicly exploited and the exploit is available in Metasploit.  \n\n##### Related Intelligence\n\nRiskIQ Article: [Exploits in the Wild for vBulletin Pre-Auth RCE Vulnerability]](https://community.riskiq.com/article/f04ff01b)\n\nCVE: [CVE-2020-7373](https://nvd.nist.gov/vuln/detail/CVE-2020-7373)\n\nSecurity Advisory: [vBulletin Announcement](https://forum.vbulletin.com/forum/vbulletin-announcements/vbulletin-announcements_aa/4445227-vbulletin-5-6-0-5-6-1-5-6-2-security-patch)\n\nPublic PoC: [Packet Storm Metasploit Module](https://packetstormsecurity.com/files/158866/vBulletin-5.x-Remote-Code-Execution.html)\n\n##### Remediation\n\nOrganizations using vBulletin should ensure that they upgrade to the latest available [patch](https://members.vbulletin.com/patches.php)\n",
                    "createdAt": "2021-08-13T04:00:26Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_41970",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-51449 & CVE-2024-1561 - Gradio Arbitrary File Read Vulnerabilities",
                    "description": "##### Description\nThere are two disclosed CVEs that allow arbitrary file read which would allow attackers to access stored secrets: CVE-2023-51449 and CVE-2024-1561. The CVE-2023-51449 vulnerability impacts the following listed versions of the Gradio framework, a framework for developing and sharing AI/ML demos:\n\n- Gradio versions 4.0.0 to 4.10.0 \n\nThe CVE-2024-1561 vulnerability impacts the following listed versions of the Gradio framework:\n\n- Gradio versions 3.47.0 to 4.12.0\n\nCVE-2023-51449 is a path traversal vulnerability in the \"**file**\" endpoint. Secrets such as API keys are stored in environmental variables. Horizon3.ai researchers found that attackers could use the \"**upload**\" endpoint to first create a subdirectory within the temp directory, and then traverse out from that subdirectory to read arbitrary files using the \"**../**\" or \"**%2e%2e%2f**\" sequence. From there, one can request the \"**/proc/self/environ**\" pseudo-file using a HTTP Range header to get arbitrary file read of secrets stored in environmental variables. \n\nCVE-2024-1561 is an input validation flaw in the \"**component_server**\" API endpoint that allows attackers to invoke internal Python backend functions. This vulnerability enables unauthorized local file read access. It is important to note that both CVE-2023-51449 and CVE-2024-1561 allow attackers to read arbitrary files, including secrets like API keys. Additionally, all Gradio instances vulnerable to CVE-2023-51449 will be vulnerable to CVE-2024-1561.\n\nPlease note that a proof-of-concept (PoC) has been released for CVE-2024-1561. \n\n##### Related Intelligence\n- CVE #1: [CVE-2023-51449](https://security.microsoft.com/vulnerabilities/vulnerability/CVE-2023-51449/)\n- CVE #2: [CVE-2024-1561](https://security.microsoft.com/vulnerabilities/vulnerability/CVE-2024-1561/)\n- CVE-2024-1561 PoC: [DiabloHTB](https://github.com/DiabloHTB/CVE-2024-1561)\n- Technical Analysis: [Horizon3.ai](https://www.horizon3.ai/attack-research/disclosures/exploiting-file-read-vulnerabilities-in-gradio-to-steal-secrets-from-hugging-face-spaces/) \n\n##### Remediation\nGradio users should update to the latest version of the software, which Gradio Space users can do this by viewing the \"README.md\" file and clicking the \"Upgrade\" button. For self-hosted or users using the Gradio share URL function, users can upgrade with the following pip command:\n\n**pip install gradio --upgrade**",
                    "createdAt": "2024-06-26T09:29:15Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60224",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-4956 - Nexus Repository Manager Unauthenticated Path Traversal",
                    "description": "##### Description\nA vulnerability has been discovered in Nexus Repository 3 which allows for an attacker to craft a URL to return any file as a download without any authentication. This includes system files outside of Nexus Repository application scope such as password or ssh key files. \n\nA _*Potential*_ insight occurs when we are able to detect the software but are unable to determine if the system is running a vulnerable version of said software. Please manually check the system to see if it is running a vulnerable version.\n\n##### Related Intelligence\n- CVE: [CVE-2024-4956](https://security.microsoft.com/vulnerabilities/vulnerability/CVE-2024-4956/overview)\n- Security Advisory: [SonaType Support](https://support.sonatype.com/hc/en-us/articles/29416509323923-CVE-2024-4956-Nexus-Repository-3-Path-Traversal-2024-05-16)\n- Vulnerability Writeup: [exp10it.io](https://exp10it.io/2024/05/%E9%80%9A%E8%BF%87-java-fuzzing-%E6%8C%96%E6%8E%98-nexus-repository-3-%E7%9B%AE%E5%BD%95%E7%A9%BF%E8%B6%8A%E6%BC%8F%E6%B4%9E-cve-2024-4956//)\n- PoC: [ErickFernandox on GitHub](https://github.com/erickfernandox/CVE-2024-4956)\n\n##### Remediation\nFollow the [vendor's documentation](https://help.sonatype.com/en/download.html) to upgrade to Nexus Repository version 3.68.1 or later.\n\n*Workaround*\nIf you cannot immediately upgrade, please see the [vendor's mitigations](https://support.sonatype.com/hc/en-us/articles/29412417068819-Mitigations-for-CVE-2024-4956-Nexus-Repository-3-Vulnerability) to harden your system.",
                    "createdAt": "2024-06-18T06:12:33Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60218",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-4323 - Fluent Bit Memory Corruption on the Traces API Endpoint",
                    "description": "##### Description\nThe identified vulnerability arose from a memory corruption error that could potentially create conditions for denial of service events, information disclosure, or, possibly remote code execution. This issue was related to the internal tracing interface and _not_ to traces telemetry data handling.\n\nCertain types of input names in incoming requests were not properly validated before being parsed by the traces API endpoint. A bad actor could exploit this flaw by passing unexpected or invalid inputs to intentionally cause memory corruption, and then use the resulting memory corruption to generate a denial of service attack or (with careful crafting) to expose secret information. It’s also possible that the memory exploit could be used for remote code execution.\n\n##### Related Intelligence\n- CVE: [CVE-2024-4323](https://ti.defender.microsoft.com/cves/CVE-2024-4323/)\n- Security Advisory: [FluentBit.io](https://fluentbit.io/blog/2024/05/21/statement-on-cve-2024-4323-and-its-fix/)\n- Vulnerability Writeup and PoC: [Tenable](https://www.tenable.com/blog/linguistic-lumberjack-attacking-cloud-services-via-logging-endpoints-fluent-bit-cve-2024-4323)\n\n##### Remediation\nFollow the [vendor's documentation](https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bit) to install the latest supported version for your release.\n\nUpgrade to Fluent Bit version 2.2.3 (the last release of Fluent Bit v2), or Fluent Bit version 3.0.4 or greater.",
                    "createdAt": "2024-05-29T09:00:28Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60197",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-42321 Microsoft Exchange Server Authenticated Remote Code Execution Vulnerability",
                    "description": "##### Description\n\nAn authenticated deserialization vulnerability allows a remote user to execute code in the context of the Exchange server which commonly has extremely high permissions in the AD domain. This is a bug in how Exchange allowed certain data to be stored in the BinaryData section of a UserConfiguration on a folder. When a UserConfiguration is set with a payload in the BinaryData and then the attacker requests a ClientAccessToken, it triggers a deserialization bug which results in execution of the payload in BinaryData. The example PoC attack requires execution of 4 POSTs in a chain against Exchange with an authenticated user to be successful.\n\n##### Related Intelligence\nCVE: [CVE-2021-42321](https://nvd.nist.gov/vuln/detail/CVE-2021-42321) \nSecurity Advisory: [Microsoft Security Advisory](https://techcommunity.microsoft.com/t5/exchange-team-blog/released-november-2021-exchange-server-security-updates/ba-p/2933169)\nPoC: [GitHub testanull/CVE-2021-42321_poc.py](https://gist.github.com/testanull/0188c1ae847f37a70fe536123d14f398)\nWriteup: [Peterjson](https://peterjson.medium.com/some-notes-about-microsoft-exchange-deserialization-rce-cve-2021-42321-110d04e8852)\n\n##### Remediation\nMicrosoft recommends that organizations apply the Nov 2021 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n-   Exchange Server 2013 [CU23](https://www.microsoft.com/en-us/download/details.aspx?familyID=8ef4e237-7007-4e30-9525-75ae6e66bb41)\n-   Exchange Server 2016 [CU21](https://www.microsoft.com/en-us/download/details.aspx?familyID=de4b96e0-8d0e-4830-8354-7ed2128e6f82) and [CU22](https://www.microsoft.com/en-us/download/details.aspx?familyID=688b79c6-7e43-4332-848d-47e88f60818c)\n-   Exchange Server 2019 [CU10](https://www.microsoft.com/en-us/download/details.aspx?familyID=1c42658f-9d60-4afb-a6c6-e35594b17d39) and [CU11](https://www.microsoft.com/en-us/download/details.aspx?familyID=cd28ac6e-eb6f-4747-b9f0-24785b08a012)",
                    "createdAt": "2021-12-02T08:49:48Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_45841",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-28461 - Array Networks AG SSL VPN Remote Code Execution",
                    "description": "##### Description​\nA remote code execution vulnerability exists in Array Networks' AG and vxAG Series SSL VPN gateways running ArrayOS AG versions 9.4.0.481 and earlier. This vulnerability allows unauthenticated attackers to browse the filesystem or execute remote code on the SSL VPN gateway by exploiting a specific attribute in an HTTP header. This low attack complexity vulnerability has been observed to be exploited in the wild.\n\n##### Related Intelligence​\n- CVE: [CVE-2023-28461](https://security.microsoft.com/intel-explorer/cves/CVE-2023-28461/)\n- Security Advisory: [Array Networks](https://support.arraynetworks.net/prx/001/http/supportportal.arraynetworks.net/documentation/FieldNotice/Array_Networks_Security_Advisory_for_Remote_Code_Execution_Vulnerability_AG.pdf)\n- Threat Intelligence: [LAC](https://www.lac.co.jp/lacwatch/pdf/20231108_lsi_vol6.pdf)\n- Threat Intelligence: [Trend Micro](https://www.trendmicro.com/en_us/research/24/k/lodeinfo-campaign-of-earth-kasha.html)\n- Threat Intelligence: [Cybereason](https://www.cybereason.com/blog/cuckoo-spear-analyzing-noopdoor)\n\n##### Remediation​\nAs noted in the above Array Networks security advisory, to upgrade to the fixed version of 9.4.0.484 or later, navigate to the [Array Support portal.](https://support.arraynetworks.net/prx/000/http/supportportal.arraynetworks.net/login.html)",
                    "createdAt": "2025-02-24T09:12:16Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250510200",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-11680 - ProjectSend Improper Authentication Vulnerability",
                    "description": "##### Description\nProjectSend, an open-source file sharing web application, has a critical vulnerability in versions prior to r1720. This improper authentication vulnerability allows remote, unauthenticated attackers to exploit this flaw by sending crafted HTTP requests to options.php. Successful exploitation enables attackers to modify the application’s configuration without authorization, create accounts, upload webshells, and embed malicious JavaScript. This vulnerability is under active exploitation and PoCs are available.\n##### Related Intelligence\n- CVE: [CVE-2024-11680](https://security.microsoft.com/intel-explorer/cves/CVE-2024-11680/) \n- Initial Disclosure: [Synacktiv](https://www.synacktiv.com/sites/default/files/2024-07/synacktiv-projectsend-multiple-vulnerabilities.pdf)\n- PoC: [GitHub](https://github.com/D3N14LD15K/CVE-2024-11680_PoC_Exploit/blob/main/README.md)  \n- PoC: [Nuclei](https://github.com/projectdiscovery/nuclei-templates/blob/main/http/vulnerabilities/projectsend-auth-bypass.yaml)\n- PoC: [Metasploit](https://github.com/rapid7/metasploit-framework/blob/master/modules/exploits/linux/http/projectsend_unauth_rce.rb)\n##### Remediation\nFollow the vendor's [documentation](https://docs.projectsend.org/about/installation/upgrading) to upgrade to version r1720 or higher.",
                    "createdAt": "2025-01-21T08:32:13Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250100900",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-28986 - SolarWinds Web Help Desk Java Deserialization Remote Code Execution and Hardcoded Credential",
                    "description": "##### Description\nCVE-2024-28986: SolarWinds Web Help Desk versions 12.8.3 and before were found to be susceptible to a Java Deserialization Remote Code Execution vulnerability that, if exploited, would allow an unauthenticated attacker to run commands on the host machine. This has been observed as exploited in the wild by CISA. \n\nCVE-2024-28987: The SolarWinds Web Help Desk (WHD) software is affected by a hardcoded credential vulnerability, allowing remote unauthenticated user to access internal functionality and modify data. \n\n*Microsoft is able to detect a vulnerable version on scanned assets, but we are not  able to tell if the hotfix has been applied. If we detect your version as 12_8_3 please manually check to see if the hotfix is applied.*\n\n##### Related Intelligence\n- CVE: [CVE-2024-28986](https://security.microsoft.com/intel-explorer/cves/CVE-2024-28986/)\n- CVE: [CVE-2024-28987](https://security.microsoft.com/intel-explorer/cves/CVE-2024-28987/)\n- Security Advisory HF1 - Not recommended: [SolarWinds WHD Hotfix HF1](https://support.solarwinds.com/SuccessCenter/s/article/WHD-12-8-3-Hotfix-1)\n- Security Advisory HF2 - recommended: [Solarwinds WHD Hotfix 2](https://support.solarwinds.com/SuccessCenter/s/article/SolarWinds-Web-Help-Desk-12-8-3-Hotfix-2)\n- Hack Tool: [ysoserial - Java Deserialization Pen Testing Tool](https://github.com/frohoff/ysoserial)\n- Vulnerability Writeup: [Horizon3.ai](https://www.horizon3.ai/attack-research/cve-2024-28987-solarwinds-web-help-desk-hardcoded-credential-vulnerability-deep-dive/)\n\n##### Remediation\nFollow the [vendor's documentation](https://support.solarwinds.com/SuccessCenter/s/article/SolarWinds-Web-Help-Desk-12-8-3-Hotfix-2) to install the latest supported version for your release (if available), or to apply Hotfix 2 as listed in the link above.\n\nSolarWinds has two hot fixes available and is working on a new version release to remediate the vulnerability. Hotfix 1 has some known issues which are:\n- SAML Single Sign-On (SSO) no longer works after applying WHD 12.8.3 Hotfix 1.\n- WHD users cannot click the Upload button to attach files. \n- WHD users cannot click the Save or Cancel button during ticket creation.\n\nHotfix 2 does not have these issues, and also addresses a hardcoded credential vulnerability of CVE-2024-28987. Please apply Hotfix 2.",
                    "createdAt": "2024-08-20T08:56:20Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60312",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-49040 - Microsoft Exchange Server Spoofing Vulnerability",
                    "description": "##### Description\n A spoofing vulnerability identified in Microsoft Exchange Server versions 2016 and 2019.  This vulnerability arises from improper verification of the P2 FROM header during email transport, enabling malicious actors to craft emails that appear to originate from trusted sources. Exploiting this vulnerability can facilitate phishing attacks and other malicious activities. PoCs are available by Slonser.\n\n##### Related Intelligence\n- CVE: [CVE-2024-49040](https://security.microsoft.com/intel-explorer/cves/CVE-2024-49040/) \n- Security Advisory: [Microsoft](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2024-49040)\n- Vulnerability Research and PoCs: [Slonser](https://blog.slonser.info/posts/email-attacks/)\n\n##### Remediation\nFollow Microsoft's [documentation](https://learn.microsoft.com/en-us/exchange/plan-and-deploy/install-cumulative-updates?view=exchserver-2019) to install the November 2024 [security updates](https://techcommunity.microsoft.com/blog/exchange/released-november-2024-exchange-server-security-updates/4293125) to impacted Exchange Servers. The security update is available for the following versions:\n - Exchange Server 2019 [CU13](https://www.microsoft.com/en-us/download/details.aspx?id=106318) and [CU14](https://www.microsoft.com/en-us/download/details.aspx?id=106320)\n - Exchange Server 2016 [CU23](https://www.microsoft.com/en-us/download/details.aspx?id=106317)\nPlease see the information available in [Exchange Server non-RFC compliant P2 FROM header detection](https://learn.microsoft.com/en-us/exchange/plan-and-deploy/post-installation-tasks/security-best-practices/exchange-non-compliant-p2from-detection?view=exchserver-2019) after installing the update.",
                    "createdAt": "2025-02-12T03:45:17Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_250420500",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-4450 IBM WebSphere Application Server Remote Code Execution Vulnerability",
                    "description": "##### Description \nIBM WebSphere Application Server 8.5 and 9.0 traditional could allow a remote attacker to execute arbitrary code on the system with a specially-crafted sequence of serialized objects. Additionally, IBM noted that failed exploitation attempts can potentially lead to a denial of service condition.\n\n##### Related Intelligence\nCVE: [CVE-2020-4450](https://nvd.nist.gov/vuln/detail/CVE-2020-4450)\nSecurity Advisory: [IBM Security Bulliten](https://www.ibm.com/support/pages/security-bulletin-websphere-application-server-vulnerable-remote-code-execution-vulnerability-cve-2020-4450) \n\n##### Remediation\nFor WebSphere Application Server traditional and WebSphere Application Server Hypervisor Edition:\nFor V9.0.0.0 through 9.0.5.4:\nUpgrade to minimal fix pack levels as required by interim fix and then apply Interim Fix [PH25074](https://www.ibm.com/support/pages/node/6220276) or apply Fix Pack 9.0.5.5 or later \n\nFor V8.5.0.0 through 8.5.5.17:\nUpgrade to minimal fix pack levels as required by interim fix and then apply Interim Fix [PH25074](https://www.ibm.com/support/pages/node/6220276) or apply Fix Pack 8.5.5.18 or later",
                    "createdAt": "2021-02-19T04:50:56Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29421",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-24955 - Microsoft SharePoint Server Arbitrary Code Execution",
                    "description": "##### Description\nThis vulnerability allows remote attackers to execute arbitrary code on affected installations of Microsoft SharePoint. Authentication is required to exploit this vulnerability, and the user must have Site Owner permissions.\n\nThe specific flaw exists within the GenerateProxyAssembly method. The issue results from the lack of proper validation of a user-supplied string before using it to execute C# code. An attacker can inject arbitrary code by replacing the `/BusinessDataMetadataCatalog/BDCMetadata.bdcm` file in the web root directory to cause compilation of the injected code into an assembly that is subsequently executed by SharePoint.\n\n##### Related Intelligence\n- CVE: [CVE-2023-24955](https://nvd.nist.gov/vuln/detail/CVE-2023-24955)\n- Security Advisory: [MSRC](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-24955)\n- Initial Disclosure: [Nguyễn Tiến Giang (@testanull) of StarLabs SG  via Zero Day Initiative](https://www.zerodayinitiative.com/advisories/ZDI-23-883/)\n- Vulnerability Writeup:[StarLabs.sg](https://starlabs.sg/blog/2023/09-sharepoint-pre-auth-rce-chain/)\n\n##### Remediation\nMicrosoft recommends that organizations apply the May 2023 security update to the following impacted SharePoint Servers:\n\n- SharePoint Subscription [KB 5002390](https://support.microsoft.com/help/5002390)\n- SharePoint 2019 [KB 5002389](https://support.microsoft.com/help/5002389)\n- SharePoint 2016 [KB 5002397](https://support.microsoft.com/help/5002397)",
                    "createdAt": "2023-09-28T06:43:35Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_59806",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-27076 Microsoft SharePoint Server Authenticated Remote Code Execution Vulnerability",
                    "description": "##### Description \nA flaw within the processing of InfoPath attachments can allow an authenticated attacker to execute code on impacted SharePoint servers.\n\n##### Related Intelligence\nCVE: [CVE-2021-27076](https://nvd.nist.gov/vuln/detail/CVE-2021-27076)\n\nSecurity Advisory: [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-27076)\n\n##### Remediation\nTo remediate this SharePoint remote code execution vulnerability Microsoft recommends that customers apply the March 2021 security upgrade.\n",
                    "createdAt": "2021-04-12T10:12:04Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_35593",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-31209 Microsoft Exchange Server Spoofing Vulnerability",
                    "description": "##### Description \nA spoofing vulnerability exists within Exchange Server.  Microsoft has not released any further details surrounding the vulnerability.\n\n##### Related Intelligence\n[CVE-2021-31209](https://nvd.nist.gov/vuln/detail/CVE-2021-31209) \n\nSecurity Advisory: [Microsoft Security Advisory](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2021-31209) \n\nAdditional Information: [KB5003435: Description of the security update for Microsoft Exchange Server 2019, 2016, and 2013: May 11, 2021](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-may-11-2021-kb5003435-028bd051-b2f1-4310-8f35-c41c9ce5a2f1) \n\n##### Remediation\nMicrosoft recommends that organizations apply the May 2021 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU9\n- Exchange 2019 CU8\n- Exchange 2016 CU 20\n- Exchange 2016 CU 19\n- Exchange 2013 CU 23\n\nOrganizations not running one of the supported versions for the May 2021 security update must upgrade to a supported version above and then apply the update.\n",
                    "createdAt": "2021-05-12T01:27:14Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_38434",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-7961 Liferay Portal code execution",
                    "description": "##### Description \nLiferay Portal could allow a remote attacker to execute arbitrary code on the system, caused by unsafe deserialization in the JSON web services (JSONWS). By sending a specially crafted request, an attacker could exploit this vulnerability to execute arbitrary code on the system.\n\n##### Related Intelligence\nRiskIQ Article: https://community.riskiq.com/article/08425e11\n\nCVE: [CVE-2020-7961](https://nvd.nist.gov/vuln/detail/CVE-2020-7961#range-6249217)\n\nSecurity Advisory: [Liferay Advisory](https://portal.liferay.dev/learn/security/known-vulnerabilities)\n\n##### Used By\nFreakOut malware campaign\n\n##### Remediation\nOrganizations should patch to the following versions depending on the current version of Liferay Portal being used:\n   \n    7.2 to 7.2.1 or later\n    7.1 to 7.1.3 or later\n    7.0 to 7.0.6 or later\n    6.2 (or earlier) to 6.2.5 or later\n\nIf unable to patch to a remediated version a workaround exists by disabling the JSONWS by setting the portal.property to `jsonws.servlet.hosts.allowed=Not/Available`\n\n \n    \n",
                    "createdAt": "2021-06-21T07:18:44Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_40229",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "ProxyLogon - Microsoft Exchange Server Vulnerabilities (No Hotfix Available)",
                    "description": "##### Description \nMicrosoft has detected multiple 0-day exploits being used to attack on-premises versions of Microsoft Exchange Server in limited and targeted attacks. In the attacks observed, the threat actor used these vulnerabilities to access on-premises Exchange servers which enabled access to email accounts, and allowed installation of additional malware to facilitate long-term access to victim environments.\n\nThe following versions are impacted:\n- Microsoft Exchange Server 2013  \n- Microsoft Exchange Server 2016  \n- Microsoft Exchange Server 2019\n\n##### Related Intelligence\nRiskIQ Article: [HAFNIUM targeting Exchange Servers with 0-day exploits](https://community.riskiq.com/article/6d6dc10b) \n\nCVE: [CVE-2021-26855](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-26855),  [CVE-2021-26857](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-26857), [CVE-2021-26858](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-26858), [CVE-2021-27065](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-27065)\n\nSecurity Advisory: [Microsoft Security Advisory](https://msrc-blog.microsoft.com/2021/03/02/multiple-security-updates-released-for-exchange-server/)\n\nExploit: [ExploitDB](https://www.exploit-db.com/exploits/49637)\n\n##### Remediation\nMicrosoft has not released a hotfix for these versions of Microsoft Exchange server.  Microsoft recommends organizations prioritize updates to Exchange Servers that are externally facing. All affected Exchange Servers should ultimately be updated to the latest version where a hotfix exists.\n",
                    "createdAt": "2021-03-18T04:17:05Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_30761",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-22972 - VMware vRealize Automation Authentication Bypass Vulnerabilities",
                    "description": "##### Description\nCVE-2022-22972: Certain VMware products contain a critical authentication bypass vulnerability affecting local domain users which can be exploited to obtain admin privileges. \nCVE-2022-22973: VMware Workspace ONE Access and Identity Manager contain a high severity privilege escalation vulnerability. \n\nThese were reported by Bruno López of Innotec Security. Details are not know at this time, but these products have been actively targeted recently and it is anticipated that this vulnerability may be exploited in the near future. \n\n##### Update May 27 2022\nResearchers from Horizon3.ai discovered this vulnerability is due to the application taking action based on the HTTP Host headers. An attacker can send a malicious HTTP request that causes it to reach out to an attacker owned server on the internet for authentication. A PoC has been released and mass exploitation has started.\n\n##### Related Intelligence\nCVE: [CVE-2022-22972](https://nvd.nist.gov/vuln/detail/CVE-2022-22972)\nSecurity Advisory: [VMware VMSA-2022-0014](https://www.vmware.com/security/advisories/VMSA-2022-0014.html)\nFAQ: [VMware](https://core.vmware.com/vmsa-2022-0014-questions-answers-faq)\nEmergency Directive: [cisa.gov](https://www.cisa.gov/uscert/ncas/current-activity/2022/05/18/cisa-issues-emergency-directive-and-releases-advisory-related)\nWriteup: [Horizon3.ai](https://www.horizon3.ai/vmware-authentication-bypass-vulnerability-cve-2022-22972-technical-deep-dive/)\nPoC: [GitHub](https://github.com/horizon3ai/CVE-2022-22972)\n\n##### Remediation\nPlease see the VMware Hotfix Download Locations table within their [KB 88438](https://kb.vmware.com/s/article/88438) article for a list of vulnerable versions, the associated patches, and installation instructions, and workarounds.",
                    "createdAt": "2022-05-20T07:50:32Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_54330",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-43798 - Grafana Path Traversal",
                    "description": "##### Description\n\nA path traversal vulnerability can allow an unauthenticated attacker to read files outside the Grafana application’s folder.  It is very easy to exploit and is under active exploitation.  All Grafana self-hosted servers running 8.x versions of the software are considered vulnerable.  [Grafana Cloud](https://grafana.com/cloud/?pg=blog) was not vulnerable.\n\nAn attacker can abuse Grafana plugin URLs to escape the Grafana app folder and gain access to files stored on the underlying server, such as files storing passwords and configuration settings—details that the attacker could weaponize in subsequent attacks.\n\nThe issue was patched with the release of Grafana 8.3.1, 8.2.7, 8.1.8, and 8.0.7. In its [patch notes](https://grafana.com/blog/2021/12/07/grafana-8.3.1-8.2.7-8.1.8-and-8.0.7-released-with-high-severity-security-fix/), Grafana Labs said that its cloud-hosted Grafana dashboards were not impacted by this vulnerability, which benefited from additional security protections.\n\n##### Related Intelligence\n\nCVE: [CVE-2021-43798](https://nvd.nist.gov/vuln/detail/CVE-2021-43798) \nSecurity Advisory: [Grafana Blog](https://grafana.com/blog/2021/12/07/grafana-8.3.1-8.2.7-8.1.8-and-8.0.7-released-with-high-severity-security-fix/)]\nArticle: [The Record](https://therecord.media/grafana-releases-security-patch-after-exploit-for-severe-bug-goes-public/)\nPoC: [GitHub](https://github.com/jas502n/Grafana-CVE-2021-43798)\n\n##### Remediation\n\nAll installations between v8.0.0-beta1 and v8.3.0 should be upgraded as soon as possible.  Apply the upgrade that most closely matches your version.\n\n-   [Download Grafana 8.3.1](https://grafana.com/grafana/download/8.3.1/?pg=blog)\n-   [Download Grafana 8.2.7](https://grafana.com/grafana/download/8.2.7/?pg=blog)\n-   [Download Grafana 8.1.8](https://grafana.com/grafana/download/8.1.8/?pg=blog)\n-   [Download Grafana 8.0.7](https://grafana.com/grafana/download/8.0.7/?pg=blog)\n\nIf you cannot upgrade, running a reverse proxy in front of Grafana that normalizes the PATH of the request will mitigate the vulnerability. For example, the [normalize_path](https://www.envoyproxy.io/docs/envoy/latest/api-v3/extensions/filters/network/http_connection_manager/v3/http_connection_manager.proto#envoy-v3-api-field-extensions-filters-network-http-connection-manager-v3-httpconnectionmanager-normalize-path) setting in envoy.",
                    "createdAt": "2021-12-09T07:39:21Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_46382",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-8621 ISC BIND 9 DDoS Vulnerability",
                    "description": "##### Description \nIf a server is configured with both QNAME minimization and 'forward first' then an attacker who can send queries to it may be able to trigger the condition that will cause the server to crash. Servers that 'forward only' are not affected.\n\n##### Related Intelligence\nRiskIQ Article: [ISC Releases Patches Addressing Multiple Denial of Service Vulnerabilities in BIND 9](https://community.riskiq.com/article/4087d879) \nCVE: [CVE-2020-8621](https://nvd.nist.gov/vuln/detail/CVE-2020-8621) \nSecurity Advisory: [ISC Advisory](https://kb.isc.org/docs/cve-2020-8621) \n\n##### Remediation\nUpgrade to the patched release most closely related to your current version of BIND:\n- BIND 9.16.6\n- BIND 9.17.4",
                    "createdAt": "2021-02-19T04:48:19Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29407",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-27898 - Jenkins Unauthenticated XSS to Remote Code Execution",
                    "description": "##### Description\nJenkins servers running versions 2.270 through 2.393 (both inclusive), LTS 2.277.1 through 2.375.3 (both inclusive) are vulnerable, along with Jenkins Update Centers with versions below 3.15.\n\nThe vulnerabilities are achieved through a stored XSS exploitable by a Jenkins plugin with a malicious core version, which attackers upload to the [Jenkins Update Center](https://github.com/jenkins-infra/update-center2/releases/tag/update-center2-3.15). Once the victim opens the Available Plugin Manager on their Jenkins Server, the XSS is triggered, allowing attackers to run arbitrary code on the Jenkins Server utilizing the [Script](https://www.jenkins.io/doc/book/managing/script-console/) [](https://www.jenkins.io/doc/book/managing/script-console/)[Console API](https://www.jenkins.io/doc/book/managing/script-console/).\n\n##### Related Intelligence\n- CVE: [CVE-2023-27898](https://nvd.nist.gov/vuln/detail/CVE-2023-27898)\n- CVE: [CVE-2023-27905](https://nvd.nist.gov/vuln/detail/CVE-2023-27905)\n- Security Advisory: [Jenkins](https://www.jenkins.io/security/advisory/2023-03-08/)\n- Vulnerability Writeup: [AquaSec](https://blog.aquasec.com/jenkins-server-vulnerabilities)\n\n##### Remediation\n- Jenkins weekly should be updated/reinstalled to version [2.394](https://www.jenkins.io/doc/book/installing/)\n- Jenkins LTS should be updated to version [2.375.4 or 2.387.1](https://www.jenkins.io/doc/upgrade-guide/)\n- If using a self-hosted Jenkins Update Center, it should be updated to version [3.15](https://github.com/jenkins-infra/update-center2)",
                    "createdAt": "2023-03-09T08:09:24Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58756",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2023-40044 - WS_FTP Server Ad Hoc Transfer Unauthorized Deserialization",
                    "description": "##### Description\nIn WS_FTP Server versions prior to 8.7.4 and 8.8.2, a pre-authenticated attacker could leverage a .NET deserialization vulnerability in the Ad Hoc Transfer module to execute remote commands on the underlying WS_FTP Server operating system. An attacker can craft a malicious HTTP POST request with a crafted payload to trigger arbitrary command injection. Exploitation has been observed in the wild and Microsoft recommend's patching as soon as possible.\n\nSystems that have disabled the ad hoc transfer HTTP module are not cannot be exploited by this vulnerability. This does not affect the WS_FTP file transfer services running by default on port 21 or 22.\n\n##### Related Intelligence\n- CVE: [CVE-2023-40044](https://nvd.nist.gov/vuln/detail/CVE-2023-40044)\n- CVE: [CVE-2023-42657](https://nvd.nist.gov/vuln/detail/CVE-2023-42657)\n- Security Advisory: [Progress](https://community.progress.com/s/article/WS-FTP-Server-Critical-Vulnerability-September-2023)\n- Initial Disclosure and Detailed Writeup: [Assetnote](https://www.assetnote.io/resources/research/rce-in-progress-ws-ftp-ad-hoc-via-iis-http-modules-cve-2023-40044)\n\n##### Remediation\nUpgrade to one of the versions listed below by using the full installer, which will bring the system down while it updates. \n\nWS_FTP Server 2020.0.4 (8.7.4) \n- [Upgrade Documentation](https://community.progress.com/s/article/How-do-I-upgrade-WS-FTP-Server)\n- [WS_FTP Server 2020 release notes](https://docs.ipswitch.com/WS_FTP_Server2020/ReleaseNotes/index.htm)|\nWS_FTP Server 2022.0.2 (8.8.2)\n- [Upgrade Documentation](https://community.progress.com/s/article/How-do-I-upgrade-WS-FTP-Server)\n- [WS_FTP Server 2022 release notes](https://docs.ipswitch.com/WS_FTP_Server2022/ReleaseNotes/index.htm)\n\nAs a workaround to applying patches, admins may disable the ad hoc transfer module by following this [vendor documentation](https://community.progress.com/s/article/Removing-or-Disabling-the-WS-FTP-Server-Ad-hoc-Transfer-Module).",
                    "createdAt": "2024-08-01T08:20:34Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60232",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-32305 - WebSVN Unauthenticated Command Injection",
                    "description": "##### Description\n\nIn versions of WebSVN prior to 2.6.1, the user’s search query is not escaped when it is used in a shell command. Inside include/svnlook.php the function getListSearch is responsible for creating the shell command by concatenating the search query with command arguments. A function called runCommand inside include/command.php finally executes the command by passing it to PHP’s proc_open function. Without properly escaping the user’s input, it is possible to achieve code execution by including special characters in the search query. \n\n##### Related Intelligence\n\nCVE: [CVE-2021-32305](https://nvd.nist.gov/vuln/detail/CVE-2021-32305) \nSecurity Advisory: [Palo Alto Unit42](https://unit42.paloaltonetworks.com/cve-2021-32305-websvn/)\n\n##### Remediation\n\nDownload the release 2.6.1 or greater from [GitHub](https://github.com/websvnphp/websvn/releases) and [install](https://websvnphp.github.io/docs/install.html) it.  To see a list of code changes refer to [GitHub](https://github.com/websvnphp/websvn/compare/2.6.0...2.6.1).\n",
                    "createdAt": "2021-09-24T01:17:37Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_43328",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-27198 & CVE-2024-27199 - TeamCity Critical Auth Bypass and Path Traversal",
                    "description": "##### Description\nAn authentication bypass has been found allowing an attacker to reach admin level functions within the API endpoints. Auth can be bypassed by inserting the desired endpoint, such as `/app/rest/users`, in a request to a non-existing URL path that does not exist, as long as the request also ends with a `;.jsp`. An example of this is `/thisdoesnotexist?jsp=/app/rest/users;.jsp`.\n\nA path traversal also exists allowing an unauthenticated attacker to request authenticated resources. This only applies to certain paths including, but not limited to: \n- `/res/`\n- `/update`\n- `.well-known/acme-challenge/`\n\nAll versions of TeamCity 2023.11.3 and prior are affected by these vulnerabilities. To resolve this issue update your servers to 2023.11.4 or higher. \n\n##### Related Intelligence\n- CVE: [CVE-2024-27198](https://ti.defender.microsoft.com/cves/CVE-2024-27198/)\n- CVE: [CVE-2024-27199](https://ti.defender.microsoft.com/cves/CVE-2024-27199/)\n- Security Advisory: [JetBrains TeamCity Blog](https://blog.jetbrains.com/teamcity/2024/03/additional-critical-security-issues-affecting-teamcity-on-premises-cve-2024-27198-and-cve-2024-27199-update-to-2023-11-4-now/)\n- Vulnerability Writeup and PoC: [Rapid7](https://www.rapid7.com/blog/post/2024/03/04/etr-cve-2024-27198-and-cve-2024-27199-jetbrains-teamcity-multiple-authentication-bypass-vulnerabilities-fixed/)\n\n##### Remediation\nTo update your server, [download the latest version](https://www.jetbrains.com/teamcity/download/other.html) (2023.11.4) or use the [automatic update](https://www.jetbrains.com/help/teamcity/upgrading-teamcity-server-and-agents.html#Automatic+Update) option within TeamCity.\n\nIf you are unable to update your server to version 2023.11.4, JetBrains have also released a security patch plugin so that you can still patch your environment. The security patch plugin can be downloaded using one of the links below and installed on all TeamCity versions through 2023.11.3. It will patch the vulnerabilities described above.\n\nSecurity patch plugin: [TeamCity 2018.2 and newer](https://download.jetbrains.com/teamcity/plugins/internal/security_patch_2024_02.zip) | [TeamCity 2018.1 and older](https://download.jetbrains.com/teamcity/plugins/internal/security_patch_2024_02_pre2018_2.zip)\n\nSee the [TeamCity plugin installation instructions](https://www.jetbrains.com/help/teamcity/installing-additional-plugins.html#Installing+Plugin+via+Web+UI) for information on installing the plugin.",
                    "createdAt": "2024-03-05T03:14:16Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60136",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-31207 Microsoft Exchange Server Security Feature Bypass Vulnerability",
                    "description": "##### Description \nA security feature bypass vulnerability exists within Exchange Server that could allow an authenticated remote attacker with elevated privileges access to the server.  Microsoft has not released any further details surrounding the vulnerability.\n\n##### Related Intelligence\n[CVE-2021-31207](https://nvd.nist.gov/vuln/detail/CVE-2021-31207), \n\nSecurity Advisory: [Microsoft Security Advisory](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2021-31207) \n\nAdditional Information: [KB5003435: Description of the security update for Microsoft Exchange Server 2019, 2016, and 2013: May 11, 2021](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-microsoft-exchange-server-2019-2016-and-2013-may-11-2021-kb5003435-028bd051-b2f1-4310-8f35-c41c9ce5a2f1) \n\n##### Remediation\nMicrosoft recommends that organizations apply the May 2021 security update to impacted Exchange Servers.  The security update is available for the following versions:\n\n- Exchange 2019 CU9\n- Exchange 2019 CU8\n- Exchange 2016 CU 20\n- Exchange 2016 CU 19\n- Exchange 2013 CU 23\n\nOrganizations not running one of the supported versions for the May 2021 security update must upgrade to a supported version above and then apply the update.",
                    "createdAt": "2021-05-12T01:27:12Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_38433",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-8623 ISC BIND 9 DDoS Vulnerability",
                    "description": "##### Description \nAn attacker that can reach a vulnerable system with a specially crafted query packet can trigger a crash. To be vulnerable, the system must: * be running BIND that was built with \"\"--enable-native-pkcs11\"\" * be signing one or more zones with an RSA key * be able to receive queries from a possible attacker.\n\n##### Related Intelligence\nRiskIQ Article: [ISC Releases Patches Addressing Multiple Denial of Service Vulnerabilities in BIND 9](https://community.riskiq.com/article/4087d879) \nCVE: [CVE-2020-8623](https://nvd.nist.gov/vuln/detail/CVE-2020-8623) \nSecurity Advisory: [ISC Advisory](https://kb.isc.org/docs/cve-2020-8623) \n\n##### Remediation\nUpgrade to the patched release most closely related to your current version of BIND:\n- BIND 9.11.22\n- BIND 9.16.6\n- BIND 9.17.4\n\nBIND Supported Preview Edition is a special feature preview branch of BIND provided to eligible ISC support customers.\n- BIND 9.11.22-S1",
                    "createdAt": "2021-02-19T04:48:53Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_29409",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "VMware ESXi System Exposure",
                    "description": "##### Description\nVMware ESXi devices exposed to the internet increase an organization's attack surface. Appropriate network isolation is critical to securely configuring VMware ESXi devices. Exposed ESXi devices are more vulnerable to unwanted access, exploitation of vulnerabilities, brute force attacks, malware infection, and data leakage, leading to a variety of risks. These risks include data theft, data corruption, server takeover or malfunction, malware infection that could propagate through the network, and data leakage. \n\n##### Related Intelligence\n- Networking Security Recommendations: [VMware](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.security.doc/GUID-603AF714-ABD7-429D-8B93-1701F5A80F64.html)\n- Threat Intel: [Microsoft - Vulnerability Exploitation](https://www.microsoft.com/en-us/security/blog/2024/07/29/ransomware-operators-exploit-esxi-hypervisor-vulnerability-for-mass-encryption/?msockid=35f40eb7439b653712d91f2b42cc64f5)\n\n##### Remediation\nVMware ESXi should be placed behind a VPN, bastion host, or jump box to control access to the management network. ",
                    "createdAt": "2024-08-08T04:58:50Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_60237",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2022-37961 - Microsoft SharePoint Server Authenticated Remote Code Execution Via Manage List",
                    "description": "##### Description\nA vulnerability in SharePoint Server 2016 and 2019 allows an authenticated attacker with Manage List permissions could execute code remotely on the SharePoint Server.  An attacker with access to low-privilege credentials can leverage this vulnerability to execute code in the context of Administrator.\n\n##### Related Intelligence\nCVE: [CVE-2022-37961](https://nvd.nist.gov/vuln/detail/CVE-2022-37961) \nCVE: [CVE-2022-38008](https://nvd.nist.gov/vuln/detail/CVE-2022-38008) \nCVE: [CVE-2022-38009](https://nvd.nist.gov/vuln/detail/CVE-2022-38009) \nCVE: [CVE-2022-35823](https://nvd.nist.gov/vuln/detail/CVE-2022-35823)\nSecurity Advisory: [MSRC](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-37961)\n\n##### Remediation\nMicrosoft recommends that organizations apply the September 2022 security update to impacted SharePoint Servers.  The security update is available for the following versions:\n\n- SharePoint Subscription Edition\n- SharePoint 2019\n- SharePoint 2016\n- SharePoint 2013 SP 1\n\nPlease see the [Microsoft Security Advisory](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-37961) for a download links.",
                    "createdAt": "2022-09-15T07:01:26Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_57146",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "ASI: CVE-2021-41277 Metabase Local File Inclusion",
                    "description": "##### Description\nMetabase versions x.40.0-x.40.4 contain a security issue with the custom GeoJSON map (`admin->settings->maps->custom maps->add a map`) support and potential local file inclusion. This allows an unauthenticated remote attacker to read local files with potentially confidential information such as /etc /passwd or other app specific files.\n\n##### Related Intelligence\n- CVE: [CVE-2021-41277](https://nvd.nist.gov/vuln/detail/CVE-2021-41277)\n- Security Advisory: [GitHub GHSA](https://github.com/metabase/metabase/security/advisories/GHSA-w73v-6p7p-fpfr)\n- Vulnerability Writeup: [Can1337](https://infosecwriteups.com/tackling-cve-2021-41277-using-a-vulnerability-database-5e960b8a07c5)\n- PoC Code: [GitHub](https://github.com/tahtaciburak/CVE-2021-41277)\n\n##### Remediation\nUpdate Metabase to release (0.40.5 or 1.40.5), and any subsequent release after that (including x.41+). Vendor instructions on how to update can be found [here](https://www.metabase.com/docs/latest/installation-and-operation/upgrading-metabase).",
                    "createdAt": "2022-12-16T03:55:27Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_58255",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2024-38094 - SharePoint Authenticated Arbitrary Code Execution",
                    "description": "##### Description\nOn July 9th 2024, Microsoft issued a patch to address a deserialization vulnerability for SharePoint Subscription Edition, SharePoint 2019, and SharePoint 2016. An authenticated attacker with Site Owner permissions or higher could upload a specially crafted file to the targeted SharePoint Server and craft specialized API requests to trigger deserialization of file's parameters. This can also be triggered over the web interface. This would enable the attacker to perform remote code execution in the context of the SharePoint Server. \n\nThis has been observed as exploited in the wild by CISA. [Rapid7](https://www.rapid7.com/blog/post/2024/10/30/investigating-a-sharepoint-compromise-ir-tales-from-the-field/) has an article detailing post exploit activity for further reference.  These vulnerabilities are listed as:\n- CVE-2024-38094\n- CVE-2024-38023\n- CVE-2024-38024\n\n**CVE-2024-32987**:  Also addressed in this patch is a server side request forgery vulnerability that results in information disclosure. The type of information that could be disclosed if an attacker successfully exploited this vulnerability is data inside the targeted website like IDs, tokens, cryptographic nonces, and other sensitive information. As of the time of writing (December 16th 2024), this has not been observed as exploited.\n\n##### Related Intelligence\n- CVE: [CVE-2024-38094](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38094/)\n- CVE: [CVE-2024-38023](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38023/)\n- CVE: [CVE-2024-38024](https://security.microsoft.com/intel-explorer/cves/CVE-2024-38024/)\n- CVE: [CVE-2024-32987](https://security.microsoft.com/intel-explorer/cves/CVE-2024-32987/)\n- Security Advisory: [SharePoint Subscription Edition](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-sharepoint-server-subscription-edition-july-9-2024-kb5002606-37569899-5abc-49a2-bd5e-f0ae45528f8f)\n- Security Advisory: [SharePoint 2019](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-sharepoint-server-2019-july-9-2024-kb5002615-6d31fcef-a998-43aa-947d-f2dd60e1c758)\n- Security Advisory: [SharePoint 2016](https://support.microsoft.com/en-us/topic/description-of-the-security-update-for-sharepoint-enterprise-server-2016-july-9-2024-kb5002618-422e4b6a-4cde-4a3c-a446-75f3125bbbfc)\n- Threat Intel: [Rapid7](https://www.rapid7.com/blog/post/2024/10/30/investigating-a-sharepoint-compromise-ir-tales-from-the-field/)\n- PoC Writeup: [Foresiet](https://foresiet.com/blog/understanding-sharepoint-remote-code-execution-exploits)\n- PoC: [GitHub TestaNull](https://github.com/testanull/MS-SharePoint-July-Patch-RCE-PoC)\n\n##### Remediation\nMicrosoft recommends that organizations apply the July 2024 security update or newer for your supported version of SharePoint.\n- [Download security update 5002606 for the 64-bit version of SharePoint Server Subscription Edition](http://www.microsoft.com/download/details.aspx?familyid=79a55ec9-bad3-44c2-bd0e-843f637f43a7)\n- [Download security update 5002615 for the 64-bit version of SharePoint Server 2019](http://www.microsoft.com/download/details.aspx?familyid=a981cd4e-a4a7-4b75-85c3-6708c75ec97e)\n- [Download security update 5002618 for the 64-bit version of SharePoint Enterprise Server 2016](https://www.microsoft.com/download/details.aspx?id=106147)",
                    "createdAt": "2024-12-20T12:48:10Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_243540300",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2021-44228 - Metabase Log4J Unauthenticated Remote Code Execution",
                    "description": "##### Description\nMetabase uses Log4J and inherits this vulnerability. On December 9, 2021, researchers shared details of a Java Naming and Directory Interface (JNDI) injection vulnerability affecting [Apache Log4j](https://logging.apache.org/log4j/2.x/index.html) versions 2.0 to 2.14.1. Specifically, by issuing requests to the server, the LDAP JDNI parser will allow for loading arbitrary content. This vulnerability is present when message substitution is configured. According to NIST, this behavior has been disabled by default as of Log4j 2.15.0. This vulnerability is being tracked as CVE-2021-44228. This vulnerability has been referred to as Log4Shell by some outlets.\n\n##### Related Intelligence\nCVE: [CVE-2021-44228](https://nvd.nist.gov/vuln/detail/CVE-2021-44228)\nVulnerability Writeup: [RiskIQ](https://ti.defender.microsoft.com/articles/505098fc)\nSecurity Advisory: [Metabase on GitHub](https://github.com/metabase/metabase/security/advisories/GHSA-vmm4-cwrm-38rj)\n\n##### Remediation\nUpdate to patched version of Metabase as per the table below:\n-   0.41.4 and 1.41.4\n-   0.40.7 and 1.40.7\n-   0.39.7 and 1.39.7\n-   0.38.6 and 1.38.6\n\n*Workaround*\nIf you’re unable to upgrade immediately you can mitigate the log4j issue you can set the Java property `log4j2.formatMsgNoLookups=true`\n-   JAR example: `java ... -Dlog4j2.formatMsgNoLookups=true ... -jar metabase.jar`\n-   Docker example: `docker run ... -e JAVA_OPTS=\"-Dlog4j2.formatMsgNoLookups=true\" ...`",
                    "createdAt": "2022-09-08T09:04:33Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56987",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "CVE-2020-17496 - vBulletin Unauthenticated Remote Code Execution",
                    "description": "##### Description\n\nvBulletin 5.5.4 through 5.6.2 allows remote command execution via crafted subWidgets data in an ajax/render/widget_tabbedcontainer_tab_panel request. NOTE: this issue exists because of an incomplete fix for CVE-2019-16759.  This vulnerability has been publicly exploited and the exploit is available in Metasploit.  \n\n##### Related Intelligence\n\nRiskIQ Article: [Exploits in the Wild for vBulletin Pre-Auth RCE Vulnerability]](https://community.riskiq.com/article/f04ff01b)\n\nCVE: [CVE-2020-17496](https://nvd.nist.gov/vuln/detail/CVE-2020-17496)\n\nSecurity Advisory: [vBulletin Announcement](https://forum.vbulletin.com/forum/vbulletin-announcements/vbulletin-announcements_aa/4445227-vbulletin-5-6-0-5-6-1-5-6-2-security-patch)\n\n##### Remediation\n\nOrganizations using vBulletin should ensure that they upgrade to the latest available [patch](https://members.vbulletin.com/patches.php)\n",
                    "createdAt": "2021-08-13T04:03:47Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_41990",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                },
                {
                    "displayName": "GitLab CVE-2022-2185 Authenticated Code Execution from Project Imports",
                    "description": "##### Description\nA critical issue has been discovered in GitLab affecting all versions starting from 14.0 *prior to 14.10.5*, 15.0 *prior to 15.0.4*, and 15.1 *prior to 15.1.1* where an authenticated user authorized to import projects could import a maliciously crafted project leading to remote code execution. This was reported by [vakzz](https://hackerone.com/vakzz) through the HackerOne bug bounty program.\n\n##### Related Intelligence\nCVE: [CVE-2022-2185](https://nvd.nist.gov/vuln/detail/CVE-2022-2185)\nSecurity Advisory: [GitLab](https://about.gitlab.com/releases/2022/06/30/critical-security-release-gitlab-15-1-1-released/)\nHackerOne: [Report](https://hackerone.com/reports/1609965)\nVulnerability Writeup: [StarLabs](https://starlabs.sg/blog/2022/07-gitlab-project-import-rce-analysis-cve-2022-2185/)\n\n##### Remediation\nFollow [GitLab's directions](https://about.gitlab.com/update/) for upgrading to the latest version based on your deployment method. ",
                    "createdAt": "2022-07-14T08:07:24Z",
                    "updatedAt": "2025-04-02T02:40:22Z",
                    "metricCategory": null,
                    "metric": "savedfilter_metric_56055",
                    "filter": null,
                    "labelName": null,
                    "count": 0,
                    "link": null,
                    "children": null
                }
            ]
        }
    ]
}
```

## 5. Create logic app
### 1. Choose the plan <br>
![image](https://github.com/user-attachments/assets/6bbf0a66-e5d4-46de-bcdb-a513cba488f6)

### 2. Add `Recurrence` <br>
![image](https://github.com/user-attachments/assets/a462fdf9-d87f-45d0-85cf-99dc2cf64bb5)

### 3. Add action `HTTP` <br>
![image](https://github.com/user-attachments/assets/63f297f7-05b4-4a0a-915b-9032423c5fe5)

URL <br>
```
{endpoint}/cisaCves?api-version=2024-10-01-preview
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

### 4. Add action > parse json
![image](https://github.com/user-attachments/assets/f4e2eaeb-1c76-4d79-918a-18310e2ae6c8)

![image](https://github.com/user-attachments/assets/5e360ae0-993e-4db4-8d4e-69776bd7fe2c)

![image](https://github.com/user-attachments/assets/71baaeab-7481-4c26-9d46-593dac035d47)

Use sample json with high priority findings `above` to generate schema <br>

![image](https://github.com/user-attachments/assets/661c2eda-4490-47fc-9e8c-87f36e02a7d2)

### 5. Add action > `Filter array` (Optional if you want to configure condition)
In `From` Section, add the function below
```
first(body('Parse_JSON_High')?['assetSummaries'])?['children']
```
For the part `Parse_JSON_High`, please replace it with the exact step name in your flow. <br>
![image](https://github.com/user-attachments/assets/25cb83f3-24f6-480c-b7e0-6982483dcd80)

In `Filter Query` Section, add below:
```
item()?['count']
```
![image](https://github.com/user-attachments/assets/eade3fcc-e673-4211-812a-7aff3af2834f)

Complete the condition `Greater than 0`
![image](https://github.com/user-attachments/assets/f40fb039-4108-4585-a3a8-403b1d3cb686)


### 6. Add action > `Create HTML table`
![image](https://github.com/user-attachments/assets/4c8628f6-f052-436c-9fcf-e6f0e04ea91c)

### 7. Add action > `Send an email (V2)`
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

### 7. Test logic app
Sample in my mail (it only outputs findings under Chidlren section whose count is greater than 0) <br>
![image](https://github.com/user-attachments/assets/66feda75-15c1-4141-ac5b-040752edaf89)


