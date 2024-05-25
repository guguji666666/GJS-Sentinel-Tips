# Useful queries and scripts for security events

## KQL query in workspace

#### 1. Distinct MMA/AMA with SourceComouterId
```kusto
Heartbeat
| distinct Computer, Category, SourceComputerId
```

#### 2. Count securityevents and list by day
```kusto
SecurityEvent
| where TimeGenerated > ago(14d)
| summarize count() by bin(TimeGenerated, 1d)
| order by TimeGenerated desc
```


#### 3.Count securityevents and list by EventID, Computer, SourceComputerId(used to recognize MMA or AMA)
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


#### 4. Check the entry that has same Computer name, different SourceComputerId but with rest of the columns same.
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


#### 5. Count securityevents via Computer, SourceComputerId and list results by day
```kusto
SecurityEvent
| where TimeGenerated >= datetime(2024-05-19) and TimeGenerated < datetime(2024-05-23)
| where Computer contains "<machine name>"
| summarize Count = count() by Day = bin(TimeGenerated, 1d), Computer, SourceComputerId
| order by Day desc, Computer asc
```

## Powershell commands on machine

#### 1. Count specific EventID in the past xxx days and list results via date

```powershell
Get-EventLog -LogName <Log name> -InstanceId <EventID> -After (Get-Date).AddDays(<set the time range>) | Group-Object -Property {$_.TimeGenerated.Date} | Select-Object @{Name="Date";Expression={$_.Name}}, @{Name="Count";Expression={$_.Count}} | Sort-Object Date | Format-Table -AutoSize 
```

Count event 4688 in past 14 days
```powershell
 Get-EventLog -LogName Security -InstanceId 4688 -After (Get-Date).AddDays(-14) | Group-Object -Property {$_.TimeGenerated.Date} | Select-Object @{Name="Date";Expression={$_.Name}}, @{Name="Count";Expression={$_.Count}} | Sort-Object Date | Format-Table -AutoSize 
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2ea27ced-d77c-4429-a635-97817bd63b8a)

