## Export GuardDuty logs to S3 bucket (manual deployment)

## Reference doc
* [Manual setup](https://learn.microsoft.com/en-us/azure/sentinel/connect-aws?tabs=s3#manual-setup)
* [Common SQS policy and S3 bucket policy](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#common-policies)
* [Permission set on S3 bucket for GuardDuty logs](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#guardduty-policies)

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
* KMS access (will configured manually in the policy)

Create the custom role

![image](https://user-images.githubusercontent.com/96930989/222441344-d9b584ed-b27d-470c-b125-feb32fa07324.png)

Double check the IAM permissions and confirm creation

![image](https://user-images.githubusercontent.com/96930989/228408859-8aee4b45-348d-46a5-b8e6-7cce4b6baf97.png)


### 5. Configure an AWS service to export GuardDuty logs to an S3 bucket

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

Review the configuration of KMS key before creation, then click Finish, new KMS key will show here

![image](https://user-images.githubusercontent.com/96930989/228522207-4f812fcd-00cd-474f-a924-652c6fbb13ab.png)

### 6. [Granting GuardDuty permission to the KMS key](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_exportfindings.html)

The steps are listed here

![image](https://user-images.githubusercontent.com/96930989/228267328-edc75518-ba0c-4074-a4ca-8b495292ff80.png)

#### a. [Assign policy to KMS key > Allows GuardDuty to decrypt the logs it sends to S3 bucket](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#kms-policy)

Open the [AWS KMS console](https://console.aws.amazon.com/kms)

To change the AWS Region, use the Region selector in the upper-right corner of the page.

Navigate to `Customer managed keys`

Create a new key or choose an existing key that you plan to use for encrypting exported findings. The key must be in the same Region as the bucket, however, you can use this same bucket and key pair for each Region from where you want to export findings.

Choose your key. Under General configuration panel, copy the key ARN.

![image](https://user-images.githubusercontent.com/96930989/228523367-27777636-d15c-45ee-a205-97fa7f26e2a1.png)

In the Key policy section, choose `Switch to policy view` > `Edit`.

![image](https://user-images.githubusercontent.com/96930989/228271299-d01ec73f-4839-4d07-92a4-f837873a00e4.png)

The orginal KMS policy looks like this

![image](https://user-images.githubusercontent.com/96930989/228523582-ded4a8a2-a937-4218-ba07-811788540643.png)

Add the following key policy to your KMS key, granting GuardDuty access to your key.
When editing the key policy, make sure your JSON syntax is valid, if you add the statement before the final statement, you must add a comma after the closing bracket.

{roleArn}	The ARN of the assumed role you have created for the AWS Sentinel account

```json
{
  "Statement": [
    {
      "Sid": "Allow GuardDuty to use the key",
      "Effect": "Allow",
      "Principal": {
        "Service": "guardduty.amazonaws.com"
      },
      "Action": "kms:GenerateDataKey",
      "Resource": "*"
    },
    {
      "Sid": "Allow use of the key",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${The ARN of the assumed role you have created for the AWS Sentinel account}"
        ]
      },
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": "*"
    }
  ]
}
```

Once the policy is added, click Save

In my lab, the KMS policy looks like

```json
{
  "Id": "key-consolepolicy-3",
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "Enable IAM User Permissions",
          "Effect": "Allow",
          "Principal": {
              "AWS": "arn:aws:iam::03xxxxxx:root"
          },
          "Action": "kms:*",
          "Resource": "*"
      },
      {
        "Sid": "Allow GuardDuty to use the key",
        "Effect": "Allow",
        "Principal": {
          "Service": "guardduty.amazonaws.com"
        },
        "Action": "kms:GenerateDataKey",
        "Resource": "*"
      },
      {
        "Sid": "Allow use of the key",
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::03xxxxxxx:role/demo-customrole1-guardduty-manual"
          ]
        },
        "Action": [
          "kms:Decrypt"
        ],
        "Resource": "*"
      }
  ]
}
```

![image](https://user-images.githubusercontent.com/96930989/228524624-d46c0475-cadf-4c79-b69e-7ee173c31427.png)

#### b. [Granting GuardDuty permissions to a S3 bucket > Additional policies to allow GuardDuty to send logs to S3 and read the data using KMS ](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#s3-policies)

![image](https://user-images.githubusercontent.com/96930989/228470717-509312af-70c7-4cd9-99fd-a3d183e2d394.png)

![image](https://user-images.githubusercontent.com/96930989/228470873-9dc0a427-37cb-4297-8403-1b2d7ef3c5fb.png)

Replace with the policy below

* {roleArn}	The ARN of the assumed role you have created for the AWS Sentinel account

* {bucketName}	The name of your S3 bucket

* {kmsArn}	The ARN of the key you created to encrypt/decrypt log files

```json
{
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "Allow Arn read access S3 bucket",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${roleArn}"
        },
        "Action": [
          "s3:GetObject"
        ],
        "Resource": "arn:aws:s3:::${bucketName}/*"
      },
      {
        "Sid": "Allow GuardDuty to use the getBucketLocation operation",
        "Effect": "Allow",
        "Principal": {
          "Service": "guardduty.amazonaws.com"
        },
        "Action": "s3:GetBucketLocation",
        "Resource": "arn:aws:s3:::${bucketName}"
      },
      {
        "Sid": "Allow GuardDuty to upload objects to the bucket",
        "Effect": "Allow",
        "Principal": {
          "Service": "guardduty.amazonaws.com"
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${bucketName}/*"
      },
      {
        "Sid": "Deny unencrypted object uploads. This is optional",
        "Effect": "Deny",
        "Principal": {
          "Service": "guardduty.amazonaws.com"
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${bucketName}/*",
        "Condition": {
          "StringNotEquals": {
            "s3:x-amz-server-side-encryption": "aws:kms"
          }
        }
      },
      {
        "Sid": "Deny incorrect encryption header. This is optional",
        "Effect": "Deny",
        "Principal": {
          "Service": "guardduty.amazonaws.com"
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${bucketName}/*",
        "Condition": {
          "StringNotEquals": {
            "s3:x-amz-server-side-encryption-aws-kms-key-id": "${kmsArn}"
          }
        }
      },
      {
        "Sid": "Deny non-HTTPS access",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": "arn:aws:s3:::${bucketName}/*",
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "false"
          }
        }
      }
    ]
  }




```

Once the policy is added, click save changes

![image](https://user-images.githubusercontent.com/96930989/228473968-9e0fbb73-8323-4b39-bb44-b447571e033e.png)


### 7. [Exporting GuardDuty findings to a bucket with the Console](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_exportfindings.html)

The steps to configure exporting GuardDuty findings to a S3 bucket are listed here

Please notice that The KMS key and S3 bucket must be in the same Region.

![image](https://user-images.githubusercontent.com/96930989/228474840-cf122f8b-727a-41b9-8deb-aded1cd774d2.png)

Navigate to [GuardDuty console](https://console.aws.amazon.com/guardduty)

![image](https://user-images.githubusercontent.com/96930989/228476241-50c2d6c1-85ad-4cca-a769-69c980369e3a.png)

![image](https://user-images.githubusercontent.com/96930989/228526058-941bf357-5817-4762-b6a6-418b83897253.png)

### 8. [Apply required policies at SQS](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#common-policies)

Navigate to the SQS you just created, go to Access policy > Edit

![image](https://user-images.githubusercontent.com/96930989/228479334-0fe4d692-9942-47ee-862b-4e5b91e80a2f.png)


Replace the SQS policy mentioned [here](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/AwsRequiredPolicies.md#sqs-policy) and save
* {roleArn}	The ARN of the assumed role you have created for the AWS Sentinel account
* {sqsArn}	The ARN of the SQS queue you created, to which this policy will apply
* {bucketName}	The name of the S3 bucket you are giving send permissions to

```json
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "allow s3 to send notification messages to SQS queue",
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "SQS:SendMessage",
      "Resource": "${sqsArn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:s3:*:*:${bucketName}"
        }
      }
    },
    {
      "Sid": "allow specific role to read/delete/change visibility of SQS messages and get queue url",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${roleArn}"
      },
      "Action": [
        "SQS:ChangeMessageVisibility",
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:GetQueueUrl"
      ],
      "Resource": "${sqsArn}"
    }
  ]
}
```

### 10. [Enable notification to SQS at S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-event-notifications.html)

Navigate to [S3 bucket console](https://console.aws.amazon.com/s3)

Please notice the FIFO SQS is `not supported` here

![image](https://user-images.githubusercontent.com/96930989/228526946-148c08c2-98aa-4b3a-88ba-16b17a9b01fd.png)

We must use a standard SQS and then the configuration could be saved successfully

![image](https://user-images.githubusercontent.com/96930989/228488200-aff3ba42-9bcc-4c76-a6e4-aca4aec0aee7.png)

### 11. Complete configuration in Microsoft Sentinel

![image](https://user-images.githubusercontent.com/96930989/228527641-0a7bb359-19b0-4d43-ae3f-1440158859c1.png)

![image](https://user-images.githubusercontent.com/96930989/228527810-9cab37bf-21d1-4b6c-95a5-43680eb7570b.png)

### 12. Wait for 1 hour and check incoming GuardDuty logs in sentinel

![image](https://user-images.githubusercontent.com/96930989/228513539-b61d9331-380e-4c06-9aa5-8cbe04ac9ed5.png)

