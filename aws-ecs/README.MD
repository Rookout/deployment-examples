## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using Terraform
Compatible with Terraform version: `~> v0.13`

This terraform deployment is to be used to deploy the Rookout Controller and Rookout Datastore on your AWS ECS Fargate cluster.

**note:** the datastore will be deployed in `PLAIN` mode, meaning it won't deal with certificates itself but rather rely on being behind an LB with SSL termination.

`TLS` mode is also available, contact us for more info.
### Steps
1. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/aws-ecs`
2. Configure required environment variables to be used in the Terraform
    1. `export TF_VAR_rookout_token=<your Rookout organization token>`
    2. `export TF_VAR_region=<REGION_CODE>` - AWS Region code to deploy in (e.g us-east-1)
    3. `export TF_VAR_cluster_name=<CLUSTER_NAME>` - Cluster name of the cluster to deploy in
    4. `export TF_VAR_vpc_id=<VPC_ID>` - ID of an existing VPC to use to expose the Rookout components to the interent
    5. `export TF_VAR_subnet<SUBNET_ID>` - ID of an existing subnet that has access to the internet (outbound + inbound)
    6. `export TF_VAR_name_prefix=<NAME_PREFIX>` - Name prefix to use for all created resources (Optional, defaults to 'dev')
3. run `terraform init`
4. run `terraform apply`
