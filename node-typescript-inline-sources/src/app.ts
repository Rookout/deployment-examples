#!/usr/bin/env node

"use strict";
const rookout = require('rookout');
rookout.start();

const express = require("express");
const app = express();

import { add } from "./another_file"

import {greeter} from "./greeter"

let g = new greeter("asd");
g.greet();

app.get('/', (req: any, res: any) => res.send("Hello World"));
app.get("/hello/:name", (req: any, res: any) => {
    res.send("Hello, " + req.params.name +" :: " + add(5,4) + " :: " + g.greet());
});

app.listen(5000);