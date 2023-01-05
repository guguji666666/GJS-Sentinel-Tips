# Deploy free TAXII Feed - `Pulsedive` in Sentinel

### 1. Create a free Pulsedive account at https://pulsedive.com/register
![image](https://user-images.githubusercontent.com/96930989/210725910-a9c96f0b-caf6-4433-bfa5-b14e83dfd985.png)
### 2. For test purpose we will use free feed plan. You can also check the plan in https://pulsedive.com/api/taxii
![image](https://user-images.githubusercontent.com/96930989/210726190-6b6f054f-4886-4e03-9664-b5649232cb67.png)
### 3. In Sentinel, configure the TAXII client in Sentinel with the following information:
`API root`
```
https://pulsedive.com/taxii2/api/
```
`Collection ID`
```
981c4916-ebb2-4567-aece-54ae970c4230
```
`Username`
```
taxii2
```
`Password`
```
your `API key` which can be found on your account page https://pulsedive.com/api/taxii
```
![image](https://user-images.githubusercontent.com/96930989/210726680-05da9fef-43ba-4e00-a3a1-72fced7cad89.png)

More details could be found in Pulsedive’s TAXII documentation https://pulsedive.com/api/taxii

Once the creation is done, wait for 10 mins and see if the results are updated
![image](https://user-images.githubusercontent.com/96930989/210726782-3b0868ce-d84e-40a3-8bdb-122253a99eba.png)

The results are supposed to be updated soon if the configuration is correct
![image](https://user-images.githubusercontent.com/96930989/210726819-b176dcd0-10f1-4c8d-85da-79f90421a105.png)
