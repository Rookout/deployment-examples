## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using Terraform
Compatible with Terraform version: `>= v0.13`

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
| create_lb | Set true if you want to use LoadBalancer for chosen deployment. | false |
| environment | Deployment environment (dev|prod|stage)| "dev" |
| controller_settings | Map of Settings for controller service (See description below)| enabled = true <br> service_name = "rookout-controller" <br>  server_mode = "PLAIN" <br> onprem_enabled = true <br> dop_no_ssl_verify = true <br> certificate_bucket_prefix = null <br> certificate_bucket_name = null <br> certificate_arn = null <br> publish_lb = false <br> task_cpu = 512 <br> task_memory = 1024 |
| datastore_settings | Map of Settings for datastore service (See description below)| enabled = true <br> service_name = "rookout-datastore" <br>  server_mode = "PLAIN" <br> cors_all = true <br> in_memory_db = true <br> certificate_bucket_prefix = null <br> certificate_bucket_name = null <br> certificate_arn = null <br> publish_lb = false <br> task_cpu = 512 <br> task_memory = 1024 |

#### Controller & Datastore settings
| ParameterName  | Description |
| ------------- | ------------- |
| enabled | Enable or disable service for deploy |
| server_mode | if set to TLS certificate_bucket_name\prefix indicate s3 bucket where to look for certificates to download in the task |
| certificate_bucket_name | s3 bucket where certificates should be uploaded |
| certificate_bucket_prefix | s3 bucket prefix where certificates should be uploaded |
| certificate_arn | if create_lb variable is set to true this certificate arn will be used for service alb listeners |
| task_cpu / task_memory| CPU and RAM for tasks |
