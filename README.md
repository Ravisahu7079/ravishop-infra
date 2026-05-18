# ravishop-infra

# 🏗️ RaviShop Infrastructure

  ![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
  ![Ansible](https://img.shields.io/badge/Ansible-Config-red)
  ![AWS](https://img.shields.io/badge/AWS-Cloud-orange)


## 📌 Overview

Infrastructure as Code for RaviShop using Terraform and Ansible.

## 📁 Structure

    ravishop-infra/
     |———————modules/
     |   |—————vpc/    → VPC, Subnets, IGW, Route Tables
     |   |—————ec2/    → EC2 Instance, AMI, User Data
     |   |—————rds/    → RDS MySQL, Subnet Group
     |   |_____sg/     → Security Groups
     |
     |—————ansible/
     |   |—————roles/
     |   |   |—————docker/ → Docker installation
     |   |   |_____app/    → App deployment
     |   |—————playbook.yml
     |   |_____inventory.ini
     |
     |——————main.tf
     |——————variables.tf
     |——————outputs.tf
     |——————providers.tf
     |——————backend.tf

## ☁️ AWS Resources

    | Resource | Type | Purpose |
    |---|---|---|
    | VPC | 10.0.0.0/16 | Network isolation |
    | Public Subnet | 10.0.1.0/24 | EC2 instance |
    | Private Subnet | 10.0.2.0/24 | RDS database |
    | EC2 | t3.micro | App server |
    | RDS | db.t3.micro | MySQL database |
    | S3 | - | Terraform state |
    | IAM | Role + Profile | EC2 permissions |

## 🚀 Deploy Infrastructure

```bash
    cd ravishop-infra
    terraform init
    terraform plan -var="db_password=YOUR_PASSWORD"
    terraform apply -var="db_password=YOUR_PASSWORD"
```
⚙️ Configure Server ( Ansible )

```bash
    cd ansible
    ansible-playbook playbook.yml -i inventory.ini
```
🗑️ Destroy Infrastructure

```bash
    terraform destroy -var="db_password=YOUR_PASSWORD"
```
🧑‍💻 Author

    Ravi Sahu —— @Ravisahu7079
