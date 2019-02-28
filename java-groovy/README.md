# Debug a Groovy app using Rookout

A sample app for debugging Groovy + Docker Compose using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)

## Running locally
1. Run the Rookout ETL Agent:
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
	
[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://github.com/tipsy/javalin/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
