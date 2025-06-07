# 🚨 Retrieve Analytics Rule Query from Microsoft Sentinel Incident Trigger (Logic App)

## 🛠️ Preparation Steps

Before configuring your Logic App to retrieve analytics rule queries from Microsoft Sentinel incidents, ensure the following setup is complete:

### 1. Enable System-Assigned Managed Identity

Enable the **system-assigned managed identity** for your Logic App so it can securely authenticate with Azure services.

🔗 [How to enable managed identity in Logic Apps](https://learn.microsoft.com/en-us/azure/logic-apps/authenticate-with-managed-identity?tabs=consumption)

### 2. Assign the `Microsoft Sentinel Contributor` Role

Grant your Logic App's managed identity the **Microsoft Sentinel Contributor** role. You can assign this role at the **resource group level** or **Sentinel workspace level**, depending on your scoping needs.

🔗 [Microsoft Sentinel built-in roles and permissions](https://learn.microsoft.com/en-us/azure/sentinel/roles)

> 💡 **Recommendation**: Assign the role at the **resource group level** that contains the Microsoft Sentinel workspace. This ensures access to all related resources (such as the workspace, playbooks, and analytics rules) in one scope.

---

### 🧾 Microsoft Sentinel Role Summary

| Role                       | Description                                                                                          |
| -------------------------- | ---------------------------------------------------------------------------------------------------- |
| **Sentinel Reader**        | View data, incidents, workbooks, and Sentinel resources.                                             |
| **Sentinel Responder**     | All Reader permissions + ability to manage incidents (assign, dismiss, etc.).                        |
| **Sentinel Contributor**   | All Responder permissions + create/edit Sentinel resources, analytics rules, install solutions, etc. |
| **Playbook Operator**      | List, view, and manually run Sentinel playbooks.                                                     |
| **Automation Contributor** | Allows Sentinel to attach playbooks to automation rules (not intended for user accounts).            |

---

## 🚀 Start Building the Logic App Workflow

With the prerequisites complete, you're ready to start building the Logic App that retrieves analytics rule queries from Microsoft Sentinel incidents.
## 🔁 Step 1: Trigger — Microsoft Sentinel Incident

Use the **Microsoft Sentinel incident trigger** as the first step in your Logic App.

![image](https://github.com/user-attachments/assets/7a090e5b-337a-4b36-9948-95c0f3296d37)

---

## 📦 Step 2: Add Action — Parse JSON (Data Operations)

Insert a **Parse JSON** action right after the trigger to extract the incident payload.

![image](https://github.com/user-attachments/assets/710cbf1c-59b3-45be-a2c6-950a28b4ccd6)

* **Content**: Select `body` from the output of the Sentinel incident trigger.

  ![image](https://github.com/user-attachments/assets/9b302155-16d2-4b12-b4c7-5d1a063f3683)

* **Schema**: Use the full JSON schema below to parse the incident object.

<details>
  <summary>Click to expand JSON schema</summary>

```json
{
  "type": "object",
  "properties": {
    "eventUniqueId": {
      "type": "string"
    },
    "objectSchemaType": {
      "type": "string"
    },
    "objectEventType": {
      "type": "string"
    },
    "workspaceInfo": {
      "type": "object",
      "properties": {
        "SubscriptionId": {
          "type": "string"
        },
        "ResourceGroupName": {
          "type": "string"
        },
        "WorkspaceName": {
          "type": "string"
        }
      }
    },
    "workspaceId": {
      "type": "string"
    },
    "object": {
      "type": "object",
      "properties": {
        "id": {
          "type": "string"
        },
        "name": {
          "type": "string"
        },
        "etag": {
          "type": "string"
        },
        "type": {
          "type": "string"
        },
        "properties": {
          "type": "object",
          "properties": {
            "title": {
              "type": "string"
            },
            "severity": {
              "type": "string"
            },
            "status": {
              "type": "string"
            },
            "owner": {
              "type": "object",
              "properties": {
                "objectId": {},
                "email": {},
                "assignedTo": {},
                "userPrincipalName": {}
              }
            },
            "labels": {
              "type": "array"
            },
            "firstActivityTimeUtc": {
              "type": "string"
            },
            "lastActivityTimeUtc": {
              "type": "string"
            },
            "lastModifiedTimeUtc": {
              "type": "string"
            },
            "createdTimeUtc": {
              "type": "string"
            },
            "incidentNumber": {
              "type": "integer"
            },
            "additionalData": {
              "type": "object",
              "properties": {
                "alertsCount": {
                  "type": "integer"
                },
                "bookmarksCount": {
                  "type": "integer"
                },
                "commentsCount": {
                  "type": "integer"
                },
                "alertProductNames": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "tactics": {
                  "type": "array"
                },
                "techniques": {
                  "type": "array"
                }
              }
            },
            "relatedAnalyticRuleIds": {
              "type": "array",
              "items": {
                "type": "string"
              }
            },
            "incidentUrl": {
              "type": "string"
            },
            "providerName": {
              "type": "string"
            },
            "providerIncidentId": {
              "type": "string"
            },
            "alerts": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "id": {
                    "type": "string"
                  },
                  "name": {
                    "type": "string"
                  },
                  "type": {
                    "type": "string"
                  },
                  "kind": {
                    "type": "string"
                  },
                  "properties": {
                    "type": "object",
                    "properties": {
                      "systemAlertId": {
                        "type": "string"
                      },
                      "tactics": {
                        "type": "array"
                      },
                      "alertDisplayName": {
                        "type": "string"
                      },
                      "confidenceLevel": {
                        "type": "string"
                      },
                      "severity": {
                        "type": "string"
                      },
                      "vendorName": {
                        "type": "string"
                      },
                      "productName": {
                        "type": "string"
                      },
                      "productComponentName": {
                        "type": "string"
                      },
                      "alertType": {
                        "type": "string"
                      },
                      "processingEndTime": {
                        "type": "string"
                      },
                      "status": {
                        "type": "string"
                      },
                      "endTimeUtc": {
                        "type": "string"
                      },
                      "startTimeUtc": {
                        "type": "string"
                      },
                      "timeGenerated": {
                        "type": "string"
                      },
                      "providerAlertId": {
                        "type": "string"
                      },
                      "resourceIdentifiers": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "properties": {
                            "type": {
                              "type": "string"
                            },
                            "workspaceId": {
                              "type": "string"
                            }
                          },
                          "required": [
                            "type",
                            "workspaceId"
                          ]
                        }
                      },
                      "additionalData": {
                        "type": "object",
                        "properties": {
                          "Query Period": {
                            "type": "string"
                          },
                          "Trigger Operator": {
                            "type": "string"
                          },
                          "Trigger Threshold": {
                            "type": "string"
                          },
                          "Correlation Id": {
                            "type": "string"
                          },
                          "Search Query Results Overall Count": {
                            "type": "string"
                          },
                          "Data Sources": {
                            "type": "string"
                          },
                          "Query": {
                            "type": "string"
                          },
                          "OriginalQuery": {
                            "type": "string"
                          },
                          "Query Start Time UTC": {
                            "type": "string"
                          },
                          "Query End Time UTC": {
                            "type": "string"
                          },
                          "Analytic Rule Ids": {
                            "type": "string"
                          },
                          "Event Grouping": {
                            "type": "string"
                          },
                          "Analytic Rule Name": {
                            "type": "string"
                          },
                          "ProcessedBySentinel": {
                            "type": "string"
                          },
                          "Alert generation status": {
                            "type": "string"
                          }
                        }
                      },
                      "friendlyName": {
                        "type": "string"
                      }
                    }
                  }
                },
                "required": [
                  "id",
                  "name",
                  "type",
                  "kind",
                  "properties"
                ]
              }
            },
            "bookmarks": {
              "type": "array"
            },
            "relatedEntities": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "id": {
                    "type": "string"
                  },
                  "name": {
                    "type": "string"
                  },
                  "type": {
                    "type": "string"
                  },
                  "kind": {
                    "type": "string"
                  },
                  "properties": {
                    "type": "object",
                    "properties": {
                      "domainName": {
                        "type": "string"
                      },
                      "friendlyName": {
                        "type": "string"
                      }
                    }
                  }
                },
                "required": [
                  "id",
                  "name",
                  "type",
                  "kind",
                  "properties"
                ]
              }
            },
            "comments": {
              "type": "array"
            }
          }
        }
      }
    }
  }
}
```

</details>

---

## 🔄 Step 3: Add Control — `For each`

Add a **For each** loop to iterate over the alerts (if not automatically created).

![image](https://github.com/user-attachments/assets/79618df7-fb89-4f70-9293-431d9a8ca0b8)

---

## 🧮 Step 4: Add Action — Compose (Extract Analytics Rule ID)

Inside the loop, add a **Compose** action to extract the rule ID.

![image](https://github.com/user-attachments/assets/5cb009d0-837a-4b93-9c19-65a8dc974589)

**Input**:

```plaintext
last(split(items('For_each'), '/'))
```

![image](https://github.com/user-attachments/assets/d11c5030-7e4d-487c-846a-1a1ccbb3bda0)

---

## 🌐 Step 5: Add Action — HTTP (Get Analytics Rule)

> 📚 **Reference**: This call uses the [Microsoft Sentinel REST API — Get Alert Rule](https://learn.microsoft.com/en-us/rest/api/securityinsights/alert-rules/get?view=rest-securityinsights-2024-09-01&tabs=HTTP), which allows you to programmatically retrieve the full definition of a scheduled analytics rule, including the query that generated the alert.

Configure an HTTP GET action to retrieve the analytics rule.

![image](https://github.com/user-attachments/assets/dca51f7f-0663-4615-921c-568ce74cb1fe)

* **URI** (example from lab):
```plaintext
https://management.azure.com/subscriptions/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['SubscriptionId']}/resourceGroups/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['ResourceGroupName']}/providers/Microsoft.OperationalInsights/workspaces/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['WorkspaceName']}/providers/Microsoft.SecurityInsights/alertRules/@{outputs('Compose_analytics_rule_id')}?api-version=2024-09-01
``` 
> 📌 **Note**: In the sample URI below, replace `Parse_JSON_orgin_XDR` with the **actual name** you assigned to the **Parse JSON** action in **Step 2**.

```plaintext
https://management.azure.com/subscriptions/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['SubscriptionId']}/resourceGroups/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['ResourceGroupName']}/providers/Microsoft.OperationalInsights/workspaces/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['WorkspaceName']}/providers/Microsoft.SecurityInsights/alertRules/@{outputs('Compose_analytics_rule_id')}?api-version=2024-09-01
```

> ✅ Example (if your Parse JSON action is named `Parse_JSON_SentinelIncident`):

```plaintext
[@{body('Parse_JSON_SentinelIncident')?['workspaceInfo']?['SubscriptionId']}](https://management.azure.com/subscriptions/@{body('Parse_JSON_SentinelIncident')?['workspaceInfo']?['SubscriptionId']}/resourceGroups/@{body('Parse_JSON_SentinelIncident')?['workspaceInfo']?['ResourceGroupName']}/providers/Microsoft.OperationalInsights/workspaces/@{body('Parse_JSON_SentinelIncident')?['workspaceInfo']?['WorkspaceName']}/providers/Microsoft.SecurityInsights/alertRules/@{outputs('Compose_analytics_rule_id')}?api-version=2024-09-01)
```
This ensures your Logic App references the correct dynamic output from the earlier action when building the URI to retrieve the analytics rule definition.


* **Method**: `GET`

* **Authentication**:

  * Type: `Managed Identity`
  * Identity: `System-assigned`
  * Audience: `https://management.azure.com`

Sample configuration:

![image](https://github.com/user-attachments/assets/5cfcea6d-bbce-4bf3-9864-9e9aa27d9e34)

---

## 🧩 Step 6: Add Action — Parse JSON (Analytics Rule Output)

* **Content**: Use the body output from the HTTP step.

![image](https://github.com/user-attachments/assets/6111d1b1-ac79-483e-b014-4029933f2e16)

* **Schema**: Paste the following directly.
<details>
  <summary>Click to expand JSON schema</summary>
	
```json
{
  "type": "object",
  "properties": {
    "id": {
      "type": "string"
    },
    "name": {
      "type": "string"
    },
    "etag": {
      "type": "string"
    },
    "type": {
      "type": "string"
    },
    "kind": {
      "type": "string"
    },
    "properties": {
      "type": "object",
      "properties": {
        "queryFrequency": {
          "type": "string"
        },
        "queryPeriod": {
          "type": "string"
        },
        "triggerOperator": {
          "type": "string"
        },
        "triggerThreshold": {
          "type": "integer"
        },
        "eventGroupingSettings": {
          "type": "object",
          "properties": {
            "aggregationKind": {
              "type": "string"
            }
          }
        },
        "incidentConfiguration": {
          "type": "object",
          "properties": {
            "createIncident": {
              "type": "boolean"
            },
            "groupingConfiguration": {
              "type": "object",
              "properties": {
                "enabled": {
                  "type": "boolean"
                },
                "reopenClosedIncident": {
                  "type": "boolean"
                },
                "lookbackDuration": {
                  "type": "string"
                },
                "matchingMethod": {
                  "type": "string"
                },
                "groupByEntities": {
                  "type": "array"
                },
                "groupByAlertDetails": {
                  "type": "array"
                },
                "groupByCustomDetails": {
                  "type": "array"
                }
              }
            }
          }
        },
        "customDetails": {
          "type": "object",
          "properties": {}
        },
        "alertDetailsOverride": {
          "type": "object",
          "properties": {
            "alertDynamicProperties": {
              "type": "array"
            }
          }
        },
        "severity": {
          "type": "string"
        },
        "query": {
          "type": "string"
        },
        "suppressionDuration": {
          "type": "string"
        },
        "suppressionEnabled": {
          "type": "boolean"
        },
        "tactics": {
          "type": "array"
        },
        "techniques": {
          "type": "array"
        },
        "displayName": {
          "type": "string"
        },
        "enabled": {
          "type": "boolean"
        },
        "description": {
          "type": "string"
        },
        "alertRuleTemplateName": {},
        "lastModifiedUtc": {
          "type": "string"
        }
      }
    }
  }
}
```
</details>

---

## 🧪 Step 7: Test — Use a Sample Incident

You can now test your workflow with a sample incident. At the final output of Step 6, you will get the full details of the analytics rule, including the original **KQL query**.

Sample output:

<details>
  <summary>Click to expand JSON schema</summary>
	
```json
{
	"id": "/subscriptions/59a6ba34-6a79-4b81-8cc1-64d5e21a4c4c/resourceGroups/demo-sentinel-logic-app-rg/providers/Microsoft.OperationalInsights/workspaces/demo-sentinel-logic-app-rg-workspace1/providers/Microsoft.SecurityInsights/alertRules/a1d7ba82-a14c-4245-a781-81481901f558",
	"name": "a1d7ba82-a14c-4245-a781-81481901f558",
	"etag": "\"0600cacf-0000-1800-0000-68427ffb0000\"",
	"type": "Microsoft.SecurityInsights/alertRules",
	"kind": "Scheduled",
	"properties": {
		"queryFrequency": "PT5M",
		"queryPeriod": "PT30M",
		"triggerOperator": "GreaterThan",
		"triggerThreshold": 0,
		"eventGroupingSettings": {
			"aggregationKind": "SingleAlert"
		},
		"incidentConfiguration": {
			"createIncident": true,
			"groupingConfiguration": {
				"enabled": false,
				"reopenClosedIncident": false,
				"lookbackDuration": "PT5H",
				"matchingMethod": "AllEntities",
				"groupByEntities": [],
				"groupByAlertDetails": [],
				"groupByCustomDetails": []
			}
		},
		"customDetails": {},
		"alertDetailsOverride": {
			"alertDynamicProperties": []
		},
		"severity": "Medium",
		"query": "ASimDnsActivityLogs\r\n// Querying the ASimDnsActivityLogs table, which contains normalized DNS activity data for analysis.\r\n\r\n| where TimeGenerated > ago(7d)\r\n// Filtering records to only include DNS events that occurred in the last 7 days from the current timestamp.\r\n// This ensures that we are analyzing recent DNS traffic for relevancy.\r\n\r\n| where SrcIpAddr == \"192.168.50.35\"\r\n// Further filtering to only include DNS queries that originated from a specific source IP address.\r\n// This is likely an endpoint or server of interest for investigation.\r\n\r\n| where EventSubType == \"request\"\r\n// Narrowing the focus to only include DNS *query* events (requests), excluding responses or other subtypes.\r\n// This is important for understanding what was asked, not necessarily what was answered.\r\n\r\n| where DnsQuery has \"microsoft.com\"\r\n// Filtering DNS queries that contain the string “microsoft.com” anywhere in the query.\r\n// This helps isolate traffic related to Microsoft domains, possibly for compliance or investigation.\r\n\r\n| extend\r\n    TopLevelDomain = tostring(split(DnsQuery, \".\")[-1]),\r\n// Extracting the top-level domain (TLD) from the DNS query string.\r\n// This is achieved by splitting the domain by periods and taking the last segment, e.g., \"com\" from \"www.microsoft.com\".\r\n\r\n    SecondLevelDomain = tostring(split(DnsQuery, \".\")[-2]),\r\n// Extracting the second-level domain (SLD), typically the domain name itself.\r\n// For \"www.microsoft.com\", this would be \"microsoft\".\r\n\r\n    QueryCategory = iif(\r\n        DnsQuery endswith \".local\" or DnsQuery startswith \"intranet.\", \r\n        \"Internal\", \r\n        \"External\"\r\n    ),\r\n// Categorizing the DNS query as \"Internal\" or \"External\".\r\n// Queries ending with \".local\" or starting with \"intranet.\" are assumed to be part of private or enterprise networks.\r\n// All other queries are treated as external, likely directed to public DNS resolvers.\r\n\r\n    ProtocolType = iif(\r\n        NetworkProtocol =~ \"udp\", \r\n        \"UDP\", \r\n        iif(NetworkProtocol =~ \"tcp\", \"TCP\", \"Other\")\r\n    ),\r\n// Interpreting the network protocol used for the DNS request.\r\n// Since DNS usually uses UDP (or sometimes TCP for large responses), this field helps track protocol-specific behavior.\r\n// If it's not UDP or TCP, we classify it as \"Other\".\r\n\r\n    QueryStatus = case(\r\n        EventResult has \"Success\", \"Success\",\r\n        EventResult has \"Fail\", \"Failure\",\r\n        \"Unknown\"\r\n    )\r\n// Deriving a simplified status value for the query based on the EventResult field.\r\n// If it contains \"Success\", we mark it as successful; if it has \"Fail\", it's marked as a failure.\r\n// Any other unrecognized value results in \"Unknown\", ensuring robustness.\r\n\r\n| where DnsQueryTypeName in~ (\"A\", \"AAAA\", \"CNAME\", \"MX\", \"TXT\", \"SOA\")\r\n// Further narrowing results to only include specific DNS record types of interest.\r\n// These include:\r\n//   - \"A\" and \"AAAA\": IP address mappings for IPv4 and IPv6 respectively.\r\n//   - \"CNAME\": Canonical name (alias) records.\r\n//   - \"MX\": Mail exchange records for email delivery.\r\n//   - \"TXT\": Arbitrary text data often used for domain verification.\r\n//   - \"SOA\": Start of authority records, indicating DNS zone ownership.\r\n// The `in~` operator performs case-insensitive matching.\r\n\r\n| summarize\r\n    TotalQueries = count(),\r\n// Counting the total number of matching DNS requests for each time bin and grouping.\r\n\r\n    SuccessQueries = countif(QueryStatus == \"Success\"),\r\n// Counting how many of those requests were marked as successful (resolved properly).\r\n\r\n    FailureQueries = countif(QueryStatus == \"Failure\"),\r\n// Counting how many requests failed (e.g., domain not found, timeout, refused).\r\n\r\n    ExternalQueries = countif(QueryCategory == \"External\"),\r\n// Counting how many queries were classified as \"External\" DNS lookups.\r\n// This is useful to understand exposure to public domains or exfiltration behavior.\r\n\r\n    DistinctDomains = dcount(DnsQuery)\r\n// Calculating the number of unique DNS queries (de-duplicated) for each grouping.\r\n// Helps assess variety in DNS activity — high diversity may indicate scanning or malware behavior.\r\n\r\n    by bin(TimeGenerated, 1h), SrcIpAddr, DnsQueryTypeName, ProtocolType\r\n// Grouping the results by:\r\n//   - 1-hour time windows (`bin(TimeGenerated, 1h)`) for temporal trend analysis.\r\n//   - Source IP address, to keep activity per host separate.\r\n//   - DNS query type, to analyze trends by record type (e.g., A vs MX).\r\n//   - Network protocol used, to compare usage patterns across UDP, TCP, etc.\r\n\r\n| order by TimeGenerated desc\r\n// Sorting the final output in reverse chronological order, so the most recent activity appears first.\r\n// This is typical for time-series dashboards and investigative workflows.\r\n",
		"suppressionDuration": "PT5H",
		"suppressionEnabled": false,
		"tactics": [],
		"techniques": [],
		"displayName": "Notify dns query events",
		"enabled": false,
		"description": "",
		"alertRuleTemplateName": null,
		"lastModifiedUtc": "2025-06-06T05:43:22.3300748Z"
	}
}
```
</details>

The `query` field will contain the exact rule logic used to trigger the incident, such as:

> ✅ **Tip**: This lets you extract and reuse the query logic directly in other automations, investigations, or documentation.
