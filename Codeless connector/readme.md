## [Create a codeless connector for Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/create-codeless-connector?tabs=deploy-via-arm-template%2Cconnect-via-the-azure-portal#create-a-connector-json-configuration-file)

### Before we start

Before building a connector, we recommend that you learn and understand how your data source behaves and exactly how Microsoft Sentinel will need to connect.

For example, you'll need to understand the types of authentication, pagination, and API endpoints that are required for successful connections.

#### 1. Create basic config file in json format

```json
{
    "kind": "<name>",
    "properties": {
        "connectorUiConfig": {...
        },
        "pollingConfig": {...
        }
    }
}
```

##### ConnectorUiConfig
Defines the visual elements and text displayed on the data connector page in Microsoft Sentinel. For more information, see Configure your connector's user interface.

##### PollingConfig
Defines how Microsoft Sentinel collects data from your data source. For more information, see Configure your connector's polling settings.

#### 2. Configure your connector's user interface

![image](https://user-images.githubusercontent.com/96930989/228792795-759654cd-cb71-4e8b-b6f5-2f5f63a100d3.png)

1. Title. The title displayed for your data connector.

2. Icon. The icon displayed for your data connector.

3. Status. Describes whether or not your data connector is connected to Microsoft Sentinel.

4. Data charts. Displays relevant queries and the amount of ingested data in the last two weeks.

5. Instructions tab. Includes a Prerequisites section, with a list of minimal validations before the user can enable the connector, and an Instructions, with a list of instructions to guide the user in enabling the connector. This section can include text, buttons, forms, tables, and other common widgets to simplify the process.

6. Next steps tab. Includes useful information for understanding how to find data in the event logs, such as sample queries.


#### 3. [Configure your connector's polling settings](https://learn.microsoft.com/en-us/azure/sentinel/create-codeless-connector?tabs=deploy-via-arm-template%2Cconnect-via-the-azure-portal#configure-your-connectors-polling-settings)

Syntax of `pollingConfig`

```json
"pollingConfig": {
    auth": {
        "authType": <string>,
    },
    "request": {…
    },
    "response": {…
    },
    "paging": {…
    }
 }
 ```
