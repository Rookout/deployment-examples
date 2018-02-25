# Quickstart for TypeScript Node + Rookout

A sample application for using Rookout + Node(TypeScript) .

Before following this guide we recommend reading the basic [TypeScript Node + Rookout] guide

* [Agent Setup](#agent-setup)
* [Rookout Integration explained](#rookout-integration-explained)
* [Running locally](#running-locally)

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

[TypeScript Node + Rookout]: https://rookout.github.io/tutorials/typescript
[npm]: https://www.npmjs.com/package/rookout


