# Useful queries and scripts for security events

## KQL query in workspace

Count securityevents and list by day
```kusto
SecurityEvent
| where TimeGenerated > ago(14d)
| summarize count() by bin(TimeGenerated, 1d)
| order by TimeGenerated desc
```


Count securityevents and list by EventID, Computer, SourceComputerId(used to recognize MMA or AMA)
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
