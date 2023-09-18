# MDE device isolation

## 1. Install solution in sentinel content hub
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/bd4e7927-b1cf-4868-af31-10501d46424a)

## 2. Create the playbook based on the template
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/8db6a203-48ec-490b-a9c9-57eef60beab1)

## 3. Assign role "Microsoft Sentinel responder" role to the managed identity this logic app
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/245b3dc9-1f82-4ce3-a21f-1e6ba6bfcc1e)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/e3a36cfb-adbb-460e-92ed-6a985512e7a9)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/be7e1d9b-98f1-4167-9772-5d7c7d13aaa9)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5990fe1c-42ea-4616-b75f-7b3e912129a1)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/1e3e8209-2bcd-4d87-8674-4249432ed08f)

## 4. Copy the object id of logic app's managed identity to notepad, we need it later
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/63f91395-1616-436a-9286-c437197c8275)

## 5. Create MDE app

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a3fa9a3f-2a08-4e7d-abb5-b48e138ab613)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/83a440e5-ea9d-4386-951e-753aa2af1764)

![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/aa05a78e-71a2-4725-827d-a2cbff06f701)

## 6. Get the object id of the serviceprincipal of this MDE app
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/5c806be1-ef30-4d8b-a1c5-e75127470a52)

Copy the obejctid of this servicepricipal to notepad, we need it later
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/059a354f-7cd6-4ec5-a148-3ae28f0fe41a)

## 7. Add app role to this MDE app
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/f6d1661e-c117-40ed-8b87-9e700a6ab06e)

## 8. Run the powershell script in Azure CLI

```powershell
$TenantId = '<Your tenand id>'

$MIGuid = '<Enter your managed identity of logic app guid here>' 

Connect-AzureAD  -TenantId $TenantId
    
$MI = Get-AzureADServicePrincipal -ObjectId $MIGuid 
    
$MDESPObjectId = '<MDE app serviceprincipal object id>' 
    
$PermissionName = 'Machine.Isolate'
    
$MDEServicePrincipal = Get-AzureADServicePrincipal -ObjectId $MDESPObjectId
    
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'}

$AppRole | Format-List *

New-AzureAdServiceAppRoleAssignment -ObjectId $MDEServicePrincipal.ObjectId -PrincipalId $MI.ObjectId ` -ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id
```

### Sample
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/a73c30ed-dbce-4581-9f50-abea10d9988c) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/d633bc15-c5a7-4dfa-8b98-fa62383d6c66) <br>

### Validate if the permission has been assigned to the logic app
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/7d42249f-1ee9-412a-be67-091a98bb7d46) <br>
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/2c6591a5-0e2c-4a16-be97-3d3a9b8c4dbc)



