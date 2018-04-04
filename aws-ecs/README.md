# Quickstart for Node + Agentless Rookout with Docker on AWS ECS

A sample application for using Node + Agentless Rookout with Docker on AWS ECS

Before following this guide we recommend reading the basic [Node + Rookout] guide

## Rookout Integration Explained

There are 2 simple steps to integrate Rookout into your existing Node application for an agentless setup:

1. Add the npm dependency `rookout`

1. Set the Rook's agent configuration as environment variables in the Docker container


## Running locally
**Requirements:** `node`, `docker`

1. Run `docker build --tag node-ecs-example . && docker run -it -p 8080:8080 -e "ROOKOUT_AGENT_HOST=cloud.agent.rookout.com" -e "ROOKOUT_AGENT_PORT=443" -e "ROOKOUT_TOKEN=<TOKEN>" node-ecs-example`

1. Open [http://localhost:8080/](http://localhost:8080/) to make sure everything works

1. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Running on ECS

1. Build the docker image `docker build --tag node-ecs-example .`

1. Upload docker image to [Amazon ECR](https://console.aws.amazon.com/ecs/home?#/repositories/create/new)
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
        - Env Variables: `ROOKOUT_AGENT_HOST` and `ROOKOUT_AGENT_PORT`
        
1. Click create on the bottom right, and finish up the task wizard.
    

## Rookout Integration Process
We have added Rookout to the original project by:
1. Installing rookout dependency : `npm install --save rookout` and adding it in the entry file `const rookout = require('rookout/auto_start');`
    
1. Set Docker container ENV for `ROOKOUT_AGENT_HOST` (default LOCALHOST), `ROOKOUT_AGENT_PORT` (default 7486) and `ROOKOUT_TOKEN` in order to connect to a remote hosted agent
    

[Node + Rookout]: https://rookout.github.io/tutorials/node
