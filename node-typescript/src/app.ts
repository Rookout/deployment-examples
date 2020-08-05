#!/usr/bin/env node

"use strict";
const rookout = require('rookout');
rookout.start();

const express = require("express");
const app = express();

app.get('/', (req, res) => res.send("Hello World"));
app.get("/hello/:name", (req, res) => {
    res.send("Hello, " + req.params.name);
});

app.listen(5000);