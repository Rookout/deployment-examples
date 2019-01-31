#!/usr/bin/env node

"use strict";
const rook = require('rookout');
// You can either specify your token here as an option map, or don't specify it and instead use the ROOKOUT_TOKEN
// environment variable to specify it.
rook.start();

// Specify using an option map:
// rook.start({
//     token: 'rookout-token'
// })

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

let iteration: number = 0;

function testFunction() {
    iteration += 1;

    let local_iteration: number = iteration;
    let obj: TestClass = new TestClass(Math.random(), animals[Math.floor(Math.random() * animals.length)]);

    console.log('Iteration ' + iteration);
}

setInterval(testFunction, 4000);
