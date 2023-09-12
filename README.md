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

Please follow the sequence below if you wish to perform the hands-on learning with Terraform 101 on Huawei Cloud.

```mermaid
flowchart LR
    00_Fundamental_Knowledge[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/00_Fundamental_Knowledge.md'>00_Fundamental_Knowledge</a>]

    00_Fundamental_Knowledge --> 01_Getting_Started[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/01_Getting_Started.md'>01_Getting_Started</a>]

    01_Getting_Started --> 02_Solution_Overview[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/02_Solution_Overview.md'>02_Solution_Overview</a>]

    02_Solution_Overview --> 03_Terraform_Exercise_VPC[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/03_Terraform_Exercise_VPC.md'>03_Terraform_Exercise_VPC</a>]

    03_Terraform_Exercise_VPC --> 04_Terraform_Exercise_VPC_Peering[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/04_Terraform_Exercise_VPC_Peering.md'>04_Terraform_Exercise_VPC_Peering</a>]

    04_Terraform_Exercise_VPC_Peering --> 05_Result_Validation[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/05_Result_Validation.md'>05_Result_Validation</a>]

    05_Result_Validation --> 06_Resource_Cleaning[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/06_Resource_Cleaning.md'>06_Resource_Cleaning</a>]

    06_Resource_Cleaning --> 07_Terraform_Challenge[<a href='https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop/blob/master/workshop/07_Terraform_Challenge.md'>07_Terraform_Challenge</a>]
```