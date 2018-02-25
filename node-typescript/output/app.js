#!/usr/bin/env node
"use strict";
var rook = require('rookout/auto_start');
var animals = ["Aardvark",
    "Abyssinian",
    "Affenpinscher",
    "Akbash",
    "Akita",
    "Albatross",
    "Alligator",
    "Alpaca",
    "Angelfish",
    "Ant",
    "Zorse"];
var TestClass = /** @class */ (function () {
    function TestClass(number, animal) {
        this.number = number;
        this.animal = animal;
    }
    return TestClass;
}());
var iteration = 0;
function testFunction() {
    iteration += 1;
    var local_iteration = iteration;
    var obj = new TestClass(Math.random(), animals[Math.floor(Math.random() * animals.length)]);
    console.log('Iteration ' + iteration);
}
setInterval(testFunction, 5000);
//# sourceMappingURL=app.js.map