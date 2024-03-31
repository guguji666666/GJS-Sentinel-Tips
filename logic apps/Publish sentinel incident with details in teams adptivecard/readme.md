## Publish sentinel incident with details in teams adaptive card

### 1. Create a new logic app

### 2. Set microsoft sentinel incident as the trigger
<img width="643" alt="image" src="https://user-images.githubusercontent.com/96930989/222393886-ccc024e3-990c-4c37-97d8-3bc4906fcb94.png">

### 3. Create two actions with `Initialize variables`
For action 1, name the operation, let's say `test1`

<img width="613" alt="image" src="https://user-images.githubusercontent.com/96930989/222394377-ba1a7bac-f3cb-42e0-95fa-df29a06b9170.png">

For action 2, in the value, input
```
replace(replace(string(variables('<name of the operation we defined before>')), '\', '\\'), '"', '\"')
```

```
replace(replace(string(variables('test1')), '\', '\\'), '"', '\"')
```
<img width="608" alt="image" src="https://user-images.githubusercontent.com/96930989/222394453-ccf04b20-0ef4-4d90-8778-cf89110fb2d9.png">

### 4. Configure the action in teams
<img width="675" alt="image" src="https://user-images.githubusercontent.com/96930989/222395825-5462c07b-06b0-4139-945d-db0dc08e8055.png">

Json file in adaptive card
```json
{
    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
    "msteams": {    "width": "Full"  },
    "type": "AdaptiveCard",
    "version": "1.0",
    "body": [
        {
            "type": "TextBlock",
            "text": "Incident title:@{triggerBody()?['object']?['properties']?['title']}",
            "id": "Title",
            "spacing": "Medium",
            "horizontalAlignment": "Center",
            "size": "ExtraLarge",
            "weight": "Bolder",
            "color": "Accent"
        },
        {
            "type": "TextBlock",
            "text": "Severity:@{triggerBody()?['object']?['properties']?['severity']}",
            "weight": "Bolder",
            "size": "ExtraLarge",
            "spacing": "None",
            "id": "acHeader"
        },
       {
            "type": "TextBlock",
            "text": "Description:@{triggerBody()?['object']?['properties']?['description']}",
            "weight": "Bolder",
            "size": "ExtraLarge",
           "spacing": "None"
        },
       {
            "type": "TextBlock",
            "text": "Incident ID:@{triggerBody()?['object']?['properties']?['incidentNumber']}",
            "weight": "Bolder",
            "size": "ExtraLarge",
            "spacing": "None"
        },
       {
            "type": "TextBlock",
            "text": "Incident creation time:@{triggerBody()?['object']?['properties']?['createdTimeUtc']}",
            "weight": "Bolder",
            "size": "ExtraLarge",
            "spacing": "None"
        },
       {
            "type": "TextBlock",
            "text": "Entities:",
            "weight": "Bolder",
            "size": "ExtraLarge",
            "spacing": "None"
        },
       {
            "type": "TextBlock",
            "text": "@{variables('test666')}",
            "weight": "Bolder",
            "size": "ExtraLarge",
            "spacing": "None",
            "wrap": true
        }
],  
    "actions": [
        {
            "type": "Action.OpenUrl",
            "title": "Incident URL",
            "url": "@{triggerBody()?['object']?['properties']?['incidentUrl']}"
        }
    ]
}
```


