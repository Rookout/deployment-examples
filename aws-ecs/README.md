# Quickstart for Node + Agentless Rookout with Docker on AWS ECS

A sample application for using Node + Agentless Rookout with Docker on AWS ECS

Before following this guide we recommend reading the basic [Node + Rookout] guide

## Rookout Integration Explained

There are 2 simple steps to integrate Rookout into your existing Node application for an agentless setup:

1. Add the npm dependency `rookout`

1. Set the Rook's agent configuration as environment variables in the Docker container


## Running locally
**Requirements:** `node`, `docker`

1. Run `docker build --tag node-ecs-example . && docker run -it -p 8080:8080 -e "ROOKOUT_AGENT_HOST=<HOSTNAME>" -e "ROOKOUT_AGENT_PORT=<PORT>" node-ecs-example`

1. Open [http://localhost:8080/](http://localhost:8080/) to make sure everything works

1. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 

## Running on ECS

1. 

## Rookout Integration Process
We have added Rookout to the original project by:
1. Installing rookout dependency : `npm install --save rookout` and adding it in the entry file `const rookout = require('rookout/auto_start');`
    
1. Set Docker container ENV for `ROOKOUT_AGENT_HOST` (default LOCALHOST) and `ROOKOUT_AGENT_PORT` (default 7486) in order to connect to a remote hosted agent
    

[Node + Rookout]: https://rookout.github.io/tutorials/node