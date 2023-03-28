## Export GuardDuty logs to S3 bucket (manual deployment)

## Reference doc
* [Manual setup](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#manual-setup)
* [Common SQS policy and S3 bucket policy](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#sqs-policy)
* [Permission set on S3 bucket for GuardDuty logs](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#guardduty-policies)

## Known issues

Different types of logs can be stored in the same S3 bucket, but `should not be` stored in the same path.

Each SQS queue should point to one type of message, so if you want to ingest `GuardDuty findings` and `VPC flow logs`, you should set up `separate queues` for each type.

Similarly, a single SQS queue can serve only one path in an S3 bucket, so if for any reason you are storing logs in multiple paths, each path requires its own dedicated SQS queue.

SQS > S3 bucket > S3 bucket paths 

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

Double check the IAM permissions once the role is created

![image](https://user-images.githubusercontent.com/96930989/222441545-9cf3802c-e5a0-4205-9168-fcfa1bbd2382.png)


### 5. Configure an AWS service to export logs to an S3 bucket

#### a. First, [Enable GuardDuty source in AWS](https://aws.amazon.com/guardduty/getting-started/)
![image](https://user-images.githubusercontent.com/96930989/228255018-70dfed1c-be04-4707-b1a2-3142207eba1c.png)

![image](https://user-images.githubusercontent.com/96930989/228255728-06b655ed-aeb8-4bb1-973e-0995083c2fa8.png)

![image](https://user-images.githubusercontent.com/96930989/228255858-b0b9136f-52af-4c54-b2d5-08bfb33d6378.png)

![image](https://user-images.githubusercontent.com/96930989/228257589-2a4e9a76-52e4-42f1-b095-8c2f6a26fb7b.png)

#### b. Now that the source is enabled, we need to configure [Exporting GuardDuty findings to S3 bucket](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_exportfindings.html)

![image](https://user-images.githubusercontent.com/96930989/228262959-065a2e6b-3c79-4297-bbdf-5bd2c9eedfdb.png)

GuardDuty supports exporting active findings to CloudWatch Events and, optionally, to an `Amazon S3 bucket`. 

New Active findings that GuardDuty generates are automatically exported within about `5 minutes` after the finding is generated.

#### Note !

Export settings are regional, which means you need to configure export options for each Region in which you're using GuardDuty. However, you can use the same bucket in a single Region as the export destination for each Region you use GuardDuty in.

`Archived findings`, including new instances of `suppressed findings`, `aren't exported`. If you unarchive a finding, its status is updated to Active, and it will be exported at the next interval.

If you enable findings export in a GuardDuty administrator account all findings from associated member accounts that are generated in the current Region are also exported to the same location that you configured for the administrator account.

To configure settings for exporting Active findings to an Amazon S3 bucket you will need :
* A `KMS key` that GuardDuty can use to encrypt findings
* An S3 bucket with permissions that allows GuardDuty to upload objects

#### Permissions required to configure findings export

In addition to permissions to `GuardDuty actions`, you must also have permissions to the `following actions` to successfully configure options for exporting findings.
* kms:ListAliases
* s3:CreateBucket
* s3:GetBucketLocation
* s3:ListAllMyBuckets
* s3:PutBucketAcl
* s3:PutBucketPublicAccessBlock
* s3:PutBucketPolicy
* s3:PutObject

#### c. [Create the KMS key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html)

During this process, you pick the type of the KMS key, its regionality (`single-Region` or `multi-Region`), and the origin of the key material (by default, AWS KMS creates the key material)

If you are creating a KMS key to `encrypt data` you store or manage in an AWS service, create a `symmetric encryption` KMS key. AWS services that are integrated with AWS KMS use `only symmetric encryption` KMS keys to encrypt your data. These services `do not` support encryption with asymmetric KMS keys

The steps to Create the KMS key in AWS console are listed here

![image](https://user-images.githubusercontent.com/96930989/228262729-d3ea5f51-a99e-44fc-8c5b-73a7a2434651.png)

![image](https://user-images.githubusercontent.com/96930989/228263559-e144a2b3-35e2-4610-abaf-45003ed28755.png)

![image](https://user-images.githubusercontent.com/96930989/228264518-0c8410f2-59ef-4483-a381-80afe9747c6e.png)

![image](https://user-images.githubusercontent.com/96930989/228264720-d1b8926f-409f-43b1-ba15-64614c8239c7.png)

Assign key administrators and manage key deletion

![image](https://user-images.githubusercontent.com/96930989/228264907-58d1e73e-ebf3-4e7b-bcdd-4ef6129755e6.png)

![image](https://user-images.githubusercontent.com/96930989/228265749-07287d2d-7d13-4b68-a14e-eb9d76a92310.png)

Review the configuration of KMS key before creation

![image](https://user-images.githubusercontent.com/96930989/228266081-4a005681-541e-46dc-811d-65e8584e2bda.png)



### 6. [Apply required policies at SQS](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#common-policies)

Navigate to the SQS you just created, go to Access policy > Edit

![image](https://user-images.githubusercontent.com/96930989/222447122-42a4a893-a86e-4ccc-abe7-8a8c7b4f7b67.png)


Replace the SQS policy with the context here, fill in the parameters in your exact environment and save

![image](https://user-images.githubusercontent.com/96930989/222446720-7d3cc516-5cc4-4fd5-b24b-692c5336473b.png)




### 7. [Apply required policies at S3 bucket](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#cloudtrail)

Navigate to S3 bucket you created before, check the bucket policy here

![image](https://user-images.githubusercontent.com/96930989/222449009-105e78f2-7110-43f7-8dd6-b3ddd45b95e2.png)




### 8. [Enable notification to SQS at S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-event-notifications.html)

Please notice the FIFO SQS is not supported here

![image](https://user-images.githubusercontent.com/96930989/222451588-b92724f3-41c7-4bc6-99d4-a95f9da12b0a.png)

We must use a standard SQS

![image](https://user-images.githubusercontent.com/96930989/222451874-677366a7-2eed-411c-934a-8127b4bd6629.png)


### 9. Complete configuration in Microsft Sentinel


### 10. Wait for 2 hours and check incoming logs in sentinel

