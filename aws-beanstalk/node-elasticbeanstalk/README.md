# Quickstart for Elastic Beanstalk Node + Rookout

A sample application for using Rookout + Node on AWS Elastic Beanstalk.

Before following this guide we recommend reading the basic [Node + Rookout] guide

* [Agent Setup](#agent-setup)
* [Running locally](#running-locally)
* [Running on Elastic Beanstalk](#running-on-elastic-beanstalk)
* [Rookout Integration explained](#rookout-integration-explained)

## Adding Rookout to an existing EBS Project

There are 2 simple steps to integrate Rookout into your existing node beanstalk application:

1. Add the `rookout` npm dependency and require it in the entry file

2. Add our .ebextensions standalone config script [available here](https://github.com/Rookout/deployment-examples/tree/master/aws-beanstalk/node-elasticbeanstalk/.ebextensions)
    * The script download and install the agent that is responsible for communication

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__



## Running locally

#### Agent Setup


1. Download and run the Rookout agent in a container:  
    
    ```bash
    $ docker pull rookout/agent
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```

For more information about Docker go [here](https://www.docker.com/).

#### App Setup

**Clone or download the `node-example` folder and run these commands inside it:**


1. Installing dependencies:
    ```bash
    $ npm install
    ```

1. Build:
    ```bash
    $ npm run build
    ```

1. Run:
    ```bash
    $ npm start
    ```

1. Go to [https://app.rookout.com](https://app.rookout.com) and start debugging! 


## Running on Elastic Beanstalk

1. Clone or download the `node-example` folder

1. Zip up the contents in order to upload to EBS platform :
`zip -r node-example.zip . -x node_modules/\*`

You can use either the AWS Management Console or the EB CLI to launch the node application. Scroll down for EB CLI instructions.

##### To deploy with the AWS Management Console
1. Open the [Elastic Beanstalk Management Console](https://console.aws.amazon.com/elasticbeanstalk/home)

1. Upload the source (node-example.zip) bundle when creating a [new Beanstalk app](https://console.aws.amazon.com/elasticbeanstalk/home#/gettingStarted)

1. Choose 'Node' Platform

1. Make sure everything worked by accessing the url provided by Elastic Beanstalk after build completed

1. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging!


## Rookout Integration explained


We have added Rookout to the original project by:
1. Adding rookout to `package.json` available on [npm]:
    ```bash
    $ npm install --save rookout
    ```

1. Adding a require statement to the project entry file app.ts:
    ```js
    const rook = require("rookout/auto_start");
    ```

1. Adding Rookout's Elastic Beanstalk .ebextensions to install agent on machine to communicate with the app:
   ```
   commands: 
       "01": 
           command: wget "https://get.rookout.com" -O setup.sh
       "02": 
           command: sudo /bin/bash setup.sh agent --token=<YOUR_TOKEN>
       "03": 
           command: /etc/init.d/rookout-agent start
   ```

[Node + Rookout]: https://docs.rookout.com/docs/installation-node.html
[npm]: https://www.npmjs.com/package/rookout


