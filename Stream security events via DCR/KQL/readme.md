# Useful queries and scripts for security events

## KQL query in workspace

### 1. Disctinct MMA/AMA with SourceComouterId
```kusto
Heartbeat
| distinct Computer, Category, SourceComputerId
```

### 2. Count securityevents and list by day
```kusto
SecurityEvent
| where TimeGenerated > ago(14d)
| summarize count() by bin(TimeGenerated, 1d)
| order by TimeGenerated desc
```


### 3.Count securityevents and list by EventID, Computer, SourceComputerId(used to recognize MMA or AMA)
```kusto
SecurityEvent
| where TimeGenerated >= datetime(2024-05-22) and TimeGenerated < datetime(2024-05-23)
| summarize Count = count() by EventID, Computer, SourceComputerId
```

```kusto
SecurityEvent
| where TimeGenerated >= datetime(2024-05-20) and TimeGenerated < datetime(2024-05-23)
| summarize Count = count() by EventID, Computer, SourceComputerId
```
You can customize the date in TimeGenerated filter


### 4. Check the entry that has same Computer name, different SourceComputerId but with rest of the columns same.
```kusto
SecurityEvent
| where TimeGenerated >= datetime(2024-05-22) and TimeGenerated < datetime(2024-05-23)
| summarize CountPerSourceId = count() by Computer, SourceComputerId
// Aggregate results by Computer to count distinct SourceComputerIds and to collect SourceComputerIds
| summarize CountDistinctSourceIds = dcount(SourceComputerId), ListOfSourceComputerIds = make_set(SourceComputerId) by Computer
// Filter to get Computers with exactly 2 distinct SourceComputerIds
| where CountDistinctSourceIds == 2
| project Computer, ListOfSourceComputerIds
```
You can customize the date in TimeGenerated filter

