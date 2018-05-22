# Quickstart for Node.js + Rookout in the App Engine Flexible Environment

A sample application for using Rookout + Node.js + App Engine Flexible.

Before following this guide we recommend reading the basic [Node + Rookout] guide

* [Running locally](#running-locally)
* [Deploying to App Engine](#deploying-to-app-engine)
* [Rookout integration explain](#Rookout-integration-explain)
## Running locally
1. Run the agent:
``` bash
$ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
```

2. Install dependencies:
 ```bash
$ npm install
```

3. Run:
```bash
npm start
```

## Deploying to App Engine

1. Before deploying the app you should first deploy the agent:
```bash
$ gcloud beta compute instances create-with-container rookout-agent \
  --zone us-east1-d --container-image=rookout/agent \
  --container-env ROOKOUT_TOKEN=YOUR_TOKEN
```
2. Copy the agent ip from the `INTERNAL_IP` field, and add it to `app.yaml`.
3. Deploy the service: 
```bash
$ npm run deploy
```

## Rookout Integration explained

This example is based of the Google App Engine "Hello-World" example available [here].
We have added Rookout to original project by:
1. Adding rookout to `package.json`
2. Adding the following snippet to the code (`app.js`)
```javascript
var rookout = require('rookout/auto_start');
```
3. Adding the following `env_variables` to `app.yaml`:
``` YAML
env_variables:
  ROOKOUT_AGENT_HOST: "YOUR_ROOKOUT_AGENT_HOST"
```

[Node + Rookout]: https://docs.rookout.com/docs/installation-node.html
[here]: https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/appengine/hello-world
