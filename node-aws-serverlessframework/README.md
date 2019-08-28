# Quickstart for debugging Node.JS + AWS Lambda functions using Rookout and Serverless Framework

A sample application for debugging Node.JS + AWS Lambda functions using Rookout and Serverless Framework.

Before following this guide we recommend reading the basic [Node + Rookout] guide.

## Rookout Integration Process

To integrate Rookout into your existing Serverless Framework Python Lambda app, follow these steps:

1. Install the npm dependency `rookout`: `npm install rookout`

2. Wrap your function with the Lambda wrapper which get the handler and optional rookout options:    

```javascript
const rookout = require('rookout/lambda');
const serverless = require('serverless-http');
const express = require('express');
const app = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});

module.exports.handler = rookout.wrap(serverless(app));
```
    
3. Set Lambda environment for `ROOKOUT_TOKEN` to connect with the Rookout service.    

## Deploy your function

1. `serverless deploy --region <YOUR_REGION> --ROOKOUT_TOKEN <YOUR_TOKEN>
    
1. Go to [app.rookout.com](https://app.rookout.com) and start debugging!

[Node + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
