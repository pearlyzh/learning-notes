# Fundamentals

Region -> Avalaibility Zones -> Data center

The CTO asks during the project meeting, “What are the benefits of using AWS services?” The company is interested in learning about AWS services and tools that would best fit their needs.

-> AWS offers services such as compute, database, and storage
https://aws.amazon.com/vi/campaigns/migrating-to-the-cloud/ 

Customers move to AWS to increase agility. • Accelerate time to market – By spending less time acquiring and managing infrastructure, you can focus on developing features that deliver value to your customers.
• Increase innovation – You can speed up your digital transformation using AWS, which provides tools to more easily access the latest technologies and best practices. For example, you can use AWS to develop automations, adopt containerization, and use machine learning.
• Scale seamlessly – You can provision additional resources to support new features and scale existing resources up or down to match demand.
Customers also move to AWS to reduce complexity and risk. • Optimize costs – You can reduce costs by paying for only what you use. Instead of paying for on-premises hardware, which you might not be using at full capacity, you can pay for compute resources only while you are using them.
• Minimize security vulnerabilities – Moving to AWS puts your applications and data behind the advanced physical security of the AWS data centers. With AWS, you have many tools to manage access to your resources.
• Reduce management complexity – Using AWS services can reduce the need to maintain physical data centers, perform hardware maintenance, and manage physical infrastructure.

Infrastructure topic: https://drive.google.com/file/d/13O7BCkxORsoPC8XkH0Td2MNXDaMuHl2t/view?usp=share_link
Global physical organisation: https://drive.google.com/file/d/13O7BCkxORsoPC8XkH0Td2MNXDaMuHl2t/view?usp=share_link


## Things to consider deploying to AWS: 
- Governance and legal requirements – Consider any legal requirements based on data governance, sovereignty, or privacy laws.
- Latency – Close proximity to customers means better performance.
- Service availability – Not all AWS services are available in all Regions.
- Cost – Different Regions have different costs. Research the pricing for the services you plan to use and compare costs to make the best decision for your workloads.


## AWS Local Zones
You can use AWS Local Zones for highly demanding applications that require single-digit millisecond latency to end users, for example:
• Media and entertainment content creation – Includes live production, video editing, and graphics-intensive virtual workstations for artists in geographic proximity
• Real-time multiplayer gaming – Includes real-time multiplayer game sessions, to maintain a reliable gameplay experience
• Machine learning hosting and training – For high-performance, low latency inferencing • Augmented reality (AR) and virtual reality (VR) – Includes immersive entertainment, data driven insights, and engaging virtual training experiences
Customers can innovate faster because chip designers and verification engineers solve complex, compute-intensive, and latency-sensitive problems using application and desktop streaming services in AWS Local Zones.


## When should you use AWS Local Zones?
You should use AWS Local Zones to deploy AWS compute, storage, database, and other services closer to your end users for low-latency requirements. With AWS Local Zones, you can use the same AWS infrastructure, services, APIs, and tool sets that you are familiar with in the cloud.

## When should you use edge locations?
You should use edge locations for caching the data (content) to provide fast delivery of content for users. Using edge locations allows for a better user experience, providing faster delivery to users at any location.


To read:
 - https://viblo.asia/p/10-nguyen-tac-thiet-ke-bao-mat-khi-phat-trien-phan-mem-theo-owasp-Qbq5QQJR5D8


 Steps:
    - VPCs first, choose the AZs