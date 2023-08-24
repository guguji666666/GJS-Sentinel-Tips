# Stream activity logs to sentinel workspace

## 1. Install `Azure activity` solution from `Sentinel > Content hub`, then wait for 10 min
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/b332cfd6-f6a2-4a94-bed7-9f28a9e20676)

## 2. Find `Azure Activity` in data connectors
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f80a66fa-c7fc-4a4f-a82b-d145f7d7616b)

## 3. Enter connector page
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/da44cd23-3ea7-4192-ab3e-2344db867ed6)

## 4. Assign azure policy to subscription(s)

### Define the assignment scope
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f8e3b54b-4977-4b4f-9cc7-2af876b955e2)

### Uncheck the box here and define the destination workspace
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/87bdd1e4-c820-4fc9-ab9b-e61db9db69a6)

### Create remediation task so that the existing subscription would be applied as well
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1a05f43b-d900-4454-8f91-a15e05543b7a)

### Review the configuration and confirm assignment
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/dac3fde6-2867-43f2-874e-c4ac27ce34a8)

### Wait until the remediation task completes, you can check the status here
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d59fc41c-a0c6-46f2-b577-9ebeba416e90)

## 5. Verify the data connector
Run the query to check the incoming activity logs
```kusto
AzureActivity
| order by TimeGenerated desc
```
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5384a03f-327f-4bc4-a969-e66aaeeeb809)
