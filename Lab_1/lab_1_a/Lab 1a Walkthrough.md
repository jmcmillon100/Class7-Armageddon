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
    **Rule 1**
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
        * **Source:** Custom - select the security group you are creating (lab-ec2-sg)
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
	* **VPC Security Group:** Select the security group you created earlier named  `lab-rds-sg`.