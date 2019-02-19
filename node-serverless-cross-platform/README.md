# Quickstart for debugging Node + Serverless Cross Platform
## Introduction
Rookout has native dependencies that are compiled specifically for the current OS when installing the Rookout package specifically.  
If your machine isn't compatible with the target app OS, the native dependencies might not work.  
Thanks to Docker, we can easily emulate installing dependencies on a linux machine and therefore match the deploying OS with the target OS  

Before following this guide we recommend reading the basic [Node + Rookout] guide.

## The App
Our example application is a simple "Hello World!" serverless application that returns "Hello World!" for any incoming http request (see [index.js](index.js)).  

## The deployment process
In [package.json](package.json) file we defined the `deploy` script which builds and runs our deployment docker file

## The deployment [Dockerfile](Dockerfile)
1. We derive from the relevant node.js image (you can pick whatever node version you use)
1. We first install the serverless framework
1. We then install the app's dependencies. This is best for cache. As long as you don't change `package.json`, the dependency installation process will be cached.  
**NOTICE that if your'e using `yarn` you might want to copy `yarn.lock` instead of `package-lock.json`**
1. Next we copy the app's files
1. Finally we deploy to serverless
