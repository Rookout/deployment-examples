# Quickstart for Node + Agentless Rookout on IBM OpenWhisk Functions

A sample application for using Node + Agentless Rookout on IBM OpenWhisk Functions
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

1. Wrap your OpenWhisk function with `rookout.wrap()`

1. Set the Rook's agent configuration as environment variables in the action configuration


## Running on IBM OpenWhisk

1. Uploading your function : 
    - Zip Upload: In order to run your rookout wrapped function on IBM OpenWhisk, make sure the dependencies are downloaded and zip
    the folder (including node_modules).  
    zip -r actionFile.zip .
    
        **IMPORTANT:** _If you are building on a MacOS/Windows machine, npm will compile native binaries for this platform. IBM OpenWhisk runs on Linux and thus needs the linux compiled binaries. In the example package, "npm run build" script uses a Docker to build the neccessary binaries.

    - ibmcloud cli : Create a new OpenWhisk action and update it like so :
        ```bash
        ibmcloud wsk action create packageAction \
                    --kind nodejs:6 \
                    --param ROOKOUT_AGENT_HOST cloud.agent.rookout.com \
                    --param ROOKOUT_AGENT_PORT 443 \
                    --param ROOKOUT_TOKEN <org-token>
                    action.zip 

        **If you do not have access to ibmcloud cli, you can do this from the [IBM console](https://console.bluemix.net/openwhisk/actions) and follow the [IBM Documentation](https://console.bluemix.net/docs/openwhisk/openwhisk_actions.html#creating-and-invoking-javascript-actions)**

1. Set the Rook's agent configuration as environment variables in the action configuration, fill the Environment Variables for :
    - `ROOKOUT_AGENT_HOST` : cloud.agent.rookout.com
    - `ROOKOUT_AGENT_PORT` : 443
    - `ROOKOUT_TOKEN` : Your Organization Token
    
    More information can be found in [our documentation](https://docs.rookout.com/docs/installation-agent-remote.html)

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

1. Wrapping your function with the OpenWhisk wrapper as such :  
```javascript
const rookout = require('rookout/openwhisk');

exports.main = rookout.wrap(myAction);
```
    
1. Set action environment for `ROOKOUT_AGENT_HOST` (cloud.agent.rookout.com), `ROOKOUT_AGENT_PORT` (443) and `ROOKOUT_TOKEN` in order to connect to a remote hosted agent
    

[Node + Rookout]: https://docs.rookout.com/docs/installation-node.html
