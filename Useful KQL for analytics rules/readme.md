#### 1. Generate alerts when the times of same password from same IP exceeds thereshold

Due to ingestion delay we can only use scheduled analytics rule
```kusto
let ingestion_delay = 3min;
let rule_look_back = 5min;
SigninLogs
| where TimeGenerated >= ago(ingestion_delay + rule_look_back)
| where ingestion_time() > ago(rule_look_back)
| where Status contains "Failure" and Status contains "50126"
| summarize RepeatTimesWhenBadPassWordInSameIp = count() by AlternateSignInName, IPAddress
| where RepeatTimesWhenBadPassWordInSameIp > 5
```

Test before roll out to the anyatics rule (remove the scanning time range)
```kusto
SigninLogs
| where Status contains "Failure" and Status contains "50126"
| summarize RepeatTimesWhenBadPassWordInSameIp = count() by AlternateSignInName, IPAddress
| where RepeatTimesWhenBadPassWordInSameIp > 5
```
