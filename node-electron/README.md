# Quickstart for Electron + Agentless Rookout on AWS Lambda

A sample application for using Electron + Rookout

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## IMPORTANT :: The supported version of electron is 1.8.7 or higher

Before following this guide we recommend reading the basic [Node + Rookout] guide

## ETL Agent Setup

1. Download and run the Rookout ETL Agent in a container:  
    
    ```bash
    $ docker pull rookout/agent
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```

For more information about Docker go [here](https://www.docker.com/).

## Rookout Integration Explained

There are 4 simple steps to integrate Rookout into your existing Node-Electron application for an [agentless] setup:

1. Adding the Rookout SDK to `package.json` available on [npm]:
    ```bash
    $ npm install --save rookout --runtime=electron --target=ELECTRON_VERSION_HERE
    ```
	IMPORTANT:: replace ELECTRON_VERSION_HERE with your electron version

2. Adding a require statement to the project entry file:
    ```js
    const rook = require("rookout/auto_start");
    ```

3. Update the command line for electron to contain --inspect, In the `package.json`:
	```
	"scripts": {
    "start": "electron . --inspect" 
	},
	```
	
4. Build your electron application


FAQ
====
In case of an error like this:
```
Error: Failed to load gRPC binary module because it was not installed for the current system
Expected directory: electron-v1.8-win32-x64-unknown
Found: [node-v59-win32-x64-unknown]
```

simply delete grpc folder inside the node_modules, and run:

```bash
$ npm install --save rookout --runtime=electron --target=ELECTRON_VERSION_HERE
```

[Node + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
[npm]: https://www.npmjs.com/package/rookout