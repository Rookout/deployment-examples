# Quickstart for Elastic Beanstalk Node + Rookout

A sample application for using Rookout + Node on AWS Elastic Beanstalk.

Before following this guide we recommend reading the basic [Node + Rookout] guide

* [Running on Elastic Beanstalk](#running-on-elastic-beanstalk)
* [Rookout Integration explained](#rookout-integration-explained)

## Adding Rookout to an existing EBS Project

There are 2 simple steps to integrate Rookout into your existing node beanstalk application:

1. Add the `rookout` npm dependency and require it in the entry file

2. Add our .ebextensions standalone config script [available here](.ebextensions)
    * The script download and install the Rookout ETL Agent

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__

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
1. Adding the Rookout SDK (aka "Rook") to the `package.json` file available on [npm]:
    ```bash
    $ npm install --save rookout
    ```

1. Adding a require statement to the project entry file app.ts:
    ```js
    const rook = require("rookout/auto_start");
    ```

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[npm]: https://www.npmjs.com/package/rookout


