# Get query from analytics rule - sentinel incident trigger

## 1. Create trigger - Microsoft Sentinel incident
![image](https://github.com/user-attachments/assets/7a090e5b-337a-4b36-9948-95c0f3296d37)

## 2. Add action - parse json (the output body from previous step
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
