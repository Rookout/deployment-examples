## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using AWS Cloudformation
This CloudFormation deployment is to be used to deploy the Rookout Controller and Rookout Datastore within AWS ECS Fargate cluster.

![alt text](https://github.com/gchuev-opsfleet/deployment-examples/blob/OP-3-create-ecs-deployment-method-datastore-controller/aws-ecs/cloudformation/Rookout-aws-ecs.png?raw=true)

### Prerequisites
1. AWS account
2. AWS CLI installed 
3. The AWS default profile should be set with an access key and secret ([reference](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)).
   * Set profile if used non default profile. Run: `export AWS_PROFILE="<profile_name>"`
4. Create a secret in the secrets manager with your Rookout token using one of the following options:
   * AWS CLI - Change the <rookout_token> placeholder with your token and run:
      * `aws secretsmanager create-secret --name rookout_token --description "Rookout token" --secret-string "<rookout_token>"`
   * AWS Console - follow this [tutorial](https://docs.aws.amazon.com/secretsmanager/latest/userguide/tutorials_basic.html)
   * Use the token secret's ARN as value for the TokenSecretArn variable in `(existing-vpc||inbcluding-vpc).dev.json` (see [Parameters](#parameters))
6. Create an S3 bucket for the CloudFormation templates.


### Usage
1. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/aws-ecs/cloudformation`
2. Configure required [parameters](#parameters) to be used in the CloudFormation stack deployment in one of the following files:
   * existing-vpc.dev.json - for deploying in an existing VPC
   * inbcluding-vpc.dev.json - for deploying in a new VPC
3. Configure the variables according to your environment in the set_env.sh file.
4. run `./cf_validate.sh` to validate template files
5. run `./cf_update_stack.sh create existing-vpc` to create only a Rookout stack
6. run `./cf_update_stack.sh create including-vpc` to create master stack which includes a private VPC and Rookout resources.
7. The default values deploy the Controller and Datastore in “PLAIN” mode, which means that for connecting to the Datastore from the user’s browser, or for connecting agents to the Controller from a different VPC, you would need to add a TLS termination proxy (ALB). See the “[parameters](#parameters)” section for other options, such as creating an ALB automatically, or using different modes. (server mode reference - [Datastore](https://docs.rookout.com/docs/dop-config/#server-mode), [Controller](https://docs.rookout.com/docs/etl-controller-config/#server-mode))

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
| LaunchType |  Launch type for ECS Services. Set to EC2 if you've provided ClusterName variable with existing EC2 cluster name. | FARGATE |
| PrivateDNSZoneName  | Name for AWS CloudMap namespace used for service discovery  | cluster.local |
| DefaultVPC  | Set true if you want to use default VPC or VPC without private networks.  | false |
| PublicSubnets | List of public subnets for LoadBalancer and for ECS tasks in case of default vpc deployment.| none |
| PrivateSubnets |  Select list of private subnets for ECS tasks. They should be in same VPC and has routes between PublicSubnets if you're using LB. Ignored when you set DefaultVPC to true | "" |
| VpcId | VPC ID where resources will be deployed. | none |
| DOPInMemoryDB | Set true if you want to use InMemory db mode for datastore. ROOKOUT_DOP_IN_MEMORY_DB env variable will be set for datastore service. | true |
| DOPCorsAll | ROOKOUT_DOP_CORS_ALL env variable will be set for datastore service. | true |
| CreateLB | Set true if you want to use LoadBalancer for chosen deployment. | false |
| ExistingLBArn | Set ALB ARN if you want to use existing Application Load Balancer for chosen deployment. Should be in same VPC as the deployment. | "" |
| Environment | Deployment environment (dev|prod|stage)| "dev" |
| ControllerServerMode |  Server mode for Controller service. CertificateS3Bucket and CertificateS3BucketPrefix will be used to download certificates in case of TLS mode. | PLAIN |
| DatastoreServerMode|  Server mode for Datastore service. CertificateS3Bucket and CertificateS3BucketPrefix will be used to download certificates in case of TLS mode. | PLAIN |
| ControllerPublishLB | Set true if you want to publish a Controller service through LoadBalancer. CreateLB parameter should be set to true. | false |
| DatastorePublishLB | Set true if you want to publish a Datastore service through LoadBalancer. CreateLB parameter should be set to true. | false |
| DeployController | Set true if you want to deploy Controller service. | true |
| DeployDatastore | Set true if you want to deploy Controller service. | true |
| ControllerCertArn | ACM Certificate Arn for TLS deployment of Controller service with LoadBalancer. | "" |
| DatastoreCertArn | ACM Certificate Arn for TLS deployment of Datastore service with LoadBalancer. | |
| CertificateS3Bucket | S3 bucket name where certificate files will be stored and downloaded by container task to datastore contaner volume. Automatically set datastore ROOKOUT_DOP_SERVER_MODE variable to TLS | "" |
| ControllerCertS3BucketPrefix | S3 bucket prefix (path in the bucket) where certificate files will be stored and downloaded by container task to controller contaner volume. Can be optionally set along with CertificateS3Bucket. | "" |
| DatastoreCertS3BucketPrefix | S3 bucket prefix (path in the bucket) where certificate files will be stored and downloaded by container task to controller contaner volume. Can be optionally set along with CertificateS3Bucket. | "" |
| ControllerContainerCPU | Controller container CPU requested.| 256 |
| ControllerContainerMemory | Controller container Memory requested. | 512 |
| ControllerTaskCPU | Controller Task CPU requested.| 512 |
| ControllerTaskMemory | Controller Task Memory requested. | 1024 |
| DatastoreContainerCPU | Datastore container CPU requested. | 256 |
| DatastoreContainerMemory | Datastore container Memory requested. | 512|
| DatastoreTaskCPU | Controller Task CPU requested.| 512 |
| DatastoreTaskMemory | Controller Task Memory requested. | 1024 |
| DatastoreStorageSize | Datastore container ephermal storage size. | 20 |
| ControllerContainerPort | Controller container port to listen | 7488 |
| ControllerLBPort | Controller port for Load Balancer listener | 7488 |
| DatastoreContainerPort | Datastore container port to listen | 8080 |
| DatastoreLBPort | Datastore port for Load Balancer listener | 443 |


| OutputName  | Description |
| ------------- | ------------- |
| AlbDNSName | FQDN of load_balancer in case CreateLB variable set to true. Can be used as CNAME target in case of using external DNS. ![Route53 RefDoc](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-creating.html) |
| RookoutLogGroup | Name of the log group for rookout tasks |
| ControllerPrivateDNS | Private endpoint for controller service for access within the vpc. Default port is 7488 |
| DatastorePrivateDNS | Private endpoint for controller service for access within the vpc. Default port is 8080  |

**Note:** You can use alb dns name directrly to access datastore/controller. By default if loadbalancer is used and certificate arn is provided, datastore will be securely published on 443 port of load balancer, controller will be securely published with default port 7488. In case if certificate arn is not provided datastore will be published via HTTP on port 80. Task can be accessed publicly directly via public ip in case of default vpc, datastore default port is 8080, controller's - 7488.

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
| Environment | Deployment environment (dev|prod|stage)| "dev" |
| VpcCIDR| Please enter the IP range (CIDR notation) for this VPC | 10.10.0.0/16 |
| PublicSubnet1CIDR | Please enter the IP range (CIDR notation) for the public subnet in the first Availability Zone | 10.10.0.0/24 |
| PublicSubnet2CIDR | Please enter the IP range (CIDR notation) for the public subnet in the second Availability Zone | 10.10.1.0/24 |
| PrivateSubnet1CIDR | Please enter the IP range (CIDR notation) for the private subnet in the first Availability Zone | 10.10.3.0/24 |
| PrivateSubnet2CIDR | Please enter the IP range (CIDR notation) for the private subnet in the second Availability Zone | 10.10.4.0/24 |
| ControllerServerMode |  Server mode for Controller service. CertificateS3Bucket and CertificateS3BucketPrefix will be used to download certificates in case of TLS mode. | PLAIN |
| DatastoreServerMode|  Server mode for Datastore service. CertificateS3Bucket and CertificateS3BucketPrefix will be used to download certificates in case of TLS mode. | PLAIN |
| ControllerPublishLB | Set true if you want to publish a Controller service through LoadBalancer. CreateLB parameter should be set to true. | false |
| DatastorePublishLB | Set true if you want to publish a Datastore service through LoadBalancer. CreateLB parameter should be set to true. | false |
| ControllerCertArn | ACM Certificate Arn for TLS deployment of Controller service with LoadBalancer. | "" |
| DatastoreCertArn | ACM Certificate Arn for TLS deployment of Datastore service with LoadBalancer. | |
| CertificateS3Bucket | S3 bucket name where certificate files will be stored and downloaded by container task to datastore contaner volume. Automatically set datastore ROOKOUT_DOP_SERVER_MODE variable to TLS | "" |
| ControllerCertS3BucketPrefix | S3 bucket prefix (path in the bucket) where certificate files will be stored and downloaded by container task to controller contaner volume. Can be optionally set along with CertificateS3Bucket. | "" |
| DatastoreCertS3BucketPrefix | S3 bucket prefix (path in the bucket) where certificate files will be stored and downloaded by container task to controller contaner volume. Can be optionally set along with CertificateS3Bucket. | "" |

**set_env.sh**
| ParameterName  | Description | Default |
| ------------- | ------------- | ------------- |
| ENV_NAME | Environment name | dev |
| STACK_NAME | Name of cloudformation stack to deploy | ${ENV_NAME}-rookout |
| REGION | AWS Region for stack deployment |
| S3_BUCKET | Bucket where CF templates will be uploaded. (See prerequisites section )| "" |
| S3_PREFIX | Template Bucket prefix| "" |