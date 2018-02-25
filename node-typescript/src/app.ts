#!/usr/bin/env node

"use strict";
const rook = require('rookout/auto_start');

const animals: Array<string> = ["Aardvark",
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

class TestClass {
    number: number;
    animal: string;

    constructor(number: number, animal: string) {
        this.number = number;
        this.animal = animal;
    }
}

var iteration: number = 0;

function testFunction() {
    iteration += 1;

    var local_iteration: number = iteration;
    var obj: TestClass = new TestClass(Math.random(), animals[Math.floor(Math.random() * animals.length)]);

    console.log('Iteration ' + iteration);
}

setInterval(testFunction, 5000);
