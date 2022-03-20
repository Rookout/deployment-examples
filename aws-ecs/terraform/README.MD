## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using Terraform
Compatible with Terraform version: `~> v1.0`

This terraform module is to be used to deploy the Rookout Controller and Rookout Datastore on AWS ECS Fargate cluster.

![alt text](https://github.com/gchuev-opsfleet/deployment-examples/blob/OP-3-create-ecs-deployment-method-datastore-controller/aws-ecs/cloudformation/Rookout-aws-ecs.png?raw=true)

### Prerequisites

* AWS Account and Installed aws cli and default profile set with access key and secret. https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
* Created Secret in Secrets Manager with Rookout token. 
   * Change <rookout_token> placeholder with your token and run `aws secretsmanager create-secret --name rookout_token --description "Rookout token" --secret-string "<rookout_token>"`
   * Note secret ARN.
* (Optional) Create S3 bucket for cretificates and upload key and crt files if you want to use native TLS mode for datastore.
* (Optional) Issue or upload certificate in to AWS ACM if you want to use secured ALB.
   *  Example how to create selfigned cert and upload to ACM:
      1. `openssl genrsa 2048 > mycert.key`
      2. `openssl req -new -x509 -nodes -sha1 -days 3650 -extensions v3_ca -key mycert.key > mycert.crt`
      3. `openssl pkcs12 -inkey mycert.key -in mycert.crt -export -out mycert.p12`
      4. `aws acm import-certificate --certificate file://mycert.crt --private-key file://mycert.key`
      5. Note certificate ARN.
   * RefDoc AWS ACM Import https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html
   * RefDoc AWS ACM issue new cert https://docs.aws.amazon.com/acm/latest/userguide/gs.html
### Example Usage
#### Deploy ALB VPC Example
1. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/aws-ecs/terraform/examples/alb-vpc`
2. Configure required variables to be used in the Terraform in `terraform.tfvars`
3. run `terraform init`
4. run `terraform apply`

### Module Inputs

| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| rookout_token_arn | Secret's ARN for AWS Secrets Manager secret with rookout token.(See prerequisites) | none |
| prviate_namespace_name  | Name for AWS CloudMap namespace used for service discovery  | cluster.local |
| default_vpc  | Set true if you want to use default VPC or VPC without private networks.  | false |
| public_subnets | List of public subnets for LoadBalancer and for ECS tasks in case of default vpc deployment.| none |
| private_subnets |  Select list of private subnets for ECS tasks. They should be in same VPC and has routes between public_subnets if you're using LB. Ignored when you set DefaultVPC to true | none |
| vpc_id | VPC ID where resources will be deployed. | none |
| cluster_name | Set true if you want to use previously deployed cluster, if not set module will create new AWS ECS cluster as part of deployment. | null |
| publish_controller_lb | Set true if you want to publish controller trough LoadBalancer. create_lb parameter should be set to true. | false |
| create_lb | Set true if you want to use LoadBalancer for chosen deployment. | false |
| certificate_arn | ACM Certificate Arn for TLS deployment with LoadBalancer. (See prerequestes on how to Issue or Import Certificate)| "" |
| certificate_bucket_name | AWS S3 bucket name where certificates will be located. Automatically set datastore ROOKOUT_DOP_SERVER_MODE variable to TLS | null |
| certificate_bucket_prefix | S3 bucket prefix (path in the bucket) where certificate files will be stored and downloaded by container task to datastore contaner volume. Can be optionally set along with certificate_bucket_name | null |
| environment | Deployment environment (dev|prod|stage)| "dev" |