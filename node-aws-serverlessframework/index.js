const rookout = require('rookout/lambda');
const serverless = require('serverless-http');
const express = require('express');
const app = express();

// our simple hello world http handler
app.get('/', function (req, res) {
  res.send('Hello World!');
});

// wrap the handler with Rookout so we make sure rookout is loaded before any subsequent
// requests are being handled
module.exports.handler = rookout.wrap(serverless(app));