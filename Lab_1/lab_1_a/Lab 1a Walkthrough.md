# Lab 1 walkthrough

## 1.Create a VPC

* **VPC Dashboard > Create VPC** (Select "VPC and more").
*   **Custom VPC:** "10.0.0.0/16".
*   **Avalibilty Zones (AZs):** minimum of 2.
*   **NAT Gateway:** none.
*   **VPC Endpoints:** none.
*   **DNS Options:** check to ensure that both enable "DNS hostnames and DNS resolutions" are checked.
*   **Create VPC**

## 2. Create Security Groups

* **EC2 Console > Security Groups > Create Security Group**
* **Security Group 1** 
    * **Name:** `lab-ec2-sg`
    * **Description:** Security group for EC2 instances in Lab 1a.
     * **VPC:** Select the VPC you created previously.
    * **Inbound rules:**
**Rule 1**
    * **Type:** HTTP
    * **Protocol:** TCP
    * **Port Range:** 80
    * **Source:** Anywhere-IPv4 
**Rule 2**
    * **Type:** SSH
    * **Protocol:** TCP
    * **Port Range:** 22
    * **Source:** Anywhere-IPv4
    * **Outbound Rules** DO NOT TOUCH!
    --- 
* **Security Group 2**
    * **Name:** `lab-rds-sg`
    * **Description:** Security group for EC2 instances in Lab 1a.
    * **VPC:** Select the VPC you created previously.
    * **Inbound rules:**
**Rule 1**
    * **Type:** MYSQL/Aurora
    * **Protocol:** TCP
    * **Port Range:** 3306
    * **Source:** 0.0.0.0/0
    **Rule 2**
        * **Type:** Custom TCP
        * **Protocol:** TCP
        * **Port Range:** 0
        * **Source:** select the `lab-ec2-sg` security group you created.
        * **Outbound Rules** DO NOT TOUCH!

* **Create security group**

## 3.Create a DB Subnet Group

* **RDS Console > Subnet Groups** > **Create DB Subnet Group**
    * **Name:** `armageddon-subnet-group`
    * **VPC:** Select the VPC you created previously'
    * **Add subnets:** Select at least two subnets previously.
        **select only priavte subnets**
    * **Create**

## 4. Create RDS Database

* RDS Console > **Create database**.
* **Creation method:** Standard Create (Full Configuration).
* **Engine:** MySQL(most up to date version).
* **Template:** Free Tier.
* **Settings:**
	* **DB Instance Identifier:** `lab-mysql1`
	* **Master username:** `admin`
	* **Credentials management:** Self-managed. (Create and **save** your password).
* **Connectivity:**
	* **VPC:** Select the VPC you created.
	* **DB Subnet Group:** Select the group created.
	* **Public access:** No.
	* **VPC Security Group:** Choose existing > Select the security group you created earlier named  `lab-rds-sg`.
    * **Availability Zone:** No preference.
    * **Log exports** select "iam-db-error-log", "instance log" , and "PostgreSQL log"
    * **Create Database**
* Wait for the RDS instance to be available before proceeding to the next step.
## 5. Create IAM Role for EC2 Instance
* **IAM Console > Policies > Create policy**
    * **JSON Tab:** Paste the `secretsmanager:GetSecretValue` JSON you have in your resources.
    * **Name:** `ArmageddonSecretPolicy`.
    * **IAM Console > Roles > Create role**
    * **Select trusted entity:** AWS service >EC2
    * **Permissions:** Add the new policy you just created:
    * **Name:** `ArmageddonSecretPolicy`
    




