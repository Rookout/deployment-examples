# Quickstart for TypeScript Node + Rookout

A sample application for using Rookout + Node(TypeScript) .

Before following this guide we recommend reading the basic [TypeScript Node + Rookout] guide

* [Agent Setup](#agent-setup)
* [Rookout Integration explained](#rookout-integration-explained)
* [Running locally](#running-locally)

## Agent Setup

### Using Docker

1. Download and run the Rookout agent in a container:  
    
    ```bash
    $ docker pull rookout/agent
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```

For more information about Docker go [here](https://www.docker.com/).

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


## Running locally

1. Installing typescript dependencies (if you want to build yourself):
    ```bash
    $ npm install typescript -g && npm install @types/node
    ```

2. Installing dependencies:
    ```bash
    $ npm install rookout --save
    ```

3. Build:
    ```bash
    $ tsc app.ts --sourceMap --outDir ./output
    ```

4. Run:
    ```bash
    $ node ./output/app.js
    ```

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 