# Quickstart for TypeScript Node + Rookout

A sample application for using Rookout + Node(TypeScript) .

__IMPORTANT FOR TYPESCRIPT:__

* __Rookout need corresponding sourcemaps to work properly.__

* In order to use require() you need to install the node types package to compile:
    ```bash
    $ npm install --save-dev @types/node
    ```

Before following this guide we recommend reading the basic [Node + Rookout] guide

* [Agent Setup](#agent-setup)
* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)


## Agent Setup


1. Download and run the Rookout agent in a container:  
    
    ```bash
    $ docker pull rookout/agent
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```

For more information about Docker go [here](https://www.docker.com/).


## Running locally


1. Installing dependencies:
    ```bash
    $ npm install
    ```

2. Build:
    ```bash
    $ npm run build
    ```

3. Run:
    ```bash
    $ npm start
    ```

4. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Rookout Integration explained


We have added Rookout to the original project by:
1. Adding rookout to `package.json` available on [npm]:
    ```bash
    $ npm install --save rookout
    ```

2. Adding a require statement to the project entry file app.ts:
    ```ts
    const rook = require("rookout/auto_start");
    ```


[Node + Rookout]: https://docs.rookout.com/docs/installation-node.html
[npm]: https://www.npmjs.com/package/rookout


