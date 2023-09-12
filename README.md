# Empowering Your Infrastructure with Terraform 101

### Introduction

In this comprehensive guide, we will explore the world of [Terraform on Huawei Cloud](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs), a powerful **Infrastructure as Code (IaC)** tool that enables you to manage and provision your infrastructure efficiently. Whether you are a seasoned developer, a system administrator, or someone new to the world of infrastructure automation, this manual is designed to equip you with the knowledge and skills to harness the full potential of Terraform on Huawei Cloud. 

Throughout this lab manual, we will take you on a journey from the very basics of Terraform to more advanced concepts. We will delve into practical hands-on exercises, together with the sharing of common best practices walking you through the setup of Terraform environment and demonstrating how to create, modify, and destroy infrastructure resources on Huawei Cloud. In addition, you will learn about Terraforms modules, a powerful mechanism for encapsulating reusable configurations. We’ll show you how to leverage modules effectively to promote code reusability, maintainability, and scalability in your infrastructure projects.

By the end of this lab manual, you will have a strong foundation in Terraform, and you’ll be able to confidently apply these skills to empower your infrastructure and streamline your provisioning workflows.

### Learning Outcomes

By the end of the lab, we are able to achieve as below:

* Write Terraform configuration files to define and provision infrastructure resources, such as Elastic Cloud Servers, networks, storage, NAT gateways, and load balancers
* Demonstrate proficiency in using Terraform modules to encapsulate and share reusable infrastructure configurations
* Employ Terraform’s plan and apply workflows to preview and execute infrastructure changes safely and efficiently

### Target Audience

This lab has been designed specifically for the engineers and operators who work under Huawei Cloud resources. Anyone interested in Terraform on Huawei Cloud is welcome.

### Duration

On average, completing all the exercises in this lab will take around 2 hours.

### Pre-requisites

Before going through the exercise in this lab, you should have some familiarity on below:

* Basic understanding of Huawei Cloud resources such as computing, storage, and network
* Basic understanding of Terraform command line
* Basic understanding of Terraform modules

Before going through the exercise in this lab, you should have the below tools and resources:

* [Huawei Cloud Account](https://auth.huaweicloud.com/authui/login.html?service=https://console-intl.huaweicloud.com/console/#/login) with FullAccess permission <br> (**Notes:** The Huawei Cloud account will be provided to you if you attend the workshop physically that organized by Huawei Cloud Professional Service Team)
* [Visual Studio Code Editor (Optional)](https://code.visualstudio.com/download)
* [Git](https://git-scm.com/downloads)
* [WinSCP (Optional)](https://winscp.net/eng/download.php)

### Terraform 101 Workshop

```mermaid
flowchart LR
    Account[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/01_Account_Management.md'>Account Management</a>]
    style Account fill:#33FF36,stroke:#333,stroke-width:1px
    Account --> AccountInitialization[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/02_Account_Initialization.md'>Account Initialization</a>]
    style AccountInitialization fill:#33FF36,stroke:#333,stroke-width:1px
    AccountInitialization --> LocalEnvironmentSetup[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/03_Local_Env_Setup.md'>Local Environment Setup</a>]
    style LocalEnvironmentSetup fill:#3633FF,stroke:#333,stroke-width:1px
    LocalEnvironmentSetup --> HFA_IAM_Configuration[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/04_HFA_IAM_Configuration.md'>HFA IAM Configuration</a>]
    style HFA_IAM_Configuration fill:#33FF36,stroke:#333,stroke-width:1px
    HFA_IAM_Configuration --> HFA_Base_Configuration[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/05_HFA_Base_Configuration.md'>HFA Base Configuration</a>]
    style HFA_Base_Configuration fill:#33FF36,stroke:#333,stroke-width:1px
     HFA_IAM_Configuration --> HFA_Network_Configuration[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/06_HFA_Network_Configuration.md'>HFA Network Configuration</a>]
    style HFA_Network_Configuration fill:#33FF36,stroke:#333,stroke-width:1px
    HFA_Network_Configuration --> HFA_Application_Deployment[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/07_HFA_Application_Deployment.md'>HFA Application Deployment</a>]
    HFA_Base_Configuration --> HFA_Application_Deployment
    style HFA_Application_Deployment fill:#33FF36,stroke:#333,stroke-width:1px
    HFA_Application_Deployment --> HFA_Integration[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/08_HFA_Integration.md'>HFA Integration</a>]
    style HFA_Integration fill:#33FF36,stroke:#333,stroke-width:1px
    HFA_Integration --> HFA_Challenge[<a href='https://github.com/Huawei-APAC-Professional-Services/hfa-workshop/blob/main/workshop/content/09_HFA_Challenge.md'>HFA Challenge</a>]
    style HFA_Challenge fill:#33FF36,stroke:#333,stroke-width:1px
```