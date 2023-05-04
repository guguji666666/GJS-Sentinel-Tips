# Useful workbooks in Sentinel
## 1. Sentinel central incidents
* [Announcing: Azure Sentinel Central Workbook](https://www.linkedin.com/pulse/announcing-azure-sentinel-central-workbook-clive-watson)
* [SentinelCentral Workbook](https://github.com/Azure/Azure-Sentinel/blob/master/Workbooks/SentinelCentral.json)
* [Deploy the workbook](https://github.com/clivewatson/KQLpublic/blob/master/README.md)

### Installation guidance
#### 1. Copy the json file from [SentinelCentral Workbook](https://github.com/Azure/Azure-Sentinel/blob/master/Workbooks/SentinelCentral.json)
#### 2. Add workbook 
Into Azure monitor : Open Azure Monitor Workbooks (from portal.azure.com) - open the “empty” Azure Monitor Workbook, in “advanced edit” mode (press the </> icon ). [paste] over any json that exists.

Into Sentinel: create a New Workbook: Add-Workbook --> Edit --> then use Advanced Edit (press the </> icon) then [paste] over any json that exists.
Then Press [apply] then [Done Editing]
