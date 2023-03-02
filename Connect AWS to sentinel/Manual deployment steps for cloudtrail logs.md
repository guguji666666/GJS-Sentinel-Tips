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

### 6. [Apply required policies at SQS](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#common-policies)
Navigate to the SQS you just created, go to Access policy > Edit
![image](https://user-images.githubusercontent.com/96930989/222447122-42a4a893-a86e-4ccc-abe7-8a8c7b4f7b67.png)


Replace the SQS policy with the context here, fill in the parameters in your exact environment and save
![image](https://user-images.githubusercontent.com/96930989/222446720-7d3cc516-5cc4-4fd5-b24b-692c5336473b.png)

### 7. [Apply required policies at S3 bucket](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#cloudtrail)

Navigate to S3 bucket you created before, check the bucket policy here
![image](https://user-images.githubusercontent.com/96930989/222449009-105e78f2-7110-43f7-8dd6-b3ddd45b95e2.png)

Find the Cloudtrail section in [AWS S3 connector permissions policies
](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#cloudtrail)

![image](https://user-images.githubusercontent.com/96930989/222449604-8a2b8d62-0fee-449e-bf9d-c4f700bd2044.png)

The S3 bucket must have the polices below
![image](https://user-images.githubusercontent.com/96930989/222449934-37c07d42-7288-4422-8a32-cf22e791cdfa.png)

and 

![image](https://user-images.githubusercontent.com/96930989/222449974-20b7fead-5088-4f3f-ba27-127a9b96505c.png)

or

![image](https://user-images.githubusercontent.com/96930989/222450051-0dfed638-5068-4901-b6a4-64e85d711e6a.png)


### 8. [Enable notification to SQS at S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-event-notifications.html)

Please notice the FIFO SQS is not supported here
![image](https://user-images.githubusercontent.com/96930989/222451588-b92724f3-41c7-4bc6-99d4-a95f9da12b0a.png)

We must use a standard SQS
![image](https://user-images.githubusercontent.com/96930989/222451874-677366a7-2eed-411c-934a-8127b4bd6629.png)


### 9. Complete configuration in Microsft Sentinel

![image](https://user-images.githubusercontent.com/96930989/222452552-e95cafc7-8341-4c51-93fa-538ff8b776db.png)

![image](https://user-images.githubusercontent.com/96930989/222452671-29389980-b7a0-4ddf-9fd5-f3611fb8c762.png)

### 10. Wait for 2 hours and check incoming logs in sentinel

