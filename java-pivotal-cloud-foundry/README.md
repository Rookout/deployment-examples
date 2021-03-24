# Quickstart Debugging Java App + Maven running on Pivotal using Rookout

A sample application for debugging Java app + Maven running on Pivotal using Rookout.

Before following this guide we recommend completing the basic [Java + Rookout tutorial](https://github.com/Rookout/tutorial-java).

## Integrate Rookout into your Java application

To integrate Rookout into your existing Java application, follow these steps:

1. Add the rookout sdk as a maven [requirement](https://mvnrepository.com/artifact/com.rookout/rook) for example:
```xml
<!-- https://mvnrepository.com/artifact/com.rookout/rook -->
<dependency>
    <groupId>com.rookout</groupId>
    <artifactId>rook</artifactId>
    <version>0.1.88</version>
</dependency>
```

2. Add Rookout as a javaagent using the `cf cli`:
```bash
cf set-env YOUR-APP-NAME JAVA_OPTS '-javaagent:/app/BOOT-
INF/lib/rook-0.1.87.jar'
``` 

3. Set your Rookout Token as the `ROOKOUT_TOKEN` environment variable:
```bash
cf set-env YOUR-APP-NAME ROOKOUT_TOKEN YOUR-ROOKOUT-TOKEN
```


Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
