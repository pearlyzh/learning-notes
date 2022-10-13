## Cloud computing
The practice of using a network of remote servers hosted on the internet to store, manage and process data, rather than a local server or a personal computer.

### On-premis - Cloud Providers
 - You own the servers - Someone else owns the servers
 - You hire the IT people - Someone else hires the IT people
 - You pay or rent the real estate - Someone else pays or rents the real-estate
 - You take all the risk - You are responsible for configuring cloud services and the code, someone else takes care of the rest.

 ### The evolution of Cloud hosting
 - Dedicated server -> very expensive, high maintanence, high security
    - You have to guess your capacity
    - Takeing care all the risks
 - Virtual Private server: 1 physical machine. The physical machine is virtualized into sub-machines -> Better utilization and Isolation of Resources
    - Run multiple virtual machine in one machine
    - Share by multiple customers
 - Shared hosting: 1 physical machine. **shared by hundred of businesses** -> Very cheap, limited functionality, POOR isolation
 - Cloud hosting: MUTIPLE physical machines that acts as one system. The system is abstracted into multiple cloud services, High configurability

### A cloud service provider (CSP)
 - provides multiple cloud services e.g. tens to hundred of services
 - can be chained together to create cloud architectures
 - are accessible through single UNIFIED API - AWS API
 - utilized metered billing based on usage e.g. per second, per hour
 - has rich monitoring built-in
 - has infrastructure as service (IaaS) offering
 - offers automation via Infrastructure as Code (IaC)
 - can be grouped into various types of services:
    - Compute
    - Networking
    - Storage
    - Databases

### Types of computing
 - Saas Software as service: The product that is run and managed by the service provider. *We don't worry about how the service is maintained. It just works and remains available* -> Office365, Gmail,... -> **For customer**
 - Paas Platform as service: Focus on the deployment of your apps. *We don't worry about the provisoning, configuring, understanding the hardware or OS* -> Heroku,... -> **For Developer**
 - Iaas Infrastructure as a service. *We don't worry about the IT staff, data centers and hardware*

### Cloud computing deployment models
 - Public cloud
    - Everything is built on CSP, aka cloud-native or cloud-first.
 - Private cloud
    - Everything built on company's datacenters aka On-premise.
    - The cloud could be open-stack
 - Hybrid
    - Using both On-premise and A cloud service provider.
 - Cross-cloud
    - Using Multiple Cloud provider aka multi-cloud, hybrid-cloud


## Get your hands dirty
AWS Identity and Access Management: provides fine-grained access control across all of AWS. With IAM, you can specify who can access which services and resources, and under which conditions.

### Set up a budget with alert SNS
Create the topic with following the access policy (you have to modify the policy json config object):
```js
{
    "Sid": "AWSBudgets-notification-1",
    "Effect": "Allow",
    "Principal": {
    "Service": "budgets.amazonaws.com"
    },
    "Action": "SNS:Publish",
    "Resource": "arn:aws:sns:us-east-1:522041929868:default_cloudwatch_alarm"
}
```

### Billing
Cost Management Preferences:
 - Receive Free Tier Usage Alerts
 - Receive Billing Alerts
https://us-east-1.console.aws.amazon.com/billing/home?region=us-east-1#/preferences

### Config alert using cloud-watch
 - https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#alarmsV2:edit/JamesSimpleBillingAlarm?~(Page~'Actions~AlarmType~'MetricAlarm~AlarmData~(Metrics~(~(MetricStat~(Metric~(MetricName~'EstimatedCharges~Namespace~'AWS*2fBilling~Dimensions~(~(Name~'Currency~Value~'USD)))~Period~21600~Stat~'Maximum)~Id~'m1~ReturnData~true)~(Id~'ad1~Expression~'ANOMALY_DETECTION_BAND*28m1*2c*2015*29~ReturnData~true~Label~'EstimatedCharges*20*28expected*29))~AlarmName~'JamesSimpleBillingAlarm~AlarmDescription~'~ActionsEnabled~true~ComparisonOperator~'LessThanLowerOrGreaterThanUpperThreshold~ThresholdMetricId~'ad1~DatapointsToAlarm~1~EvaluationPeriods~1~TreatMissingData~'missing~AlarmActions~(~'arn*3aaws*3asns*3aus-east-1*3a522041929868*3adefault_cloudwatch_alarm)~InsufficientDataActions~(~)~OKActions~(~)))
 - https://stackoverflow.com/questions/67680601/whats-the-difference-between-alarm-budget-and-cloudwatch-alarms-billing

### AWS Free Tier

### Turning on MFA
Multi-factor authentication (MFA) in AWS is a simple best practice that adds an extra layer of protection on top of your user name and password.


---
# AWS certified Solution architecture
## Amazon Simple Storage Service (Amazon S3) and Amazon Glacier Storage
### S3 ### 
- provides developers and IT teams with secure, durable cloud storage.
- highly-scalable easy-to-use **object storage** with a simple web service interface that you can use to store and retrieve any amount of data from anywhere on the web.
- serves as one of the foundational web services—nearly any application running in AWS uses Amazon S3, either directly or indirectly, can be used alone or in conjunction with other AWS services, and it offers a very high level of integration with many other AWS cloud services.
   - serves as the durable target storage for Amazon Kinesis and Amazon
   Elastic MapReduce (Amazon EMR)
   - used as the storage for Amazon Elastic Block Store (Amazon EBS) and Amazon Relational Database Service (Amazon RDS) snapshots
   - used as a data staging or loading storage mechanism for Amazon Redshift and Amazon DynamoDB.

**Use cases**
- Backup and archive for on-premises or cloud data
- Content, media, and software storage and distribution
- Big data analytics
- Static website hosting
- Cloud-native mobile and Internet application hosting
- Disaster recovery

**Classes**
- general purpose
- infrequent access
- archive
- RRS or Amazon Glacier

**Lifecycle policies**
You can have your data automatically migrate to the most appropriate
storage class, without modifying your application code. In order to control who has access to your data, Amazon S3 provides a rich set of permissions, access controls, and encryption options.

**Structure**
Each Amazon S3 object contains both data and metadata. Objects reside in containers called **buckets**, and each object is identified by a unique user-specified key (filename). Buckets are a
simple flat folder with no file system hierarchy. That is, you can have multiple **buckets**, but you can't have a sub-bucket within a bucket. Each bucket can hold an unlimited number of objects.

It is easy to think of an Amazon S3 object (or the data portion of an object) as a file, and the key as the filename. However, keep in mind that Amazon S3 is not a traditional file system and differs in significant ways.  
 - you GET an object or PUT an object, operating on the whole object at once, instead of incrementally updating portions of the object as you would with a file. 
 - You can't "mount" a bucket, "open" an object, install an operating system on Amazon S3, or run a database on it.
 - a single bucket can store an unlimited number of files
 - **Automatically replicated on multiple devices in multiple facilities within a region**
- **Automatically partitions buckets to support very high request rates and simultaneous access by many clients**

### Glacier ###
- is another cloud storage service related to Amazon S3, but optimized for data archiving and long-term backup at extremely low cost. 
- is suitable for "cold data" which is data that is rarely accessed and for which a retrieval time of three to five hours is acceptable.
- can be used both as a storage class of Amazon S3, and as an independent archival storage service

```
Object Storage versus Traditional Block and File Storage
 - Block storage operates at a lower level — the raw storage device level — and manages data as a set of numbered, fixed-size blocks.
 - File storage operates at a higher level — the operating system level — and manages data as a named hierarchy of files and folders.

Block and file storage are often accessed over a network in the form of a Storage Area Network (SAN) for block storage, using protocols such as iSCSI or Fibre Channel, or as a Network Attached Storage (NAS) file server or "filer" for file storage, using protocols such as Common Internet File System (CIFS) or Network File System (NFS)

Object storage is something quite different, Amazon S3 is cloud object storage.
Instead of being closely associated with a server, Amazon S3 storage is independent of a server and is accessed over the Internet. Instead of managing data as blocks or files using SCSI, CIFS, or NFS protocols, data is managed as objects using an Application Program Interface (API) built on standard HTTP verbs
```

**Internals**

*Budget*
- Every Amazon S3 object is contained in a bucket. 
- Buckets form the top-level namespace for Amazon S3, and bucket names are global
- Bucket Name must be unique across all AWS accounts, much like Domain Name System (DNS) domain names, not just within your own account.


*Region*
- each Amazon S3 bucket is created in a specific region
- can create and use buckets that are located close to a particular set of end users or customers in order to minimize latency, or located in a particular region to satisfy data locality and sovereignty concerns, or located far away from your primary facilities in order to satisfy disaster recovery and compliance needs.


### Amazon Glacier ###
