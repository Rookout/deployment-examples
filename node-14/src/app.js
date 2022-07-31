const tracer = require('dd-trace').init({ service: "bix-test-ms", env: "none" });
tracer.use('express');

const ah = require('async_hooks');

const rookout = require('rookout');
rookout.start();

const express = require("express");
const app = express();

class O {
    constructor(s) {
        this.s = s;
    }
}

function includes(s) {
    return true;
}

app.get('/', (req, res) => res.send("Hello World"));
app.get("/hello/:name", (req, res) => {
    console.log("@@@@@@@@@@@@@@@@@@");
    console.log(ah.executionAsyncId());
    // const x = tracer;
    // console.log(tracer.scope().active());
    // console.log(ah.executionAsyncResource());
    // let s = Symbol('ddResourceStore');
    // console.log(Symbol('ddResourceStore') === s);
    // console.log(ah.executionAsyncResource()[s]);
    let f = false;
    let r = new O("hello");
    const a = undefined;
    var b = 9;
    let c = undefined;
    var d = undefined;
    const name = req.params.name + req.params.name;
    res.send("Hello, " + name);
});

app.listen(9898);
