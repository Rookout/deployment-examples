# Quickstart for Groovy + Rookout and Docker-compose

A sample application for using Rookout + Java(Maven) + Docker .

Before following this guide we recommend reading the basic [Java + Rookout] guide

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)
## Running locally
1. Run the Rookout agent:
    ``` bash
    $ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
    ```
2. Build the docker image:
	```bash
	$ docker build -t=rookoutgroovy .
	```
3. Run the docker image:
    ```bash
    $ docker run -it rookoutgroovy bash
    ```
4. Run the groovy script
	```bash
    $ groovy /home/groovy/test_groovy.groovy
    ```
	
[Java + Rookout]: https://docs.rookout.com/docs/installation-java.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
