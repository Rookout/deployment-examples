# Quickstart for debugging Node.JS + AWS Lambda functions using Rookout and Serverless Framework

A sample application for debugging Node.JS + AWS Lambda functions using Rookout and Serverless Framework.

Before following this guide we recommend reading the basic [Node + Rookout] guide.

## Rookout Integration Process

To integrate Rookout into your existing Serverless Framework Python Lambda app, follow these steps:

1. Install the npm dependency `rookout`: `npm install rookout`

2. Wrap your function with the Lambda wrapper which get the handler and optional rookout options:    

```javascript
const rookout = require('rookout/lambda');

function handler(event, context, callback) {
        callback(null, "Hello World");
}

exports.handler = rookout.wrap(handler, {tags:['rookout_lambda']});
```
    
3. Set Lambda environment for `ROOKOUT_TOKEN` to connect with the Rookout service.    

## Deploy your function

1. `serverless deploy --region <YOUR_REGION> --ROOKOUT_TOKEN <YOUR_TOKEN>
    
1. Go to [app.rookout.com](https://app.rookout.com) and start debugging!

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
