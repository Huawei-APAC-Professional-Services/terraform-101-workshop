# Getting Started to Hands-on Learning with Terraform 101

There are different ways in executing the Terraform commands, the most easiest way is to run Terraform on your local machine and store the state file locally. This requires the Huawei Cloud account **access key** and **secret key** with programmatic access permission in order to provision cloud resources. However, the use of access and secret key in Terraform **poses a security risk** if someone accidentally obtain the access to your code development, he or she might potentially misuse these credentials and modify your infrastructure environments.

Thus, to minimize the risk mentioned and avoid the running of Terraform with the use of access and the secret key, you are required to have [a running ECS instance with Agency configured](https://support.huaweicloud.com/intl/en-us/bestpractice-iam/iam_0511.html). With the agency, Terraform will only ask the **metadata API for credentials** where this is a preferred approach over any other when running in ECS as you can avoid hard-coding credentials. Instead, these are leased on-the-fly by Terraform which reduces the chance of leakage.

In this hands-on lab learning, we will provision an [Elastic Cloud Server (ECS)](https://support.huaweicloud.com/intl/en-us/productdesc-ecs/en-us_topic_0013771112.html) on Huawei Cloud for the use of running the Terraform commands.

### Preparing the Terraform Environment

You may follow the instructions below to provision an ECS and configure the agency and Terraform on Huawei Cloud environment.

1. Log in to the [Huawei Cloud](https://auth.huaweicloud.com/authui/login.html?locale=en-us&service=https%3A%2F%2Fwww.huaweicloud.com%2Fintl%2Fen-us%2F#/login) account with the credentials configured or provided by your administrator. Navigate to the Identity and Access Management (IAM) console and select agencies. Insert the information below, you may modify the agency name according to your preferences.

    *<p align="center"> ![figure2.0](./images/2.0.png) </p>*

    *<p align="center"> Figure 2.0: Create a new Agency </p>*

2. Assign a **“FullAccess”** permission to the agency. Click ```submit``` button to complete the agency creation. <br> (**Notes:** “FullAccess” permission granting complete access rights to the ECS on cloud resources. In a real production environment, you should always follow the principle of least privilege by granting the minimum required permission to limit access to critical resources and sensitive operations.)
    
    *<p align="center"> ![figure2.1](./images/2.1.png) </p>*

    *<p align="center"> Figure 2.1: Assign permission to the agency </p>*

3. Readiness of the ECS and Terraform IaC tool. <br>
    **(Notes: If you are attending the workshop hosted by Huawei Team, you may skip this step as the ECS will be provided with Terraform installed. Proceed to the next step for the agency binding)**

    a. Navigate to the ECS console and create an ECS with the following specifications. <br>
    **region**          : Singapore Region <br>
    **operating system**: Ubuntu 22.04 <br>
    **compute flavor**  : s6.large.2 <br>
    **vCPUs**           : 2 <br>
    **memory**          : 4GiB <br>
    **system disk**     : High I/O 40GB <br>
    **eip**             : 50 Mbit/s

    *<p align="center"> ![figure2.2](./images/2.2.png) </p>*

    *<p align="center"> Figure 2.2: Create an ECS in Huawei Cloud </p>*

    b. Once the ECS is up and running, log in to the ECS and install the Terraform with the command below. <br> (**Notes:** If you are using different operating system other than Ubuntu, please follow the guidelines in [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) website instead.)

    ```$ sudo apt update``` <br>
    ```$ sudo apt install software-properties-common gnupg2 curl``` <br>
    ```$ curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg``` <br>
    ```$ sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/``` <br>
    ```$ sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"``` <br>
    ```$ sudo apt install terraform``` <br>
    ```$ terraform --version``` <br>

4. Once the Terraform is successfully installed, navigate to the ECS console and bind the agency created in **Step 1** to the ECS.

    *<p align="center"> ![figure2.3](./images/2.3.png) </p>*

    *<p align="center"> Figure 2.3: Bind agency to ECS </p>*


### Obtain the Terraform source code template

#### Method 1 ####
1. Open the command prompt from the local machine, execute the below command, the public IP address is the EIP address that bound to the ECS created or provided in previous section.

    ```$ ssh root@replace-with-public-ip-address``` <br>

    *<p align="center"> ![figure2.4](./images/2.4.png) </p>*

    *<p align="center"> Figure 2.4: Public IP address of the ECS </p>*

2. Once you have successfully login to the remote ECS, execute the below command to clone the repository.

    ```git clone https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop.git```

    Below describe the usage of the folder directory in the Terraform template that have been cloned. 

    * **hwcloud-terraform**: project directory <br>
    * **resource-provisioning-playbook**: project directory to create module block for resource provisioning <br>
    * **terraform-hwcloud-modules**: directory to store all the reusable configuration scripts for different resources

#### Method 2 ####
1.  From your **local machine**, open [Visual Studio Code](https://code.visualstudio.com/download) Editor, and **clone the repository** by using the below git clone command. The Visual Studio Code Editor will be used to perform any **code modification**.

    ```git clone https://github.com/Huawei-APAC-Professional-Services/terraform-101-workshop.git```

    Below describe the usage of the folder directory in the Terraform template that have been cloned. 

    * **hwcloud-terraform**: project directory <br>
    * **resource-provisioning-playbook**: project directory to create module block for resource provisioning <br>
    * **terraform-hwcloud-modules**: directory to store all the reusable configuration scripts for different resources

2. **To upload the source code to the ECS created/provided** in previous section, there are two ways to do it either using the **Command Line (CLI)** or **WinSCP tool**. You are require to obtain the public IP address of the ECS from the ECS managemenet console as below screenshot.
    (**Notes**: Ensure your ECS instance have the [Security Group](https://support.huaweicloud.com/intl/en-us/usermanual-vpc/en-us_topic_0073379079.html) with open **port number 22**)

    *<p align="center"> ![figure2.4](./images/2.4.png) </p>*

    *<p align="center"> Figure 2.4: Public IP address of the ECS </p>*

    a. Using **Command Line (CLI)**<br>
    
    Try to upload the cloned repository from local machine to the remote ECS by using the ```scp``` command as below. <br>

    1. **Linux** <br>
        ```scp -r /path-to-project-directory/terraform-101-workshop/hwcloud-terraform root@public-ip-address-of-the-ecs:~/``` <br>
        Enter the ECS credentials as prompted, the default value is **Huawei@123**.

    2. **Windows CMD or PowerShell** <br>
        ```scp -r \path-to-project-directory\terraform-101-workshop\hwcloud-terraform root@public-ip-address-of-the-ecs:~/``` <br>
        Enter the ECS credentials as prompted, the default value is **Huawei@123**.

    b. Using [WinSCP](https://winscp.net/eng/download.php) Tool <br>
    
    Try to upload the cloned repository from local machine to the remote ECS by using the [WinSCP](https://winscp.net/eng/download.php) Tool as below. Enter the ECS credentials as prompted, the default value is **Huawei@123**. <br>

    *<p align="center"> ![figure2.5](./images/2.5.png) </p>*

    *<p align="center"> Figure 2.5: Transfer files using WinSCP tool </p>*