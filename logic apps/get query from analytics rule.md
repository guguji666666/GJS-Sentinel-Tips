![image](https://github.com/user-attachments/assets/e92795e1-515d-44e3-a3fa-502b49c78024)# Get query from analytics rule - sentinel incident trigger

## Prepare
* Enable system managed identity for logic app
* Assign `Sentinel contributor role` to managed identity 

## 1. Create trigger - Microsoft Sentinel incident
![image](https://github.com/user-attachments/assets/7a090e5b-337a-4b36-9948-95c0f3296d37)

## 2. Add Action - Data Operations - Parse JSON (the output body from previous step - sentinel incident trigger)
![image](https://github.com/user-attachments/assets/710cbf1c-59b3-45be-a2c6-950a28b4ccd6)

### Content - select the `body` from output of previous step
![image](https://github.com/user-attachments/assets/9b302155-16d2-4b12-b4c7-5d1a063f3683)

### Schema - use the json below directly

<details>
  <summary>Click to expand sample JSON</summary>

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

## 3. Add Action - Control - `For each` (if the for each loop doesn't show up automatically then we create and add it manually)
![image](https://github.com/user-attachments/assets/79618df7-fb89-4f70-9293-431d9a8ca0b8)

## 4. Add Action - Data Operations - Compose
![image](https://github.com/user-attachments/assets/5cb009d0-837a-4b93-9c19-65a8dc974589)

### Input
Paste below context
```
last(split(items('For_each'),'/'))
```
![image](https://github.com/user-attachments/assets/d11c5030-7e4d-487c-846a-1a1ccbb3bda0)

## 5. Add Action - HTTP - HTTP
![image](https://github.com/user-attachments/assets/dca51f7f-0663-4615-921c-568ce74cb1fe)

### URI
Replace `Parse_JSON_orgin_XDR` with the name you set for `Parse json` action in step 2

Below is the sample in may lab
```
https://management.azure.com/subscriptions/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['SubscriptionId']}/resourceGroups/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['ResourceGroupName']}/providers/Microsoft.OperationalInsights/workspaces/@{body('Parse_JSON_orgin_XDR')?['workspaceInfo']?['WorkspaceName']}/providers/Microsoft.SecurityInsights/alertRules/@{outputs('Compose_analytics_rule_id')}?api-version=2024-09-01
```
### Method - GET

### Authentication
* Authentication Type - Managed identity
* Managed identity - System-assigned managed identity
* Audience - fill `https://management.azure.com`

Sample for this action in my lab
![image](https://github.com/user-attachments/assets/5cfcea6d-bbce-4bf3-9864-9e9aa27d9e34)

## 6. Add Action - Data Operations - Parse JSON
### Content - Body of output of previous step - HTTP call
![image](https://github.com/user-attachments/assets/6111d1b1-ac79-483e-b014-4029933f2e16)


### Schema - Paste the context below directly
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

Sample in my lab
![image](https://github.com/user-attachments/assets/174a58cd-2170-41a3-838f-46c037cbd1ce)

