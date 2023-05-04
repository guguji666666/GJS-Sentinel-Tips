# Useful workbooks in Sentinel
## 1. Sentinel central incidents
* [Announcing: Azure Sentinel Central Workbook](https://www.linkedin.com/pulse/announcing-azure-sentinel-central-workbook-clive-watson)
* [SentinelCentral Workbook](https://github.com/Azure/Azure-Sentinel/blob/master/Workbooks/SentinelCentral.json)
* [Deploy the workbook](https://github.com/clivewatson/KQLpublic/blob/master/README.md)

### Installation guidance
#### 1. Copy the json file from [SentinelCentral Workbook](https://github.com/Azure/Azure-Sentinel/blob/master/Workbooks/SentinelCentral.json)
#### 2. Add workbook 
Into Azure monitor : Open Azure Monitor Workbooks (from portal.azure.com) - open the “empty” Azure Monitor Workbook, in “advanced edit” mode (press the </> icon ). [paste] over any json that exists.

![image](https://user-images.githubusercontent.com/96930989/236176554-9f426255-e8b6-4a98-b7ce-6562d29d506b.png)

![image](https://user-images.githubusercontent.com/96930989/236176618-b428b3d4-addc-492f-978f-aab29c216fa0.png)

Into Sentinel: create a New Workbook: Add-Workbook --> Edit --> then use Advanced Edit (press the </> icon) then [paste] over any json that exists.
Then Press [apply] then [Done Editing]

![image](https://user-images.githubusercontent.com/96930989/236176750-85ae5a43-9ca5-46f8-ba93-5e7e0ec0decb.png)

The workbook looks like <br>
![image](https://user-images.githubusercontent.com/96930989/236177336-e8643180-78cf-42c0-9fa2-3b14abac5b72.png) <br>
![image](https://user-images.githubusercontent.com/96930989/236177218-dc429353-de44-43f6-ba31-7d0bcb619b87.png)
