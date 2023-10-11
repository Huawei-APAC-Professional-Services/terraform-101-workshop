# Resource Cleaning

If your are no longer require the resources, you are advised to delete or destroy all the resources to avoid any additional charging fees.

### Destroy the Huawei Cloud resources using Terraform commands

1. Under the ```/hwcloud-terraform/resource-provisioning-playbook/``` directory inside ECS, execute the command below to destroy the cloud resources. Be caution when running this command as it will delete all the resources according to your current Terraform configuration scripts and update the Terraform state file. <br>

    ```$ terraform destroy -auto-approve```

    (**Notes**: If your intention is to modify the infrastructure configurations only, use ```terraform apply``` command instead as Terraform will compare your execution plan with the latest state of your infrastructure and apply changes accordingly.)

2. Once the command had been executed successfully, navigate to the management console and validate all the resources had been destroyed as expected.