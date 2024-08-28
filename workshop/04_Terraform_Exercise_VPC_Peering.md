# Building Your Infrastructure from Code with Terraform Scripting

At this stage, you have completed the basic resources provisioning including VPCs, subnets, Nat Gateway and ELB resources. To enable communication between the VPCs to facilitate the ingress and egress traffic of production workloads, you need to **configure the VPC peering in between the VPCs** to enable such communication. This time, you will need to learn how to create the reusable scripts under the ```hwcloud-terraform/terraform-hwcloud-modules/``` directory before you can configure the module block for VPC peering. You are advised to always refer to the [Terraform registry](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_peering_connection) website in order to obtain the arguments needed for configuration scripts.

### Configure Reusable Terraform Configuration Scripts for VPC Peering

1. Under the ```hwcloud-terraform/terraform-hwcloud-modules/terraform-hwcloud-vpc-peering/versions.tf``` configuration file, configure the provider to be used in the resource provisioning. Modify the terraform provider ```version``` within the ```terraform block``` to the latest version, you may refer to this [Huawei Cloud Terraform](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs) website for the latest version of the provider to be used. <br>

    ```
    terraform {
      required_providers {
        huaweicloud = {
          source  = "huaweicloud/huaweicloud"
          version = "~> 1.67.0"
        }
      }
    }
    ```

2.	Under the same directory, open the ```main.tf``` file and configure the ```resource block``` to define the arguments require to establish the VPC Peering connection in between VPCs.

    a. Within the ```main.tf``` file, create a resource block for the VPC Peering connection by using ```huaweicloud_vpc_peering_connection``` module provided in [Terraform Registry](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_peering_connection). Example scripts is as below, the required arguments is the ```name``` of peering connection, ```vpc_id```, and the peering VPC ```peer_vpc_id```.

    ```
    resource "huaweicloud_vpc_peering_connection" "requester" {
      name           = "${var.requester_vpc_name}_peering_${var.accepter_vpc_name}"
      vpc_id         = var.requester_vpc_id
      peer_vpc_id    = var.accepter_vpc_id
    }
    ```

    b. Once we have the VPC Peering connection resource block configured, we need to **add the routes** to the VPC route table and the peered VPC route table before both VPCs can communicate to each other. Within the same ```main.tf``` file, create another two resource blocks with the use of ```huaweicloud_vpc_route``` module provided in this [Terraform Registry](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_route). The required arguments is ```vpc_id```, ```destination```, ```type```, and ```nexthop```. The **requester route** indicates the route added to the local VPC and the **accepter route** indicates the route added to the peered VPC.

    ```
    resource "huaweicloud_vpc_route" "requester_route" {
      vpc_id      = var.requester_vpc_id
      destination = var.accepter_vpc_cidr
      type        = "peering"
      nexthop     = huaweicloud_vpc_peering_connection.requester.id
    }
    resource "huaweicloud_vpc_route" "accepter_route" {
      vpc_id      = var.accepter_vpc_id
      destination = var.requester_vpc_cidr
      type        = "peering"
      nexthop     = huaweicloud_vpc_peering_connection.requester.id
    }
    ```

3.	Under the same directory, open the ```variables.tf``` file and configure the ```variable block``` to define the variables used within the resource block in **main.tf** file.

    a. Within the ```variables.tf``` file, create multiple variable blocks for the variables used within the resource blocks in the previous steps. Example scripts for **VPC Peering connection variables** is as below.

    ```
    variable "requester_vpc_name" {
      description = "Requester vpc name"
      type        = string
      default     = ""
    }

    variable "requester_vpc_id" {
      description = "Requester vpc id"
      type        = string
      default     = ""
    }

    variable "requester_vpc_cidr" {
      description = "The CIDR block for the Requester VPC."
      type        = string
      default     = "0.0.0.0/0"
    }

    variable "accepter_vpc_name" {
      description = "Accepter vpc name"
      type        = string
      default     = ""
    }

    variable "accepter_vpc_id" {
      description = "Accepter vpc id"
      type        = string
      default     = ""
    }

    variable "accepter_vpc_cidr" {
      description = "The CIDR block for the Accepter VPC."
      type        = string
      default     = "0.0.0.0/0"
    }
    ```

4.	Under the same directory, open the ```outputs.tf``` file and configure the ```output block``` to display and store the created resource ID in terraform state file.

    a. Within the ```outputs.tf``` file, create an output block for the output variable used within the resource blocks in the previous steps. Example scripts for **VPC Peering connection output variables** is as below, this output variable will display the **VPC Peering connection ID for the local VPC or the requester VPC**.

    ```
    output "requester_vpc_peering_id" {
      value       = huaweicloud_vpc_peering_connection.requester.id
      description = "Requester VPC Peering ID"
    }
    ```

### Configure Module Block for VPC Peering connection

At this stage, you have completed the reusable configuration scripts for VPC Peering resources. Next, by referring to the configurations scripts that you have created in the previous step, create multiple module blocks to establish the VPC Peering connection for the below scenarios:

  * **VPC Peering in between vpc-production and vpc-ingress**
  * **VPC Peering in between vpc-production and vpc-egress**

1. Under the ```hwcloud-terraform/resource-provisioning-playbook/``` directory, create a new terraform file and named it as ```vpc_peering.tf```. Configure the module blocks to create two VPC Peering connections to achieve above scenarios. 

    a. Within the ```vpc_peering.tf``` file, configure the module block and specifying the **source path** to obtain the reusable configuration scripts.The example scripts to configure the VPC peering in between **vpc-prod** and **vpc-ingress** is as below. <br>
    (**Notes**: Modify the source path accordingly if you have different project directory, you may modify the module name based on your preferences.)

    ```
    module "prod_vpc_2_transit_ingress_vpc" {
      source = "../terraform-hwcloud-modules/terraform-hwcloud-vpc-peering"
    }
    ```

    b. Next is to insert the input variables from the reusable configuration scripts that requires to create the VPC Peering connections. You may obtain the input variables from ```hwcloud-terraform/terraform-hwcloud-modules/terraform-hwcloud-vpc-peering/variables.tf``` configuration file such as ```requester_vpc_name```, ```requester_vpc_id```, ```requester_vpc_cidr```, ```accepter_vpc_name```, ```accepter_vpc_id```, and ```accepter_vpc_cidr``` to be inserted within the module block.

    ```
    module "prod_vpc_2_transit_ingress_vpc" {
      source = "../terraform-hwcloud-modules/terraform-hwcloud-vpc-peering"
      requester_vpc_name =
      requester_vpc_id =
      requester_vpc_cidr =

      accepter_vpc_name =
      accepter_vpc_id =
      accepter_vpc_cidr =
    }
    ```

    c. The values for each input variable is used to describe the resource behaviors. To ease the changes of resource behaviors in the future, you should define the values using the variable block instead. The example variable value definition for VPC Peering connection is as below.

    ```
    module "prod_vpc_2_transit_ingress_vpc" {
      source = "../terraform-hwcloud-modules/terraform-hwcloud-vpc-peering"
      requester_vpc_name = var.prod_vpc
      requester_vpc_id = module.prod-vpc.vpc_id
      requester_vpc_cidr = var.prod_vpc_cidr

      accepter_vpc_name = var.transit_ingress_vpc
      accepter_vpc_id = module.transit-vpc-ingress.vpc_id
      accepter_vpc_cidr = var.transit_ingress_vpc_cidr
    }
    ```

    d. Navigate to the ```hwcloud-terraform/resource-provisioning-playbook/outputs.tf``` file created in previous section, configure another output block to display and store the created VPC Peering resource ID in terraform state file. Example scripts is as below, you may modify the output variable name accordingly.

    ```
    output "prod2ingress_requester_vpc_peering_id" { value = } 
    ```

    e. The **output variable values** should obtain from the reusable configuration scripts under ```hwcloud-terraform/terraform-hwcloud-modules/terraform-hwcloud-vpc-peering/outputs.tf``` file. For example the ```requester_vpc_peering_id```, and the format is as below.

    **output "output-variable-name" { value = module.module-name.output-variable-name-from-reusable-configuration-scripts}**

    ```
    output "prod2ingress_requester_vpc_peering_id" { value = module.prod_vpc_2_transit_ingress_vpc.requester_vpc_peering_id}
    ```

2. Within the same ```vpc_peering.tf```, configure another module block to create a VPC Peering connection to enable the communication in between **production VPC** and **egress VPC**. Follow the guides in **Step 1** and you should able to achieve the similar configurations as below.

    a. module block for VPC Peering connection

    ```
    module "prod_vpc_2_transit_egress_vpc" {
      source = "../terraform-hwcloud-modules/terraform-hwcloud-vpc-peering"
      requester_vpc_name = var.prod_vpc
      requester_vpc_id = module.prod-vpc.vpc_id
      requester_vpc_cidr = var.prod_vpc_cidr

      accepter_vpc_name = var.transit_egress_vpc
      accepter_vpc_id = module.transit-vpc-egress.vpc_id
      accepter_vpc_cidr = var.transit_egress_vpc_cidr
    }
    ```

    b. output block to display and store the created resource ID in terraform state file

    ```
    output "prod2egress_requester_vpc_peering_id" { value = module.prod_vpc_2_transit_egress_vpc.requester_vpc_peering_id}
    ```

### Execute the Terraform commands for network resource creations

At this stage, you have completed the configuration scripts for the VPC Peering connections. Now you are required to execute the terraform command for resource provisioning, select the appropriate method below to execute the task.

#### Method 1 ####
This method is applicable if you are using Huawei ECS to write and modify the Terraform scripts. Follow the instruction below to create peering resources.

1. Under the ```hwcloud-terraform/resource-provisioning-playbook/``` directory, run the below commands to **format** the terraform configuration files to ensure a consistent format within codebase and **initialize the modules** being used for resource provisioning. <br>

    ```cd hwcloud-terraform/resource-provisioning-playbook/``` <br>
    ```terraform fmt```<br>
    ```terraform init```

2. Once sucessfully initialize the configuration scripts, execute the below commands to **validate** the configuration scripts and output the configuration plan that are going to apply to the Huawei Cloud environment. **This command will only review the plan without making any changes to your environment**. <br>

    ```terraform validate```<br>
    ```terraform plan```

3. Once review the plan, execute the commands below to **apply changes** to your environment. <br>

    ```terraform apply -auto-approve```

4. Repeat **Step 1** only if you have added any new module blocks. Repeat **Step 2** and **Step 3** if you have modified the scripts for troubleshooting purpose.

#### Method 2 ####
This method is applicable if you are using your local machine to write and modify the Terraform scripts. Follow the instructions below to upload the source code to the ECS and provision the peering resources on Huawei Cloud environment. 

1. Upload the source code to the ECS on Huawei Cloud environment.

    a. **Using Command Line (CLI)**, enter the ECS credentials as prompted, the default value is **candidate@2024**.
    * **Linux** <br>
      ```
      $ scp /path-to-project-directory/hwcloud-terraform/resource-provisioning-playbook/vpc-peering.tf root@public-ip-address-of-the-ecs:~/hwcloud-terraform/resource-provisioning-playbook/
      ```

    * **Windows** <br>
      ```
      $ scp \path-to-project-directory\hwcloud-terraform\resource-provisioning-playbook\vpc-peering.tf root@public-ip-address-of-the-ecs:~/hwcloud-terraform/resource-provisioning-playbook/
      ```

    b. **Using WinSCP Tool**: Locate your files on your local machine, and manually copy and paste the files to the remote host.

2. Login to the ECS with Terraform installed, navigate to the ```hwcloud-terraform/resource-provisioning-playbook/``` directory and run the below commands to **format** the terraform configuration files to ensure a consistent format within codebase and **initialize the modules** being used for resource provisioning. <br>

    ```cd hwcloud-terraform/resource-provisioning-playbook/``` <br>
    ```terraform fmt```<br>
    ```terraform init```

3. Once sucessfully initialize the configuration scripts, execute the below commands to **validate** the configuration scripts and output the configuration plan that are going to apply to the Huawei Cloud environment. **This command will only review the plan without making any changes to your environment**. <br>

    ```terraform validate```<br>
    ```terraform plan```

4. Once review the plan, execute the commands below to **apply changes** to your environment. <br>

    ```terraform apply -auto-approve```

5. Repeat **Step 1** only if you have added any new module blocks. Repeat **Step 2** and **Step 3** if you have modified the scripts for troubleshooting purpose.