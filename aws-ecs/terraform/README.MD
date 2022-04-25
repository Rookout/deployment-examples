## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using Terraform
Compatible with Terraform version: `>= v0.13`

This terraform module is to be used to deploy the Rookout Controller and Rookout Datastore on AWS ECS Fargate cluster.

![alt text](https://github.com/gchuev-opsfleet/deployment-examples/blob/OP-3-create-ecs-deployment-method-datastore-controller/aws-ecs/cloudformation/Rookout-aws-ecs.png?raw=true)

### Prerequisites

1. Install terrraform. [RefDoc](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. AWS Account and Installed aws cli and default profile set with access key and secret. [Install AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html),[SetupCredentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
3. Created Secret in Secrets Manager with Rookout token. 
   * To complete secret's manager creation folow either of those options:
      * aws cli - Change <rookout_token> placeholder with your token and run `aws secretsmanager create-secret --name rookout_token --description "Rookout token" --secret-string "<rookout_token>"`
      * aws console - follow this [tutorial](https://docs.aws.amazon.com/secretsmanager/latest/userguide/tutorials_basic.html) 
   * Use secret's ARN of token for `rookout_token_arn` variable in `terraform.tfvars`. (See Module Inputs)
4. (Optional) Create S3 bucket for cretificates and upload key and crt files if you want to use native TLS mode for datastore.
   1. create bucket - [RefDoc](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html)
   2. Use bucket name for `(controller||datastore)_settings.certificate_bucket_name` variable in `terraform.tfvars` if you want to enable native TLS for services. (See Module Inputs)
   3. Upload files to s3 [RefDoc](https://docs.aws.amazon.com/AmazonS3/latest/userguide/upload-objects.html)
      * For datastore files should be named as key.pem and cert.pem
      * For controller files should be named as tls.key and tls.crt
      * For each service create a folder inside of this bucket, like `datastore-certs controller-certs` and put these values to respective variable `(controller||datastore)_settings.certificate_bucket_prefix` in `terraform.tfvars` 
5. (Optional) Issue or upload certificate in to AWS ACM if you want to use secured ALB.
   *  Example how to create selfigned cert and upload to ACM:
      1. `openssl genrsa 2048 > mycert.key`
      2. `openssl req -new -x509 -nodes -sha1 -days 3650 -extensions v3_ca -key mycert.key > mycert.crt`
      3. `openssl pkcs12 -inkey mycert.key -in mycert.crt -export -out mycert.p12`
      4. `aws acm import-certificate --certificate file://mycert.crt --private-key file://mycert.key`
   * RefDoc AWS ACM Import https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html
   * RefDoc AWS ACM issue new cert https://docs.aws.amazon.com/acm/latest/userguide/gs.html
   * Use Certificate's ARN for `(controller||datastore)_settings.certificate_arn` variable in `terraform.tfvars` if you want to use this certificate for alb. (See Module Inputs)
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
| create_lb | Set true if you want to create LoadBalancer for chosen deployment. | false |
| existing_lb_arn | Set ALB ARN if you want to use existing Application Load Balancer for chosen deployment. Should be in same VPC as the deployment. | null |
| environment | Deployment environment (dev|prod|stage). Will be set as tag to every resource and will be used in name_prefix variable to prefix resource namings | "dev" |
| service | Will be set as tag `Service:value` to every resource and will be used in name_prefix variable to prefix resource namings | "rookout" |
| controller_settings | Map of Settings for controller service (See description below)| enabled = true <br> service_name = "rookout-controller" <br>  server_mode = "PLAIN" <br> onprem_enabled = true <br> dop_no_ssl_verify = true <br> certificate_bucket_prefix = null <br> certificate_bucket_name = null <br> certificate_arn = null <br> publish_lb = false <br> task_cpu = 512 <br> task_memory = 1024 |
| datastore_settings | Map of Settings for datastore service (See description below)| enabled = true <br> service_name = "rookout-datastore" <br>  server_mode = "PLAIN" <br> cors_all = true <br> in_memory_db = true <br> certificate_bucket_prefix = null <br> certificate_bucket_name = null <br> certificate_arn = null <br> publish_lb = false <br> task_cpu = 512 <br> task_memory = 1024 |

### Controller & Datastore Settings
| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| enabled | Enable or disable service for deploy | true |
| server_mode | if set to TLS certificate_bucket_name\prefix indicate s3 bucket where to look for certificates to download in the task | PLAIN |
| certificate_bucket_name | s3 bucket where certificates should be uploaded. Used when server_mode set to TLS. (See prerequisites) | null |
| certificate_bucket_prefix | s3 bucket prefix where certificates should be uploaded. Used when server_mode set to TLS and certificate_bucket_name is not null. (See prerequisites) | null |
| certificate_arn | if create_lb variable is set to true this certificate arn will be used for service alb listeners (See prerequisites) | null |
| task_cpu / task_memory| CPU and RAM for container | 512/1024 |
| container_cpu / container_memory| CPU and RAM for container | 256/512 |

### Controller Settings
| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| dop_no_ssl_verify | sets DOP_NO_SSL_VERIFY env variable | true |
| onprem_enabled | sets ONPREM_ENABLED env variable | true |


### Datastore Settings
| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| cors_all | set DOP_CORS_ALL env variable | true |
| in_memory_db | set DOP_IN_MEMORY_DB env variable | true |
| storage_size | Ephemeral storage size for Fargate task, must be set in range of 20-200. Use in case of storing big amounth of data in case of useing `DOP_IN_MEMORY_DB = false` | 20 |

### Outputs

| OutputName  | Description |
| ------------- | ------------- |
| alb_dns_name | FQDN of load_balancer in case UseLB variable set to true. Can be used as CNAME target in case of using external DNS. ![Route53 RefDoc](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-creating.html) |