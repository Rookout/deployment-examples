# Quickstart for Node.js + Rookout in the App Engine Flexible Environment

A sample application for using Rookout + Node.js + App Engine Flexible.

Before following this guide we recommend reading the basic [Node + Rookout] guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

* [Deploying to App Engine](#deploying-to-app-engine)
* [Rookout integration explain](#Rookout-integration-explain)

## Deploying to App Engine

1. Deploy the service: 
```bash
$ npm run deploy
```
2. Access the URL provided to you once phase 3 successfully done to make sure our demo application is up and running.
3. Go to app.rookout.com and start debugging the service!

## Rookout Integration explained

This example is based of the Google App Engine "Hello-World" example available [here].

We have added Rookout to original project by:
1. Adding Rookout to `package.json`

2. Adding the following snippet to your application code (`app.js`)
```javascript
var rookout = require('rookout/auto_start');
```

3. Adding the following `env_variables` to `app.yaml`:
``` YAML
env_variables:
  ROOKOUT_TOKEN: "<Your Rookout Token>"
```

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/appengine/hello-world
