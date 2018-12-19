# Quickstart for TypeScript Node + Rookout

A sample application for using Rookout + Node(TypeScript) .

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

__IMPORTANT FOR TYPESCRIPT:__

* __Rookout need corresponding sourcemaps to work properly.__

* In order to use require() you need to install the node types package to compile:
    ```bash
    $ npm install --save-dev @types/node
    ```

Before following this guide we recommend reading the basic [Node + Rookout] guide

* [Running node server with Rookout](#running-node-server-with-rookout)
* [Rookout Integration explained](#rookout-integration-explained)


## Running Node server with Rookout

1. Installing dependencies:
    ```bash
    $ npm install
    ```

2. Export organization token
    ```bash
    $ export ROOKOUT_TOKEN=<Your Rookout Token>
    ```

3. Build:
    ```bash
    $ npm run build
    ```

4. Run:
    ```bash
    $ npm start
    ```

5. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


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

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[npm]: https://www.npmjs.com/package/rookout


