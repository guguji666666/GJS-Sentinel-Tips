# Export analytics rules to ARM template
### 1. Navigate to `Sentinel > Analytics`, check the box of the rule you want to export, click `export`
![image](https://user-images.githubusercontent.com/96930989/212596696-08040048-72c8-4697-a704-5279adf61da6.png)
### 2. The rule will be exported to `json` file
![image](https://user-images.githubusercontent.com/96930989/212595919-1cc852fc-cea4-4db5-bf08-2602a51efb98.png)
### 3. Check the Json file
![image](https://user-images.githubusercontent.com/96930989/217117828-11ac8048-a071-48eb-a93a-d9f4680bbb40.png)

* GUID behind `alertRules`
> You can generate your own guid by powershell command new-guid and then fill it in the parts below accordingly
* displayName
> Modify the name displayed in sentinel portal

* Query

We may need the tool [JSON Escape / Unescape](https://www.freeformatter.com/json-escape.html#before-output) to fill the `query` part

Suppose your kql query is 
```kusto
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeASimAuditEvent') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);
let BuiltInDisabled=toscalar('ExcludeASimAuditEventBuiltIn' in (DisabledParsers) or 'Any' in (DisabledParsers)); 
union isfuzzy=true
  vimAuditEventEmpty, 
  ASimAuditEventMicrosoftExchangeAdmin365  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftExchangeAdmin365' in (DisabledParsers))),
  ASimAuditEventMicrosoftWindowsEvents  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftWindowsEvents' in (DisabledParsers))),
  ASimAuditEventAzureActivity  (BuiltInDisabled or ('ExcludeASimAuditEventAzureActivity' in (DisabledParsers)))
```

For existing KQL query, after `Escape` in the tool, the query would be
```
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeASimAuditEvent') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);\r\nlet BuiltInDisabled=toscalar('ExcludeASimAuditEventBuiltIn' in (DisabledParsers) or 'Any' in (DisabledParsers)); \r\nunion isfuzzy=true\r\n  vimAuditEventEmpty, \r\n  ASimAuditEventMicrosoftExchangeAdmin365  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftExchangeAdmin365' in (DisabledParsers))),\r\n  ASimAuditEventMicrosoftWindowsEvents  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftWindowsEvents' in (DisabledParsers))),\r\n  ASimAuditEventAzureActivity  (BuiltInDisabled or ('ExcludeASimAuditEventAzureActivity' in (DisabledParsers)))
```
![image](https://user-images.githubusercontent.com/96930989/212622538-a5f1ad6a-68d8-479e-9e7e-02c72c3cc225.png)

Then paste it into query part

* For parameters "queryFrequency", "queryPeriod", "triggerOperator", "triggerThreshold", we can refer to
![image](https://user-images.githubusercontent.com/96930989/217118810-fbdd609e-3dc1-468e-b317-d6902d76409d.png)
