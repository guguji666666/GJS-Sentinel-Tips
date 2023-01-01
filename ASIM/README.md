# ASIM MS Doc
https://learn.microsoft.com/en-us/azure/sentinel/normalization

# ASIM advantages
1. Cross source detection
2. Source agnostic content.
3. Support for your custom sources
4. Ease of use

# ASIM components
https://learn.microsoft.com/en-us/azure/sentinel/normalization#asim-components

![image](https://user-images.githubusercontent.com/96930989/210162551-878076e4-3fda-4419-b7cd-ae9fc48c58e8.png)

1. Normalized schemas	
```note
Standard sets of predictable event types
Each schema defines:
1. The fields that represent an event
2. A normalized column naming convention
3. A standard format for the field values.

Shcemas supported by ASIM:
- Audit Event
- Authentication Event
- DHCP Activity
- DNS Activity
- File Activity
- Network Session
- Process Event
- Registry Event
- User Management
- Web Session
```
2. Parsers
```note
Map existing data to the normalized schemas using KQL functions.
Built in parsers could be deployed from MS github
```
3. Content for each normalized schema
```note
1. Analytics rules
2. Workbooks
3. Hunting queries
...
Without the need to create source-specific content.
```

# ASIM terminology
https://learn.microsoft.com/en-us/azure/sentinel/normalization#asim-terminology
