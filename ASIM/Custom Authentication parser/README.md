# Custom authentication parser
https://learn.microsoft.com/en-us/azure/sentinel/authentication-normalization-schema#unifying-parsers

## Requirements for authentication schemas
https://learn.microsoft.com/en-us/azure/sentinel/authentication-normalization-schema#all-common-fields

## ImAuthentication - supports filtering
```kusto
let Generic=(starttime:datetime=datetime(null), endtime:datetime=datetime(null), targetusername_has:string="*"){
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeimAuthentication') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);
let imAuthenticationDisabled=toscalar('ExcludeimAuthentication' in (DisabledParsers) or 'Any' in (DisabledParsers)); 
union isfuzzy=true
    vimAuthenticationEmpty
  , vimAuthenticationAADManagedIdentitySignInLogs   (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationAADManagedIdentitySignInLogs'      in (DisabledParsers) )))
  , vimAuthenticationAADNonInteractiveUserSignInLogs(starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationAADNonInteractiveUserSignInLogs'   in (DisabledParsers) )))
  , vimAuthenticationAADServicePrincipalSignInLogs  (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationAADServicePrincipalSignInLogs'     in (DisabledParsers) )))
  , vimAuthenticationSigninLogs                     (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationSigninLogs'                        in (DisabledParsers) )))
  , vimAuthenticationAWSCloudTrail                  (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationAWSCloudTrail'                     in (DisabledParsers) )))
  , vimAuthenticationOktaSSO                        (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationOktaSSO'                           in (DisabledParsers) )))
  , vimAuthenticationM365Defender                   (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationM365Defender'                      in (DisabledParsers) )))
  , vimAuthenticationMicrosoftWindowsEvent          (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationMicrosoftWindowsEvent'             in (DisabledParsers) )))
  , vimAuthenticationMD4IoT                         (starttime, endtime, targetusername_has, (imAuthenticationDisabled or('ExcludevimAuthenticationMD4IoT'                            in (DisabledParsers) )))
   };
Generic(starttime, endtime, targetusername_has)
```

## ASimAuthentication - parameter-less parser
```kusto
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeASimAuthentication') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);
let ASimAuthenticationDisabled=toscalar('ExcludeASimAuthentication' in (DisabledParsers) or 'Any' in (DisabledParsers)); 
union isfuzzy=true
    vimAuthenticationEmpty
  , ASimAuthenticationAADManagedIdentitySignInLogs    (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAADManagedIdentitySignInLogs'  in (DisabledParsers) ))
  , ASimAuthenticationAADNonInteractiveUserSignInLogs (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAADNonInteractiveUserSignInLogs'      in (DisabledParsers) ))
  , ASimAuthenticationAADServicePrincipalSignInLogs   (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAADServicePrincipalSignInLogs'      in (DisabledParsers) ))
  , ASimAuthenticationSigninLogs    (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationSigninLogs' in (DisabledParsers) ))
  , ASimAuthenticationAWSCloudTrail (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAWSCloudTrail'      in (DisabledParsers) ))
  , ASimAuthenticationOktaSSO (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationOktaSSO'      in (DisabledParsers) ))
  , ASimAuthenticationM365Defender  (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationM365Defender'      in (DisabledParsers) ))
  , ASimAuthenticationMicrosoftWindowsEvent     (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationMicrosoftWindowsEvent'      in (DisabledParsers) ))
  , ASimAuthenticationMD4IoT  (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationMD4IoT'  in (DisabledParsers) ))
```

## vimAuthenticationOktaSSO

```kusto
let OktaSignin=(starttime:datetime=datetime(null), endtime:datetime=datetime(null), targetusername_has:string="*", disabled:bool=false){
  let OktaSuccessfulOutcome = dynamic(['SUCCESS', 'ALLOW']);
  let OktaFailedOutcome = dynamic(['FAILURE', 'SKIPPED','DENY']);
  let OktaSigninEvents=dynamic(['user.session.start', 'user.session.end']);
  // https://developer.okta.com/docs/reference/api/event-types/#catalog
  Okta_CL | where not(disabled)
  // ************************************************************************* 
  //       <Prefilterring>
  // *************************************************************************
  | where 
    (isnull(starttime)   or TimeGenerated >= starttime) 
    and (isnull(endtime)     or TimeGenerated <= endtime)
    and (targetusername_has=='*' or (actor_alternateId_s has targetusername_has))
  // ************************************************************************* 
  //       </Prefilterring>
  // ************************************************************************* 
  | where eventType_s in (OktaSigninEvents)
  | extend 
      EventProduct='Okta'
      , EventVendor='Okta'
      , EventCount=int(1)
      , EventSchemaVersion='0.1.0'
      , EventResult = case (outcome_result_s in (OktaSuccessfulOutcome), 'Success',outcome_result_s in (OktaFailedOutcome),'Failure', 'Partial')
      , EventStartTime=TimeGenerated
      , EventEndTime=TimeGenerated
      , EventType=iff(eventType_s hassuffix 'start', 'Logon', 'Logoff')
      , EventSubType=legacyEventType_s
      , TargetUserIdType='OktaId'
      , TargetUsernameType='Upn'
      , SrcGeoLatitude=toreal(client_geographicalContext_geolocation_lat_d)
      , SrcGeoLongitude=toreal(client_geographicalContext_geolocation_lon_d)
      , ActingAppType = "Browser"
  | project-rename 
      EventMessage=displayMessage_s
      ,EventOriginalResultDetails=outcome_reason_s
      , LogonMethod = authenticationContext_credentialType_s
      , TargetSessionId=authenticationContext_externalSessionId_s
      , TargetUserId= actor_id_s
      , TargetUsername=actor_alternateId_s
      , TargetUserType=actor_type_s
      , SrcDvcOs=client_userAgent_os_s
      , HttpUserAgent=client_userAgent_rawUserAgent_s
      , ActingAppName = client_userAgent_browser_s
      , SrcIsp=securityContext_isp_s
      , SrcGeoCity=client_geographicalContext_city_s
      , SrcGeoCountry=client_geographicalContext_country_s
      , EventOriginalUid = uuid_g
  | project-reorder
      EventProduct
      , EventOriginalUid
      , TimeGenerated
      , EventMessage
      , EventResult
      , EventOriginalResultDetails
      , EventStartTime
      , EventEndTime
      , EventType
      , EventSubType
      , LogonMethod
      , TargetSessionId
      , TargetUserId
      , TargetUsername
      , TargetUserType
      , SrcDvcOs
      , HttpUserAgent
      , SrcIsp
      , SrcGeoCity
      , SrcGeoCountry
      , SrcGeoLongitude
      , SrcGeoLatitude
      // ** Aliases
      | extend 
        User=TargetUsername
        , Dvc=EventVendor
  };
OktaSignin(starttime, endtime, targetusername_has, disabled)

```

## ASimAuthenticationOktaSSO
```kusto
let OktaSignin=(disabled:bool=false){
  let OktaSuccessfulOutcome = dynamic(['SUCCESS', 'ALLOW']);
  let OktaFailedOutcome = dynamic(['FAILURE', 'SKIPPED','DENY']);
  let OktaSigninEvents=dynamic(['user.session.start', 'user.session.end']);
  // https://developer.okta.com/docs/reference/api/event-types/#catalog
  Okta_CL | where not(disabled)
  | where eventType_s in (OktaSigninEvents)
  | extend 
      EventProduct='Okta'
      , EventVendor='Okta'
      , EventCount=int(1)
      , EventSchemaVersion='0.1.0'
      , EventResult = case (outcome_result_s in (OktaSuccessfulOutcome), 'Success',outcome_result_s in (OktaFailedOutcome),'Failure', 'Partial')
      , EventStartTime=TimeGenerated
      , EventEndTime=TimeGenerated
      , EventType=iff(eventType_s hassuffix 'start', 'Logon', 'Logoff')
      , EventSubType=legacyEventType_s
      , TargetUserIdType='OktaId'
      , TargetUsernameType='Upn'
      , SrcGeoLatitude=toreal(client_geographicalContext_geolocation_lat_d)
      , SrcGeoLongitude=toreal(client_geographicalContext_geolocation_lon_d)
      , ActingAppType = "Browser"
  | project-rename 
      EventMessage=displayMessage_s
      ,EventOriginalResultDetails=outcome_reason_s
      , LogonMethod = authenticationContext_credentialType_s
      , TargetSessionId=authenticationContext_externalSessionId_s
      , TargetUserId= actor_id_s
      , TargetUsername=actor_alternateId_s
      , TargetUserType=actor_type_s
      , SrcDvcOs=client_userAgent_os_s
      , HttpUserAgent=client_userAgent_rawUserAgent_s
      , ActingAppName = client_userAgent_browser_s
      , SrcIsp=securityContext_isp_s
      , SrcGeoCity=client_geographicalContext_city_s
      , SrcGeoCountry=client_geographicalContext_country_s
      , EventOriginalUid = uuid_g
  | project-reorder
      EventProduct
      , EventOriginalUid
      , TimeGenerated
      , EventMessage
      , EventResult
      , EventOriginalResultDetails
      , EventStartTime
      , EventEndTime
      , EventType
      , EventSubType
      , LogonMethod
      , TargetSessionId
      , TargetUserId
      , TargetUsername
      , TargetUserType
      , SrcDvcOs
      , HttpUserAgent
      , SrcIsp
      , SrcGeoCity
      , SrcGeoCountry
      , SrcGeoLongitude
      , SrcGeoLatitude
      // ** Aliases
      | extend 
        User=TargetUsername
        , Dvc=EventVendor
  };
OktaSignin(disabled)
```

## ASimAuthentication
```kusto
let DisabledParsers=materialize(_GetWatchlist('ASimDisabledParsers') | where SearchKey in ('Any', 'ExcludeASimAuthentication') | extend SourceSpecificParser=column_ifexists('SourceSpecificParser','') | distinct SourceSpecificParser);
let ASimAuthenticationDisabled=toscalar('ExcludeASimAuthentication' in (DisabledParsers) or 'Any' in (DisabledParsers)); 
union isfuzzy=true
    vimAuthenticationEmpty
  , ASimAuthenticationAADManagedIdentitySignInLogs    (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAADManagedIdentitySignInLogs'  in (DisabledParsers) ))
  , ASimAuthenticationAADNonInteractiveUserSignInLogs (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAADNonInteractiveUserSignInLogs'      in (DisabledParsers) ))
  , ASimAuthenticationAADServicePrincipalSignInLogs   (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAADServicePrincipalSignInLogs'      in (DisabledParsers) ))
  , ASimAuthenticationSigninLogs    (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationSigninLogs' in (DisabledParsers) ))
  , ASimAuthenticationAWSCloudTrail (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationAWSCloudTrail'      in (DisabledParsers) ))
  , ASimAuthenticationOktaSSO (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationOktaSSO'      in (DisabledParsers) ))
  , ASimAuthenticationM365Defender  (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationM365Defender'      in (DisabledParsers) ))
  , ASimAuthenticationMicrosoftWindowsEvent     (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationMicrosoftWindowsEvent'      in (DisabledParsers) ))
  , ASimAuthenticationMD4IoT  (ASimAuthenticationDisabled or ('ExcludeASimAuthenticationMD4IoT'  in (DisabledParsers) ))
```

## Syslog - Filter out failed password events in the info level
https://www.linkedin.com/pulse/microsoft-sentinel-asim-custom-authentication-parser-securiment?trk=pulse-article_more-articles_related-content-card
```kusto
Syslog
| where SyslogMessage contains "failed password" and SeverityLevel == "info"
| limit 50
| parse SyslogMessage with Activity:string
" for " TargetUserName
" from " IpAddress
" port " IpPort
" " Protocol
//| where TargetUserName contains "invalid user"// Filtering where the invalid user is mentioned in the event
| extend tmp_Username = split(TargetUserName," ")
| extend TargetUserName = tostring(tmp_Username[2]) //breaking the username string to find the actual username
| extend
EventVendor = 'Linux'
, EventProduct = 'Syslog'
, EventCount=int(1)
, EventSchemaVersion='0.1.0'
, EventResult = iff (Facility ==0, 'Success', 'Failure')
, EventStartTime = TimeGenerated
, EventEndTime= TimeGenerated
, EventType= 'Logon'
, SrcDvcId=tostring(Computer)
, SrcDvcHostname =tostring(HostName)
, SrcDvcOs=tostring(Computer)
| project-rename
EventOriginalUid =ProcessID
, LogonMethod = ProcessName
| project-reorder
TimeGenerated
,EventProduct
, EventOriginalUid
, EventResult
, EventStartTime
, EventEndTime
, LogonMethod
, SrcDvcId
, SrcDvcHostname
, SrcDvcOs

```

