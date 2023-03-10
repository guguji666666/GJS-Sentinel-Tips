# Parser for Microsoft 365 Defender Registry Event
```kusto
 let RegistryType = datatable (TypeCode: string, TypeName: string) [
 "None", "Reg_None",
 "String", "Reg_Sz",
 "ExpandString", "Reg_Expand_Sz",
 "Binary", "Reg_Binary",
 "Dword", "Reg_DWord",
 "MultiString", "Reg_Multi_Sz",
 "QWord", "Reg_QWord"
 ];
 let RegistryEvents_M365D=() {
 DeviceRegistryEvents
 | extend
     // Event
     EventOriginalUid = tostring(ReportId),
     EventCount = int(1), 
     EventProduct = 'M365 Defender for Endpoint',
     EventVendor = 'Microsoft', 
     EventSchemaVersion = '0.1.0', 
     EventStartTime = TimeGenerated, 
     EventEndTime = TimeGenerated, 
     EventType = ActionType,
     // Registry
     RegistryKey = iff (ActionType in ("RegistryKeyDeleted", "RegistryValueDeleted"), PreviousRegistryKey, RegistryKey),
     RegistryValue = iff (ActionType == "RegistryValueDeleted", PreviousRegistryValueName, RegistryValueName),
     // RegistryValueType -- original name is fine
     // RegistryValueData -- original name is fine
     RegistryKeyModified = iff (ActionType == "RegistryKeyRenamed", PreviousRegistryKey, ""),
     RegistryValueModified = iff (ActionType == "RegistryValueSet", PreviousRegistryValueName, ""),
     // RegistryValueTypeModified -- Not provided by Defender
     RegistryValueDataModified = PreviousRegistryValueData
 | lookup RegistryType on $left.RegistryValueType == $right.TypeCode
 | extend RegistryValueType = TypeName
 | project-away
     TypeName,
     PreviousRegistryKey,
     PreviousRegistryValueName,
     PreviousRegistryValueData
 // Device
 | extend
     DvcHostname = DeviceName,
     DvcId = DeviceId,
     Dvc = DeviceName
 // Users
 | extend
     ActorUsername = iff (InitiatingProcessAccountDomain == '', InitiatingProcessAccountName, strcat(InitiatingProcessAccountDomain, '\\', InitiatingProcessAccountName)), 
     ActorUsernameType = iff(InitiatingProcessAccountDomain == '', 'Simple', 'Windows'), 
     ActorUserIdType = 'SID'
 | project-away InitiatingProcessAccountDomain, InitiatingProcessAccountName
 | project-rename
 ActorUserId = InitiatingProcessAccountSid, 
 ActorUserAadId = InitiatingProcessAccountObjectId, 
 ActorUserUpn = InitiatingProcessAccountUpn
 // Processes
 | extend
 ActingProcessId = tostring(InitiatingProcessId), 
 ParentProcessId = tostring(InitiatingProcessParentId) 
 | project-away InitiatingProcessId, InitiatingProcessParentId
 | project-rename
 ParentProcessName = InitiatingProcessParentFileName, 
 ParentProcessCreationTime = InitiatingProcessParentCreationTime, 
 ActingProcessName = InitiatingProcessFolderPath, 
 ActingProcessFileName = InitiatingProcessFileName,
 ActingProcessCommandLine = InitiatingProcessCommandLine, 
 ActingProcessMD5 = InitiatingProcessMD5, 
 ActingProcessSHA1 = InitiatingProcessSHA1, //OK
 ActingProcessSHA256 = InitiatingProcessSHA256, 
 ActingProcessIntegrityLevel = InitiatingProcessIntegrityLevel, 
 ActingProcessTokenElevation = InitiatingProcessTokenElevation, 
 ActingProcessCreationTime = InitiatingProcessCreationTime 
 // -- aliases
 | extend 
 Username = ActorUsername,
 UserId = ActorUserId,
 UserIdType = ActorUserIdType,
 User = ActorUsername,
 CommandLine = ActingProcessCommandLine,
 Process = ActingProcessName
 };
 RegistryEvents_M365D
 ```
 
# Parser for SecurityEvent 4657
```kusto
 let RegistryType = datatable (TypeCode: string, TypeName: string) [
 "%%1872", "Reg_None",
 "%%1873", "Reg_Sz",
 "%%1874", "Reg_Expand_Sz",
 "%%1875", "Reg_Binary",
 "%%1876", "Reg_DWord",
 "%%1879", "Reg_Multi_Sz",
 "%%1883", "Reg_QWord"
 ];
 let RegistryAction = datatable (EventOriginalSubType: string, EventType: string) [
     "%%1904", "RegistryValueSet",
     "%%1905", "RegistryValueSet",      
     "%%1906", "RegistryValueDeleted"             
 ];
 let Hives = datatable (KeyPrefix: string, Hive: string) [
     "MACHINE", "HKEY_LOCAL_MACHINE",
     "USER", "HKEY_USERS",   
 ];
 let RegistryEvents=() {
     SecurityEvent
     // -- Filter
     | where EventID == 4657          
     // Event
     | extend
         EventCount = int(1), 
         EventVendor = 'Microsoft', 
         EventProduct = 'Security Events', 
         EventSchemaVersion = '0.1.0', 
         EventStartTime = todatetime(TimeGenerated), 
         EventEndTime = todatetime(TimeGenerated),
         EventOriginalType = tostring(EventID) 
     | project-rename
         EventOriginalSubType = OperationType,
         EventOriginalUid = EventOriginId
     | lookup RegistryAction on EventOriginalSubType
     // Registry
     // Normalize key hive
     | parse ObjectName with "\\REGISTRY\\" KeyPrefix "\\" Key
     | lookup Hives on KeyPrefix
     | extend RegistryKey = strcat (Hive, "\\", Key)
     | project-away Hive, Key, KeyPrefix, ObjectName
     | project-rename
         RegistryValue = ObjectValueName
     | extend
         RegistryValueData = iff (EventOriginalSubType == "%%1906", OldValue, NewValue), 
         RegistryKeyModified = iff (EventOriginalSubType == "%%1905", RegistryKey, ""),
         RegistryValueModified = iff (EventOriginalSubType == "%%1905", RegistryValue, ""),
         RegistryValueDataModified = iff (EventOriginalSubType == "%%1905", OldValue, "")
     | lookup RegistryType on $left.NewValueType == $right.TypeCode
     | project-rename RegistryValueType = TypeName
     | lookup RegistryType on $left.OldValueType == $right.TypeCode
     | project-rename RegistryValueTypeModified = TypeName
     | project-away OldValue, NewValue, OldValueType, NewValueType
     // Device
     | extend
         DvcId = SourceComputerId,
         DvcHostname = Computer,
         DvcOs = 'Windows'
     // User
     | project-rename
         ActorUserId = SubjectUserSid, 
         ActorSessionId = SubjectLogonId, 
         ActorDomainName = SubjectDomainName
     | extend
         ActorUserIdType = 'SID',
         ActorUsername = iff (ActorDomainName == '-', SubjectUserName, SubjectAccount), 
         ActorUsernameType = iff(ActorDomainName == '-', 'Simple', 'Windows'),
         ActingProcessId = tostring(toint(ProcessId)) 
     // Process 
     | project-rename
         ActingProcessName = ProcessName
     // -- Aliases
     | extend
         User = ActorUsername,
         UserId = ActorUserId,
         Dvc = DvcHostname,
         Process = ActingProcessName
     // -- Remove potentially confusing
     | project-away 
         SubjectUserName,
         SubjectAccount
 };
 RegistryEvents
 ```
