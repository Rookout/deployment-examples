#!/usr/bin/env node

"use strict";
const rookout = require('rookout');
rookout.start();

const express = require("express");
const app = express();

import { add } from "./another_file"

app.get('/', (req: any, res: any) => res.send("Hello World"));
app.get("/hello/:name", (req: any, res: any) => {
    res.send("Hello, " + req.params.name +" :: " + add(5,4));
});

app.listen(5000);