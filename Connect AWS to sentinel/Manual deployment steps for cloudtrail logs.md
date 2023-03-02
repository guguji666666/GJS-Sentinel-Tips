## Manualy connect AWS to sentinel and send cloudtrail log

## Doc
* [Manual setup](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#manual-setup)
* [Common SQS policy and S3 bucket policy](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#sqs-policy)
* [Permission set on S3 bucket for cloudtrail logs](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#cloudtrail)

## Steps
### 1. Create an AWS assumed role and grant access to the AWS Sentinel account

### 2. Create a Simple Queue Service (SQS) in AWS

### 3. Create a S3 bucket in AWS

### 4. Configure an AWS service to export logs to an S3 bucket

### 5. Apply required IAM permissions to the custom role

### 6. Apply required policeis to SQS

### 7. Apply required policeis to S3 bucket

### 8. Enable SQS notification

### 9. Check incoming logs in sentinel

