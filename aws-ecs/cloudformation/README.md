## Deploy Rookout Hybrid Deployment on AWS ECS Cluster using AWS Cloudformation
This CloudFormation deployment is to be used to deploy the Rookout Controller and Rookout Datastore with AWS ECS Fargate cluster.

![alt text](https://github.com/gchuev-opsfleet/deployment-examples/blob/aws-ecs-cloudformation/aws-ecs/cloudformation/Rookout-aws-ecs.png?raw=true)

### Prerequisites

Installed aws cli and default profile set with access key and secret. https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html

### Steps
1. `git clone https://github.com/Rookout/deployment-examples.git && cd deployment-examples/aws-ecs/cloudformation`
2. Configure required parameters to be used in the CloudFormation stack deployment in files:
   * rookout.dev.json - only rookout resources deployment.
   * master.dev.json - rookout deployment within private vpc.
3. Configure required env variables to be used in sh scripts in 'set_env.sh' file.
4. run `./cf_validate.sh`
5. run `./cf_update_stack.sh create rookout` to create only rookout stack
6. run `./cf_update_stack.sh create master` to create master stack which includes private VPC and Rookout resources.
