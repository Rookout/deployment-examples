const rook = require('rookout/auto_start');
const lambdaWrapper = require('rookout/lambda');
const serverless = require('serverless-http');
const express = require('express');
const app = express();

// our simple hello worl http handler
app.get('/', function (req, res) {
  res.send('Hello World!');
});

// wrap the handler with Rookout so we make sure rookout is loaded before any subsequent
// request are being handled
module.exports.handler = lambdaWrapper.wrap(serverless(app));