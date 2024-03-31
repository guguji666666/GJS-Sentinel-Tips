## IdentityProtection-ResponseFromTeams

Select the teamplate from porta <br>
![image](https://user-images.githubusercontent.com/96930989/234742444-f31f708c-eea3-4186-95cf-7f3ce6e07451.png)

![image](https://user-images.githubusercontent.com/96930989/223096206-6dbec184-c6f3-4861-aea5-819764fe4362.png)

### Modify Compose-Adaptive card body
```json
{
  "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
  "actions": [
    {
      "data": {
        "x": "confirm"
      },
      "title": "Confirm user as compromised",
      "type": "Action.Submit"
    },
    {
      "data": {
        "x": "dismiss"
      },
      "title": "Dismiss the risky user",
      "type": "Action.Submit"
    },
    {
      "data": {
        "x": "ignore"
      },
      "title": "Ignore",
      "type": "Action.Submit"
    }
  ],
  "body": [
    {
      "size": "large",
      "text": "@{triggerBody()?['object']?['properties']?['title']}",
      "type": "TextBlock",
      "weight": "bolder"
    },
    {
      "spacing": "Medium",
      "text": "Incident @{triggerBody()?['object']?['properties']?['incidentNumber']}, created by the provider:@{join(triggerBody()?['object']?['properties']?['additionalData']?['alertProductNames'], ',')}",
      "type": "TextBlock"
    },
    {
      "text": "[Click here to view the Incident](@{triggerBody()?['object']?['properties']?['incidentUrl']})",
      "type": "TextBlock",
      "wrap": true
    },
    {
      "size": "Large",
      "spacing": "Medium",
      "text": "AAD Identity Protection Risky user info:",
      "type": "TextBlock",
      "weight": "Bolder"
    },
    {
      "text": "Risky user display name: @{body('Get_risky_user')?['userDisplayName']}",
      "type": "TextBlock"
    },
    {
      "text": "Risky user principal name: @{body('Get_risky_user')?['userPrincipalName']}",
      "type": "TextBlock"
    },
    {
      "text": "Risk detail: @{body('Get_risky_user')?['riskDetail']}",
      "type": "TextBlock"
    },
    {
      "text": "Risk state: @{body('Get_risky_user')?['riskState']}",
      "type": "TextBlock"
    },
    {
      "text": "User risk level:  @{body('Get_risky_user')?['riskLevel']}",
      "type": "TextBlock"
    },
    {
      "size": "Large",
      "spacing": "Large",
      "text": "Respond:",
      "type": "TextBlock",
      "weight": "Bolder"
    },
    {
      "size": "Small",
      "style": "Person",
      "type": "Image",
      "url": "https://connectoricons-prod.azureedge.net/releases/v1.0.1391/1.0.1391.2130/azuresentinel/icon.png"
    },
    {
      "text": "Close Azure Sentinel incident?",
      "type": "TextBlock"
    },
    {
      "choices": [
        {
          "isSelected": true,
          "title": "Close incident - False Positive - Incorrect alert logic",
          "value": "False Positive - Incorrect alert logic"
        },
        {
          "isSelected": true,
          "title": "Close incident - False Positive - Inaccurate data",
          "value": "False Positive - Inaccurate data"
        },
        {
          "isSelected": true,
          "title": "Close incident - True Positive",
          "value": "True positive - Suspicious activity"
        },
        {
          "title": "Close incident - Benign Positive",
          "value": "Benign Positive - Suspicious but expected"
        },
        {
          "title": "No",
          "value": "no"
        }
      ],
      "id": "incidentStatus",
      "style": "compact",
      "type": "Input.ChoiceSet",
      "value": "BenignPositive"
    },
    {
      "text": "Change Azure Sentinel incident severity?",
      "type": "TextBlock"
    },
    {
      "choices": [
        {
          "isSelected": true,
          "title": "High",
          "value": "High"
        },
        {
          "title": "Medium",
          "value": "Medium"
        },
        {
          "title": "Low",
          "value": "Low"
        },
        {
          "title": "Don't change",
          "value": "same"
        }
      ],
      "id": "incidentSeverity",
      "style": "compact",
      "type": "Input.ChoiceSet",
      "value": "High"
    },
    {
      "text": "Respose in Identity Protection:",
      "type": "TextBlock"
    },
    {
      "size": "Small",
      "style": "Person",
      "type": "Image",
      "url": "https://connectoricons-prod.azureedge.net/releases/v1.0.1400/1.0.1400.2154/azureadip/icon.png"
    }
  ],
  "type": "AdaptiveCard",
  "version": "1.0"
```

### Sample output

![image](https://user-images.githubusercontent.com/96930989/223096533-7b810229-5416-4bd0-a17b-2c904c8e297e.png)

![image](https://user-images.githubusercontent.com/96930989/223096577-f1227fc2-499c-4679-b4d7-504709fb32c2.png)

Once we close the incident in teams, the incident is closed in sentinel as well
