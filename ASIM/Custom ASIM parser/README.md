# Custom authentication parser
https://learn.microsoft.com/en-us/azure/sentinel/authentication-normalization-schema#unifying-parsers

1. imAuthentication - filtering parser
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

2. ASimAuthentication - parameter-less parser
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
