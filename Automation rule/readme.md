# Get automation rule id

#### 1. Go to automation tab and press `F12` and launch developer tool （Edge or Chrome browser）
#### 2. In the inspect window go to network and press clear.
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/66609bc4-1f86-49a0-9796-e3abbe16688c)

#### 3. Refresh the automation blade (not the browser) with the button near the create.
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/c00ffd4e-82c1-4ae1-b03c-493434b17d3d)

#### 4. Choose the network call which has “automationRules” as its prefix. 

#### 5. Each value represents a rule. The `name` of the rule is the ID we are looking for. 
![image](https://github.com/guguji666666/GJS-Sentinel-Tips/assets/96930989/6d72e114-0e28-4d9b-80f8-689ef9d9795c)
