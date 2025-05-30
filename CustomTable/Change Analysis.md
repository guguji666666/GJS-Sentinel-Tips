# Stream Change Analysis logs to sentinel workspace

##  1. API test

url:


request body:
```json
{
//   "subscriptions": [
//     "{subscriptionID}"
//   ],
  "query": "resourcechanges\n| extend timestamp = todatetime(properties.changeAttributes.timestamp)\n| where timestamp > ago(24h)\n| extend resourceType = properties.targetResourceType\n| extend resourceId = properties.targetResourceId\n| extend changeType = properties.changeType\n| extend changeAttributes = parse_json(properties.changeAttributes)\n| project id, timestamp, subscriptionId, resourceGroup, resourceId, resourceType, changeType, changeAttributes\n| order by timestamp desc"
}
```

sample response
```json
{
	"totalRecords": 7,
	"count": 7,
	"data": [
		{
			"id": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/test-sentinel-playbook/providers/Microsoft.Web/connections/office365/providers/Microsoft.Resources/changes/08584531866189950367_f889e69a-2946-52ff-311c-abb559a4d03d",
			"timestamp": "2025-05-29T14:17:41.173Z",
			"subscriptionId": "1e7b8b49-aa0f-46e9-8ca2-2970f535efd4",
			"resourceGroup": "test-sentinel-playbook",
			"resourceId": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/test-sentinel-playbook/providers/Microsoft.Web/connections/office365",
			"resourceType": "microsoft.web/connections",
			"changeType": "Update",
			"changeAttributes": {
				"previousResourceSnapshotId": "08584531866189950367_f532cb3a-bc00-3aa7-6397-e314d2b41372_2487705421_1748420266",
				"newResourceSnapshotId": "08584530786243043281_de712464-80f7-1380-85f6-259260fe8cfa_991515173_1748528261",
				"correlationId": "00000000-0000-0000-0000-000000000000",
				"changedByType": "System",
				"changesCount": 1,
				"clientType": "Unspecified",
				"timestamp": "2025-05-29T14:17:41.173Z",
				"changedBy": "System",
				"operation": "Unspecified"
			}
		},
		{
			"id": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/gjs-sentinel/providers/Microsoft.Web/connections/office365-Revoke-EntraIDSignInSessions-incident/providers/Microsoft.Resources/changes/08584531866194513774_ff1c2abf-203d-6e06-e155-e4ff46769888",
			"timestamp": "2025-05-29T14:17:38.939Z",
			"subscriptionId": "1e7b8b49-aa0f-46e9-8ca2-2970f535efd4",
			"resourceGroup": "gjs-sentinel",
			"resourceId": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/gjs-sentinel/providers/Microsoft.Web/connections/office365-Revoke-EntraIDSignInSessions-incident",
			"resourceType": "microsoft.web/connections",
			"changeType": "Update",
			"changeAttributes": {
				"previousResourceSnapshotId": "08584531866194513774_92cf5073-53c5-ad23-859f-d6d0b7218f25_626608060_1748420266",
				"newResourceSnapshotId": "08584530786265376528_d4b091ce-cb09-41e0-eebc-5fbee7fcbfc1_1378565788_1748528258",
				"correlationId": "00000000-0000-0000-0000-000000000000",
				"changedByType": "System",
				"changesCount": 1,
				"clientType": "Unspecified",
				"timestamp": "2025-05-29T14:17:38.939Z",
				"changedBy": "System",
				"operation": "Unspecified"
			}
		},
		{
			"id": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/gjs-sentinel/providers/Microsoft.Web/connections/office365-1/providers/Microsoft.Resources/changes/08584531866181658605_1da82d73-e2e1-67ca-5d81-1327dde6e027",
			"timestamp": "2025-05-29T14:17:38.655Z",
			"subscriptionId": "1e7b8b49-aa0f-46e9-8ca2-2970f535efd4",
			"resourceGroup": "gjs-sentinel",
			"resourceId": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/gjs-sentinel/providers/Microsoft.Web/connections/office365-1",
			"resourceType": "microsoft.web/connections",
			"changeType": "Update",
			"changeAttributes": {
				"previousResourceSnapshotId": "08584531866181658605_f3bac27e-4e05-02dc-d445-84e280085528_447362410_1748420267",
				"newResourceSnapshotId": "08584530786268223680_c56a615d-0453-ff48-1718-a0523ce71893_3286799461_1748528258",
				"correlationId": "00000000-0000-0000-0000-000000000000",
				"changedByType": "System",
				"changesCount": 1,
				"clientType": "Unspecified",
				"timestamp": "2025-05-29T14:17:38.655Z",
				"changedBy": "System",
				"operation": "Unspecified"
			}
		},
		{
			"id": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/GJS-MS150-MDFC1/providers/Microsoft.Web/connections/office365/providers/Microsoft.Resources/changes/08584531866220442647_24958171-e516-39c4-f6bc-91e2b01d53d0",
			"timestamp": "2025-05-29T14:17:38.13Z",
			"subscriptionId": "1e7b8b49-aa0f-46e9-8ca2-2970f535efd4",
			"resourceGroup": "gjs-ms150-mdfc1",
			"resourceId": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/GJS-MS150-MDFC1/providers/Microsoft.Web/connections/office365",
			"resourceType": "microsoft.web/connections",
			"changeType": "Update",
			"changeAttributes": {
				"previousResourceSnapshotId": "08584531866220442647_1ea39de6-8b3b-cf1f-2f16-0974b13d37f4_1484299822_1748420263",
				"newResourceSnapshotId": "08584530786273471683_6b086e40-c74c-05c8-e38c-277fe9979df5_1210261599_1748528258",
				"correlationId": "00000000-0000-0000-0000-000000000000",
				"changedByType": "System",
				"changesCount": 1,
				"clientType": "Unspecified",
				"timestamp": "2025-05-29T14:17:38.13Z",
				"changedBy": "System",
				"operation": "Unspecified"
			}
		},
		{
			"id": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/GJS-MS150-MDFC1/providers/Microsoft.Web/connections/o365-Send-basic-email/providers/Microsoft.Resources/changes/08584531866214064652_8ee4a25c-1826-b19d-d203-23514c3c03a7",
			"timestamp": "2025-05-29T14:17:37.056Z",
			"subscriptionId": "1e7b8b49-aa0f-46e9-8ca2-2970f535efd4",
			"resourceGroup": "gjs-ms150-mdfc1",
			"resourceId": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/GJS-MS150-MDFC1/providers/Microsoft.Web/connections/o365-Send-basic-email",
			"resourceType": "microsoft.web/connections",
			"changeType": "Update",
			"changeAttributes": {
				"previousResourceSnapshotId": "08584531866214064652_470a46bd-9981-0f8e-666d-170012b7b08f_1243585851_1748420264",
				"newResourceSnapshotId": "08584530786284212814_0d242199-c424-d88d-315a-c8b8b7c3f715_627553326_1748528257",
				"correlationId": "00000000-0000-0000-0000-000000000000",
				"changedByType": "System",
				"changesCount": 1,
				"clientType": "Unspecified",
				"timestamp": "2025-05-29T14:17:37.056Z",
				"changedBy": "System",
				"operation": "Unspecified"
			}
		},
		{
			"id": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/gjs-sentinel/providers/Microsoft.Web/connections/o365-Send-basic-email/providers/Microsoft.Resources/changes/08584531866221137661_6f85d718-451a-52d7-3575-a9474232d6dd",
			"timestamp": "2025-05-29T14:17:36.459Z",
			"subscriptionId": "1e7b8b49-aa0f-46e9-8ca2-2970f535efd4",
			"resourceGroup": "gjs-sentinel",
			"resourceId": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/gjs-sentinel/providers/Microsoft.Web/connections/o365-Send-basic-email",
			"resourceType": "microsoft.web/connections",
			"changeType": "Update",
			"changeAttributes": {
				"previousResourceSnapshotId": "08584531866221137661_570d339f-7ddd-9308-98ee-4d65666a5c58_1473166568_1748420263",
				"newResourceSnapshotId": "08584530786290180714_c07ff277-deb2-5c15-ae2a-5d27aed445d2_1743259433_1748528256",
				"correlationId": "00000000-0000-0000-0000-000000000000",
				"changedByType": "System",
				"changesCount": 1,
				"clientType": "Unspecified",
				"timestamp": "2025-05-29T14:17:36.459Z",
				"changedBy": "System",
				"operation": "Unspecified"
			}
		},
		{
			"id": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/GJS-MS150-MDFC1/providers/Microsoft.Web/connections/office365-2/providers/Microsoft.Resources/changes/08584531866226854415_3343d72f-d19d-56f9-481d-bb7a18d9818d",
			"timestamp": "2025-05-29T14:17:36.007Z",
			"subscriptionId": "1e7b8b49-aa0f-46e9-8ca2-2970f535efd4",
			"resourceGroup": "gjs-ms150-mdfc1",
			"resourceId": "/subscriptions/1e7b8b49-aa0f-46e9-8ca2-2970f535efd4/resourceGroups/GJS-MS150-MDFC1/providers/Microsoft.Web/connections/office365-2",
			"resourceType": "microsoft.web/connections",
			"changeType": "Update",
			"changeAttributes": {
				"previousResourceSnapshotId": "08584531866226854415_b58d6cc0-31d6-086d-7a99-3f903e80949d_2431831823_1748420262",
				"newResourceSnapshotId": "08584530786294700393_362a452b-bb14-477e-34fe-4e3137d47b07_817100836_1748528256",
				"correlationId": "00000000-0000-0000-0000-000000000000",
				"changedByType": "System",
				"changesCount": 1,
				"clientType": "Unspecified",
				"timestamp": "2025-05-29T14:17:36.007Z",
				"changedBy": "System",
				"operation": "Unspecified"
			}
		}
	],
	"facets": [],
	"resultTruncated": "false"
}
```

