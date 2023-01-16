## Deploy parsers with ARM template and additional work

### Format of json file
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-08-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "workspace": {
      "type": "string"
    }
  },
  "resources": [
    {
      "type": "Microsoft.OperationalInsights/workspaces/savedSearches",
      "apiVersion": "2020-08-01",
      "name": "[concat(parameters('workspace'), '/ASimAuthenticationAWSCloudTrail')]",
      "location": "[resourceGroup().location]",
      "properties": {
        "etag": "*",
        "displayName": "ASIM AWS authentication",
        "category": "Security",
        "FunctionAlias": "ASimAuthenticationAWSCloudTrail",
        "query": "let AWSLogon=(disabled:bool=false){\nAWSCloudTrail | where not(disabled)\n | where EventName == 'ConsoleLogin'\n | extend\n  EventVendor = 'AWS'\n  , EventProduct='AWSCloudTrail'\n  , EventCount=int(1)\n  , EventSchemaVersion='0.1.0'\n  , EventResult= iff (ResponseElements has_cs 'Success', 'Success', 'Failure')\n  , EventStartTime=TimeGenerated\n  , EventEndTime=TimeGenerated\n  , EventType='Logon'\n  , LogonMethod=iff(AdditionalEventData has '\"MFAUsed\": \"No\"', 'NoMFA', 'MFA')\n  , TargetUrl =tostring(todynamic(AdditionalEventData).LoginTo)\n  , TargetUsernameType='Simple'\n  , TargetUserIdType='AWSId'\n  | project-rename\n    EventOriginalUid= AwsEventId\n  , EventOriginalResultDetails= ErrorMessage\n  , TargetUsername= UserIdentityUserName\n  , TargetUserType=UserIdentityType\n  , TargetUserId=UserIdentityAccountId \n  , SrcDvcIpAddr=SourceIpAddress\n  , HttpUserAgent=UserAgent\n// **** Aliases\n| extend\n       User=TargetUsername\n      , LogonTarget=tostring(split(TargetUrl,'?')[0])\n      , Dvc=EventVendor\n  };\n  AWSLogon(disabled)\n",
        "version": 1,
        "functionParameters": "disabled:bool=False"
      }
    }
  ]
}
```
We may need the tool [JSON Escape / Unescape](https://appdevtools.com/json-escape-unescape) to fill the `query` part

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

For escaped query, after `Unescape`, you can get the format in KQL query
```
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeASimAuditEvent') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);\r\nlet BuiltInDisabled=toscalar('ExcludeASimAuditEventBuiltIn' in (DisabledParsers) or 'Any' in (DisabledParsers)); \r\nunion isfuzzy=true\r\n  vimAuditEventEmpty, \r\n  ASimAuditEventMicrosoftExchangeAdmin365  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftExchangeAdmin365' in (DisabledParsers))),\r\n  ASimAuditEventMicrosoftWindowsEvents  (BuiltInDisabled or ('ExcludeASimAuditEventMicrosoftWindowsEvents' in (DisabledParsers))),\r\n  ASimAuditEventAzureActivity  (BuiltInDisabled or ('ExcludeASimAuditEventAzureActivity' in (DisabledParsers)))
```
![image](https://user-images.githubusercontent.com/96930989/212622391-9ebfe764-230c-46fb-bad0-c6f16c540c52.png)


Sample in my lab
