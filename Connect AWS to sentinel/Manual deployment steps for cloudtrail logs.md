## Manualy connect AWS to sentinel and send cloudtrail log

## Reference doc
* [Manual setup](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#manual-setup)
* [Common SQS policy and S3 bucket policy](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#sqs-policy)
* [Permission set on S3 bucket for cloudtrail logs](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#cloudtrail)

## Deployment steps

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

![image](https://user-images.githubusercontent.com/96930989/222438580-e8454639-589a-47d6-872c-ba538784c7cb.png)

Create the S3 bucket
![image](https://user-images.githubusercontent.com/96930989/222438834-76e2c6c9-527e-462a-9e1f-215ec5f7e63e.png)

### 3. [Create an AWS assumed role and grant access to the AWS Sentinel account](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#create-an-aws-assumed-role-and-grant-access-to-the-aws-sentinel-account)

### 4. Apply required IAM permissions to the custom role
* AmazonSQSReadOnlyAccess
* AWSLambdaSQSQueueExecutionRole
* AmazonS3ReadOnlyAccess
* KMS access (optional)

Create the custom role
![image](https://user-images.githubusercontent.com/96930989/222441344-d9b584ed-b27d-470c-b125-feb32fa07324.png)

Double check the IAM permissions once the role is created
![image](https://user-images.githubusercontent.com/96930989/222441545-9cf3802c-e5a0-4205-9168-fcfa1bbd2382.png)


### 5. Configure an AWS service to export logs to an S3 bucket

In this article we use cloudtrail as the source [Creating a trail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-create-a-trail-using-the-console-first-time.html)

![image](https://user-images.githubusercontent.com/96930989/222441761-ea2f17ae-75bc-45dc-bfe3-aa072fd43c0b.png)

We can use existing S3 bucket to store cloudtrail logs
![image](https://user-images.githubusercontent.com/96930989/222442908-c12e66d0-b81b-4d94-b42a-e9d5cf1ec6b8.png)

Create the cloudtrail
![image](https://user-images.githubusercontent.com/96930989/222444572-a02be7b1-4dcf-4378-973a-639b19e2291b.png)

### 6. Apply required policies to SQS

### 7. Apply required policies to S3 bucket

### 8. Enable SQS notification

### 9. Check incoming logs in sentinel

