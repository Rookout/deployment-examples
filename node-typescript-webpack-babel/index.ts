"use strict";
const rookout : object = require('rookout');
rookout.start();

const express : object = require("express");
const app : object = express();

app.get('/', (req, res) => res.send("Hello World"));
app.get("/hello/:name", (req, res) => {
    res.send("Hello, " + req.params.name);
});

app.listen(5000);