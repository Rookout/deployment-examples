# Quickstart for Java + Rookout and Docker-compose

A sample application for using Rookout + Java(Maven/Gradle) + Docker-compose .

Before following this guide we recommend reading the basic [Java + Rookout] guide

* [Running locally](#running-locally)
* [Deploying to App Engine](#deploying-to-app-engine)
* [Rookout Integration explained](#Rookout-integration-explained)
## Running locally
1. Run the Rookout agent:
    ``` bash
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```
2. Compile the project jar and download the Java agent:
     ```bash
    $ make build
    ```
3. Run:
    ```bash
    $ make run-local
    ```
4. Make sure everything worked: [http://localhost:7000/hello](http://localhost:7000/hello)


## Using docker-compose

1. Compile the project jar and download the Java agent:
     ```bash
    $ make build
    ```
2. Edit docker-compose.yaml and add your token

3. Build the image
    ``` bash
    $ docker-compose build
    
    ```
4. Run:
    ```bash
    $ docker-compose up
    ```
5. Make sure everything worked: [http://localhost:7000/hello](http://localhost:7000/hello)

## Rookout Integration explained

This example is based of the Google App Engine "Hello-World" example available [here].
We have added Rookout to original project by:
1. Adding rookout to `package.json`
2. Adding the following snippet to the code (`app.js`)
```javascript
var rookout = require('rookout/auto_start');
```
3. Adding the following `env_variables` to `app.yaml`:
``` YAML
env_variables:
  ROOKOUT_AGENT_HOST: "YOUR_ROOKOUT_AGENT_HOST"
```

[Java + Rookout]: https://rookout.github.io/tutorials/java
[here]: https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/appengine/hello-world
