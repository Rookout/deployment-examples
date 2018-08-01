# Quickstart for Node + Agentless Rookout on IBM Cloud Functions

A sample application for using Node + Agentless Rookout on IBM Cloud Functions
<details>
<summary>What is Agentless?</summary>
<p>
Instead of having to install your own Agent own the machine you are running the code from,
you can use one of our hosted Agents and just tell the Rook to connect to it.<br/>
For more information you can see <a href="https://docs.rookout.com/docs/installation-agent-remote.html">our documentation</a>
</p>
</details>


Before following this guide we recommend reading the basic [Node + Rookout] guide


## Rookout Integration Explained

There are 3 simple steps to integrate Rookout into your existing Node application for an [agentless] setup:

1. Add the npm dependency `rookout`

1. Initialize the Rookout SDK as your function is loaded (Rookout auto-connect functionality relies on environment variables which are not available in IBM Cloud Functions).

1. Wrap your IBM Cloud Function with `rookout.wrap()`


## Running on IBM Cloud Function

1. Uploading your function : 
    - Update the source to include your own organization token in index.js line 3. More information can be found in [our documentation](https://docs.rookout.com/docs/installation-agent-remote.html).

    - Zip Upload: In order to run your rookout wrapped function on IBM Cloud Function, make sure the dependencies are downloaded and zip
    the folder (including node_modules).  
    zip -r actionFile.zip .
    
        **IMPORTANT:** _If you are building on a MacOS/Windows machine, npm will compile native binaries for this platform. IBM Cloud Function runs on Linux and thus needs the linux compiled binaries. In the example package, "npm run build" script uses a Docker to build the neccessary binaries.

    - ibmcloud cli : Create a new IBM Cloud Function action and update it like so :
        ```bash
        ibmcloud wsk action create packageAction --kind nodejs:6 action.zip
        ``` 

        **If you do not have access to ibmcloud cli, you can do this from the [IBM console](https://console.bluemix.net/openwhisk/actions) and follow the [IBM Documentation](https://console.bluemix.net/docs/openwhisk/openwhisk_actions.html#creating-and-invoking-javascript-actions)**

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !


## Rookout Integration Process

We have added Rookout to the original project by:
1. Installing rookout dependency : `npm install --save rookout` and adding it in the entry file `const rookout = require('rookout/openwhisk');`

1. Updating the package.json file to build depdencies on Linux using Docker:
```json
    "scripts" : {
        "install-modules": "docker run -it -v `pwd`:`pwd` -w `pwd` node:6 npm install",
        "build-package": "zip -r action.zip *",
        "build": "npm run install-modules && npm run build-package"
    }
```

1. Connecting the Rookout SDK on initialization as such:
```javascript
const rookout = require('rookout/openwhisk');

rookout.connect('cloud.agent.rookout.com', 443, ORG_TOKEN);
```

1. Wrapping your function with the IBM Cloud Function wrapper as such:  
```javascript
const rookout = require('rookout/openwhisk');

exports.main = rookout.wrap(myAction);
```

[Node + Rookout]: https://docs.rookout.com/docs/installation-node.html
