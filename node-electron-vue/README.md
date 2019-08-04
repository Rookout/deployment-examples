# Quickstart for debugging an Electron + Lambda app using Rookout

A sample application for debugging an Electron app using Rookout

Before following this guide we recommend reading the basic [Node + Rookout] guide

## Rookout Integration Explained

There are 4 simple steps to integrate Rookout into your existing Node-Electron application:

1. Adding the Rookout SDK to `package.json` available on [npm]:
    ```bash
    $ npm install --save rookout
    ```
	IMPORTANT:: replace ELECTRON_VERSION_HERE with your electron version

2. Export Organization Token:
    ```bash
	$ export ROOKOUT_TOKEN=<Your-Token>
    ```

3. Adding a require statement to the project entry file:
    ```js
    const rookout = require("rookout/auto_start");
    ```

4. Update the command line for electron to contain --inspect, In the `package.json`:
	```
	"scripts": {
    "start": "electron . --inspect" 
	},
	```
	
5. Build your electron application


[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[npm]: https://www.npmjs.com/package/rookout
