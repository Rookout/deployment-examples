## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using Terraform
Compatible with Terraform version: `~> v0.13`

### Steps
1. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/aws-ecs`
1. Configure required environment variables to be used in the Terraform
    1. `export TF_VAR_rookout_token=<your Rookout organization token>`
    2. `export TF_VAR_vpc_id=<VPC_ID>` - ID of an existing VPC in which the deployment should happen
    3. `export TF_VAR_subnet<SUBNET_ID>` - ID of an existing subnet that has access to the internet (outbound + inbound)
2. run `terraform init`
2. run `terraform apply`
