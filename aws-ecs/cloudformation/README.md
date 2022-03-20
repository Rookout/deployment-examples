## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using AWS Cloudformation
This CloudFormation deployment is to be used to deploy the Rookout Controller and Rookout Datastore within AWS ECS Fargate cluster.

![alt text](https://github.com/gchuev-opsfleet/deployment-examples/blob/OP-3-create-ecs-deployment-method-datastore-controller/aws-ecs/cloudformation/Rookout-aws-ecs.png?raw=true)

### Prerequisites

* AWS Account and Installed aws cli and default profile set with access key and secret. https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
* Created Secret in Secrets Manager with Rookout token. 
   * Change <rookout_token> placeholder with your token and run `aws secretsmanager create-secret --name rookout_token --description "Rookout token" --secret-string "<rookout_token>"`
   * Note secret ARN.
* Create s3 bucket for Cloudformation templates.
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

### Files

* *templates/*
   * *rookout-aws-ecs.yaml* - CloudFormation template which creates following resources:
      * ECS Cluster
      * ECS TaskDefinitions
      * ECS Services
      * IAM Policy and TaskExecutionRole for ECS
      * SecurityGroups
      * (Optional) Application Load Balancer
         * Listeners and TargetGroups for each service
         * (OPtional) Attach ACM Certificates
   * *vpc.yaml* - basic VPC CloudFormation template which creates following resources:
      * VPC
      * 2x Private subnets
      * 2x Public subnets
      * IGW for Public subnets
      * 2x NAt Gateways with EIP for private subnets
   * *master.yaml* - Master stack which includes rookout and vpc templates together.
* *cf_validate.sh* - shell script for validation templates in ./templates/ folder
* *cf_update_stack.sh* - shell script for creating and updating Cloudformation stacks. See usage below.
* *set_env.sh* - shell script with environment variables for cf_update_stack.sh it sourced from this script, don't need to run separately.
* *master.dev.json* \ *rookout.dev.json* - Parameter files for cloudformation stack. master used when you deploy master stack, rookout if you want to deploy only rookout resources.

### Parameters
**rookout-aws-ecs.yaml**:

| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| TokenSecretArn | Secret's ARN for AWS Secrets Manager secret with rookout token.(See prerequisites) | none |
| PrivateDNSZoneName  | Name for AWS CloudMap namespace used for service discovery  | cluster.local |
| DefaultVPC  | Set true if you want to use default VPC or VPC without private networks.  | false |
| PublicSubnets | List of public subnets for LoadBalancer and for ECS tasks in case of default vpc deployment.| none |
| PrivateSubnets |  Select list of private subnets for ECS tasks. They should be in same VPC and has routes between PublicSubnets if you're using LB. Ignored when you set DefaultVPC to true | "" |
| VpcId | a VPC where subnets located. | none |
| PublishControllerLB | Set true if you want to publish trough LoadBalancer. UseLB parameter should be set to true. | false |
| DOPInMemoryDB | Set true if you want to use InMemory db mode for datastore. ROOKOUT_DOP_IN_MEMORY_DB env variable will be set for datastore service. | true |
| DOPCorsAll | ROOKOUT_DOP_CORS_ALL env variable will be set for datastore service. | true |
| UseLB | Set true if you want to use LoadBalancer for chosen deployment. | false |
| CertificateArn | ACM Certificate Arn for TLS deployment with LoadBalancer. (See prerequestes on how to Issue or Import Certificate)| "" |
| CertificateS3Bucket | S3 bucket name where certificate files will be stored and downloaded by container task to datastore contaner volume. Automatically set datastore ROOKOUT_DOP_SERVER_MODE variable to TLS | "" |
| CertificateS3BucketPrefix | S3 bucket prefix (path in the bucket) where certificate files will be stored and downloaded by container task to datastore contaner volume. Can be optionally set along with CertificateS3Bucket | "" |
| Environment | Deployment environment (dev|prod|stage)| "dev" |



**vpc.yaml**
| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| EnvironmentName | An environment name that will be prefixed to resource names | dummy-vpc |
|VpcCIDR| Please enter the IP range (CIDR notation) for this VPC | 10.10.0.0/16 |
|PublicSubnet1CIDR| Please enter the IP range (CIDR notation) for the public subnet in the first Availability Zone | 10.10.0.0/24 |
|PublicSubnet2CIDR| Please enter the IP range (CIDR notation) for the public subnet in the second Availability Zone | 10.10.1.0/24 |
|PrivateSubnet1CIDR| Please enter the IP range (CIDR notation) for the private subnet in the first Availability Zone | 10.10.3.0/24 |
|PrivateSubnet2CIDR| Please enter the IP range (CIDR notation) for the private subnet in the second Availability Zone | 10.10.4.0/24 |



**master.yaml**

| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| TemplatesS3Bucket | Bucket name where all templates are stored (See prerequisites) | none |
| TokenSecretArn | Secret's ARN for AWS Secrets Manager secret with rookout token.(See prerequisites)| none |
| PrivateDNSZoneName  | Name for AWS CloudMap namespace used for service discovery  | cluster.local |
| PublishControllerLB | Set true if you want to publish trough LoadBalancer. UseLB parameter should be set to true. | false |
| UseLB | Set true if you want to use LoadBalancer for chosen deployment. | false |
| CertificateArn | ACM Certificate Arn for TLS deployment with LoadBalancer. (See prerequestes on how to Issue or Import Certificate)| "" |
| Environment | Deployment environment (dev|prod|stage)| "dev" |
| VpcCIDR| Please enter the IP range (CIDR notation) for this VPC | 10.10.0.0/16 |
| PublicSubnet1CIDR | Please enter the IP range (CIDR notation) for the public subnet in the first Availability Zone | 10.10.0.0/24 |
| PublicSubnet2CIDR | Please enter the IP range (CIDR notation) for the public subnet in the second Availability Zone | 10.10.1.0/24 |
| PrivateSubnet1CIDR | Please enter the IP range (CIDR notation) for the private subnet in the first Availability Zone | 10.10.3.0/24 |
| PrivateSubnet2CIDR | Please enter the IP range (CIDR notation) for the private subnet in the second Availability Zone | 10.10.4.0/24 |

**set_env.sh**
| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| S3_BUCKET | Bucket where CF templates will be uploaded. (See prerequisites section )| "" |
| S3_PREFIX | Template Bucket prefix| "" |
| ENV_NAME | Environment name | dev |

### Usage

1. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/aws-ecs/cloudformation`
2. Configure required parameters to be used in the CloudFormation stack deployment in files:
   * rookout.dev.json - only rookout resources deployment.
   * master.dev.json - rookout deployment within private vpc.
3. Configure required env variables to be used in sh scripts in 'set_env.sh' file.
4. run `./cf_validate.sh`
5. run `./cf_update_stack.sh create rookout` to create only rookout stack
6. run `./cf_update_stack.sh create master` to create master stack which includes private VPC and Rookout resources.