# Twoge Two-Tier Deployment
Want to Know How to Build It? Check Here: [Coming Soon]

[Twoge](https://github.com/chandradeoarya/twoge/tree/master) Deployed on Ubuntu EC2 Server + RDS PosgreSQL using IaC (Terraform/Ansible)

## Table of Contents

- [About](#about)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Usage](#usage)

## About

This is a Two-Tier Deployment configured and initialized using Terraform/Ansible (IaC) with Github Actions deploying a CICD (Continuous Integration/Continuous Deployment) Pipeline for the dev branch of the repo.

Terraform Provides:

- Custom VPC + Security Groups
- Ubuntu EC2
- PostgreSQL RDS

Ansible Provides:

- Ubuntu EC2 Server Configurations

## Prerequisites

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Boto3](https://pypi.org/project/boto3/)
- [Botocore](https://pypi.org/project/botocore/)


## Getting Started

### Initialization
From Terraform/Ansible Controller

```bash
#Initialize Terraform
terraform init

#Plan Terraform Deployment
terraform plan

#Apply Terraform Deplyment
terraform apply

#Save Terraform Outputs
terraform output -json > terraform_outputs.json

#Generate NGINX Config
python /twoge/gen_nginx.conf.py > /ansible/twoge-ansible-server/files/twoge.conf


#Run Ansible Playbook
ansible-playbook -i server_aws_ec2.yml server_role.yml
```

### CICD

```bash
#Change to the resume-twoge-cicd repo
cd to resume-twoge-cicd

#Add changes
git add .

#Switch to dev branch
git checkout dev

#Commit changes
git commit -m "These are my changes"

#Push Changes
git push origin dev
```

On push to dev branch, the twoge/ directory changes should be updated on the initialized AWS EC2 Server.

