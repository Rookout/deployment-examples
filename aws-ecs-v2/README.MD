## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using Terraform
Compatible with Terraform version: `~> v0.13`

This terraform deployment is to be used to deploy the Rookout Controller and Rookout Datastore on your AWS ECS Fargate cluster.

note: the datastore will be deployed in `PLAIN` mode, meaning it won't deal with certificates itself but rather rely on being behind an LB with SSL termination.
`TLS` mode is also availble, contact us for more info.
### Steps
1. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/aws-ecs`
1. Configure required environment variables to be used in the Terraform
    1. `export TF_VAR_rookout_token=<your Rookout organization token>`
    1. `export TF_VAR_cluster_name=<CLUSTER_NAME>` - Cluster name of the cluster to deploy in
    2. `export TF_VAR_vpc_id=<VPC_ID>` - ID of an existing VPC to use to expose the Rookout components to the interent
    3. `export TF_VAR_subnet<SUBNET_ID>` - ID of an existing subnet that has access to the internet (outbound + inbound)
2. run `terraform init`
2. run `terraform apply`
