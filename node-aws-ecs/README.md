# Quickstart for debugging a Docker based Node app Deployed in AWS ECS using Rookout

A sample application for debugging a Docker based Node app Deployed in AWS ECS using Rookout.

Before following this guide we recommend reading the basic [Node + Rookout] guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Rookout Integration Explained

There are 2 simple steps to integrate Rookout into your existing Node application:

1. Add the npm dependency `rookout`

1. Set the Rookout ETL Agent configuration as environment variables in the Docker container


## Running locally
**Requirements:** `node`, `docker`

1. Run `docker build --tag node-ecs-example . && docker run -it -p 8080:8080 -e "ROOKOUT_AGENT_HOST=cloud.agent.rookout.com" -e "ROOKOUT_AGENT_PORT=443" -e "ROOKOUT_TOKEN=<TOKEN>" node-ecs-example`

1. Open [http://localhost:8080/](http://localhost:8080/) to make sure everything works

1. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Running on ECS

1. Build & Upload docker image using this guide to [Amazon ECR](https://console.aws.amazon.com/ecs/home?#/repositories/create/new)
    - Follow instructions in the link in order to create and upload to the repository
    
1. Create a task definition in [Amazon ECS](https://console.aws.amazon.com/ecs/home?#/taskDefinitions/create)
    - Enter a name for your task definition - e.g. `rookout-test-ecs`
    - Leave the rest as default and click on `Add container` under the **Container Definitions** title and configure as follows:
    - Container name - e.g. `agentless-node-app`
    - Image - [registry-url]/[namespace]/[image]:[tag]
        - Example: 123412345738.dkr.ecr.eu-central-1.amazonaws.com/rookout/ecs-test:1.0
    - Memory Limits: Hard limit: 128
    - Port mappings: Host 80 / Container 8080
    - **Environment**
        - Env Variables: `ROOKOUT_AGENT_HOST`, `ROOKOUT_AGENT_PORT`, `ROOKOUT_TOKEN`
    
    Or using JSON Configuration :
    ```json
    {
      "containerDefinitions": [
        {
          "memory": 128,
          "volumesFrom": [],
          "image": "[registry-url]/[namespace]/[image]:[tag]",
          "name": "rook-test-task",
          "portMappings": [
            {
              "hostPort": 80,
              "protocol": "tcp",
              "containerPort": 8080
            }
          ],
          "environment": [
            {
              "name": "ROOKOUT_AGENT_HOST",
              "value": "cloud.agent.rookout.com"
            },
            {
              "name": "ROOKOUT_AGENT_PORT",
              "value": "443"
            },
            {
              "name": "ROOKOUT_TOKEN",
              "value": "TOKEN"
            }
          ]
        }
      ]
    }
    ```
        
1. Click create on the bottom right, and finish up the task wizard.

1. Last step is to create or use an existing cluster, run this task and start debugging at [https://app.rookout.com](https://app.rookout.com)
    

## Rookout Integration Process
We have added Rookout to the original project by:
1. Installing the Rookout SDK: `npm install --save rookout` and adding it in the entry file `const rookout = require('rookout/auto_start');`
    
1. Setting up the Rookout ETL Agent by setting the following environment variables: `ROOKOUT_AGENT_HOST` (default LOCALHOST), `ROOKOUT_AGENT_PORT` (default 7486) and `ROOKOUT_TOKEN`.

[Node + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
