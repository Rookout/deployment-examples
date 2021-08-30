#!/usr/bin/env node

"use strict";
export class greeter {
  greeting: string;

  constructor(message: string) {
    this.greeting = message;
  }

  greet() {
    return "Hello, " + this.greeting;
  }

  private async well(ssss: string):Promise<void> {
    throw ssss;
  }
}