## Export VPC flow logs to Sentinel
## Export GuardDuty logs to S3 bucket (manual deployment)

## Reference doc
* [Manual setup](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#manual-setup)
* [Common SQS policy and S3 bucket policy](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#common-policies)
* [Publish VPC flow logs to Amazon S3](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-s3.html)

## Known issues

Different types of logs can be stored in the same S3 bucket, but `should not be` stored in the same path.

Each SQS queue should point to one type of message, so if you want to ingest `GuardDuty findings` and `VPC flow logs`, you should set up `separate queues` for each type.

Similarly, a single SQS queue can serve only one path in an S3 bucket, so if for any reason you are storing logs in multiple paths, each path requires its own dedicated SQS queue.

## Deployment steps

### 1. [Create a Simple Queue Service (SQS) in AWS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/step-create-queue.html)

The type should be `standard`

![image](https://user-images.githubusercontent.com/96930989/228193846-c73ad77e-b0cf-43a9-afcc-431d163ff197.png)


For `Redrive allow policy`, choose `Enabled`. Select one of the following: Allow all, By queue, or Deny all.

<img width="1117" alt="image" src="https://user-images.githubusercontent.com/96930989/222417607-e500eb4c-b19c-4603-9817-465ccd4a8f81.png">

Create the SQS

![image](https://user-images.githubusercontent.com/96930989/228194088-b0d6492a-2014-4055-a5e6-d87a0253596e.png)


### 2. [Create a S3 bucket in AWS](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html)

We followed the steps here if you want to create new S3 bucket

![image](https://user-images.githubusercontent.com/96930989/222437966-558e3637-ce38-4aea-8022-89cb5f70b9bf.png)

Uncheck the box

![image](https://user-images.githubusercontent.com/96930989/222438402-6dbeaae3-65c7-4759-990b-61ecf64e0d09.png)

![image](https://user-images.githubusercontent.com/96930989/222438580-e8454639-589a-47d6-872c-ba538784c7cb.png)

Create the S3 bucket

![image](https://user-images.githubusercontent.com/96930989/228222919-11e59408-76c8-476d-9c74-3e198f2b22be.png)


### 3. [Create an AWS assumed role and grant access to the AWS Sentinel account](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#create-an-aws-assumed-role-and-grant-access-to-the-aws-sentinel-account)


### 4. Apply required IAM permissions to the custom role
* AmazonSQSReadOnlyAccess
* AWSLambdaSQSQueueExecutionRole
* AmazonS3ReadOnlyAccess
* KMS access (optional)

Create the custom role

![image](https://user-images.githubusercontent.com/96930989/222441344-d9b584ed-b27d-470c-b125-feb32fa07324.png)

Double check the IAM permissions and confirm creation

![image](https://user-images.githubusercontent.com/96930989/228408859-8aee4b45-348d-46a5-b8e6-7cce4b6baf97.png)
