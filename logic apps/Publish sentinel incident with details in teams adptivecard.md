## Publish sentinel incident with details in teams adaptivecard

```
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
