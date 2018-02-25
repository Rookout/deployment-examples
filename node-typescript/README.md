# Quickstart for TypeScript Node + Rookout and Docker-compose

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

### Using Bash

1. Download and install the agent as a systemd or init.d service on a __linux__ machine:
    ```bash
    $ curl -fs https://get.rookout.com | sudo -H bash -s agent
    ```


## Rookout Integration explained

This example is based of the Microsoft TypeScript-Node-Starter example available [here].

We have added Rookout to the original project by:
1. Adding rookout to `package.json` available on [npm]:
    ```bash
    $ npm install --save rookout
    ```

2. Adding a require statement to the project entry file src/server.ts:
    ```ts
    const rook = require("rookout/auto_start");
    ```

[TypeScript Node + Rookout]: https://rookout.github.io/tutorials/typescript
[here]: https://github.com/Microsoft/TypeScript-Node-Starter
[npm]: https://www.npmjs.com/package/rookout


## Running locally

1. Make sure you have a MongoDB server running (used by the example project, not rookout)
    ```bash
    $ mongod
    ```

2. Build & Serve locally:
    ```bash
    $ cd TypeScript-Node-Example && npm run build && npm start
    ```

3. Make sure everything worked: [http://localhost:3000](http://localhost:3000)

4. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 