# Export existing playbook to ARM template

## Export existing playbook to ARM template keeping the configuration inside
### 1. Navigate to the subscription where the playbook locates
![image](https://user-images.githubusercontent.com/96930989/210464795-b39b882c-10d1-4452-a94c-840577afb23a.png)
![image](https://user-images.githubusercontent.com/96930989/210464823-9a64843f-89f9-47af-ab36-eb8c6011c723.png)

### 2. Select the resources group where the playbook locates
![image](https://user-images.githubusercontent.com/96930989/210465404-b7f4f240-1a8b-468c-a212-03ce5fd42c07.png)

### 3. In `Resources`, modify the existing filter `Type`
* Operator `Equals`
* Value `logic app`
* Click `Apply`

![image](https://user-images.githubusercontent.com/96930989/210465594-41c56e5e-e8b2-455c-9366-52abc44c3240.png)

### 4. Check the box of the playbook, and click `Export template`

![image](https://user-images.githubusercontent.com/96930989/210465649-2dc0dd42-443a-4df0-9e85-07f3a7aef414.png)

### 5. Download the template

![image](https://user-images.githubusercontent.com/96930989/210465759-fceaafcf-c4cc-476c-91f7-647eeef6f760.png)


## Others
We will have security issue if we share the code view which contains sensitive information, correct the information to be shared template will take 30-45 minutes

![image](https://user-images.githubusercontent.com/96930989/228845984-d67bd6a4-301b-4769-a961-ab4b2fd05b3e.png)

### Export existing playbook to ARM template without any `tenant-specified` parameters inside
#### Documentation
* [Blog](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/export-microsoft-sentinel-playbooks-or-azure-logic-apps-with/ba-p/3275898)
* [Demo](https://www.youtube.com/watch?v=scTtVHVzrQw)
* [Github](https://github.com/Azure/Azure-Sentinel/tree/master/Tools/Playbook-ARM-Template-Generator)

#### Lab 

Run the powershell script

![image](https://user-images.githubusercontent.com/96930989/228847429-b0254bc4-bd4e-41dd-a6b9-bde4e481b347.png)

Updating Az module to latest version

![image](https://user-images.githubusercontent.com/96930989/228847491-58059fa6-4237-425b-8c83-460a87b8123e.png)

![image](https://user-images.githubusercontent.com/96930989/228847538-8cd0c50f-5c02-4e19-88c5-9692304bbb20.png)

![image](https://user-images.githubusercontent.com/96930989/228847582-faca5658-08b4-4bbc-93ea-8cf16ea9a7ec.png)

![image](https://user-images.githubusercontent.com/96930989/228847609-21d9d72f-d143-45f8-bc3f-c08de9b7bd9a.png)

![image](https://user-images.githubusercontent.com/96930989/228847637-5628d72a-a7f4-4539-9c6d-ddca22f07ff4.png)

![image](https://user-images.githubusercontent.com/96930989/228847665-5eb7d717-cfa5-4a86-ba7f-46d26002ae4c.png)

The ARM template will be found in the folder

![image](https://user-images.githubusercontent.com/96930989/228847802-87400fc1-2fd3-400a-942d-73b431529c2a.png)

Then we could deploy the playbook with empty ARM template

![image](https://user-images.githubusercontent.com/96930989/228847833-2b6523a8-2add-47e6-94ad-ecfa6576a93d.png)

Check the result in the portal
![image](https://user-images.githubusercontent.com/96930989/228847876-c3e35df4-d28c-4fa8-9cd4-cfdb2b0e0f8e.png)



