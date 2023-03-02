## Manualy connect AWS to sentinel and send cloudtrail log

## Doc
* [Manual setup](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#manual-setup)
* [Common SQS policy and S3 bucket policy](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#sqs-policy)
* [Permission set on S3 bucket for cloudtrail logs](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#cloudtrail)

## Steps

### 1. [Create a Simple Queue Service (SQS) in AWS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/step-create-queue.html)
The type should be `standard`
<img width="1121" alt="image" src="https://user-images.githubusercontent.com/96930989/222417208-8a8ffb46-5381-4b47-8258-4c99a96eea40.png">

For `Redrive allow policy`, choose `Enabled`. Select one of the following: Allow all, By queue, or Deny all. 
<img width="1117" alt="image" src="https://user-images.githubusercontent.com/96930989/222417607-e500eb4c-b19c-4603-9817-465ccd4a8f81.png">

Create the SQS
<img width="1519" alt="image" src="https://user-images.githubusercontent.com/96930989/222417859-d4500195-ef9f-48f4-a964-00ea87f72fef.png">

### 2. [Create a S3 bucket in AWS](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html)
We followed the steps here
![image](https://user-images.githubusercontent.com/96930989/222437966-558e3637-ce38-4aea-8022-89cb5f70b9bf.png)

Uncheck the box
![image](https://user-images.githubusercontent.com/96930989/222438402-6dbeaae3-65c7-4759-990b-61ecf64e0d09.png)

![image](https://user-images.githubusercontent.com/96930989/222438326-a938532a-1165-415f-a6fe-58f8a2cfa041.png)



### 3. Create an AWS assumed role and grant access to the AWS Sentinel account



### 4. Configure an AWS service to export logs to an S3 bucket

### 5. Apply required IAM permissions to the custom role

### 6. Apply required policeis to SQS

### 7. Apply required policeis to S3 bucket

### 8. Enable SQS notification

### 9. Check incoming logs in sentinel

