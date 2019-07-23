# Quickstart for Java + JBoss debugging

A sample application for debugging Java + JBoss apps using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

## Rookout Integration Explained

There are 4 simple steps to integrate Rookout into your existing JBoss web application:

1. Copy the `module.xml` and the `rook.jar` to the `<JBOSS_FOLDER>\modules\org\jboss\rookout\main` folder.

2. Add the following JAVA_OPTS arguments in the standalone (<JBOSS_FOLDER>\bin\standalone.sh) config script:
```bash
-javaagent:<PATH_TO_ROOK>
```

This will add the rookout sdk as a java agent.

3. Modify standalone.xml file:
```bash
<subsystem xmlns="urn:jboss:domain:ee:1.0">
    <global-modules>
        <module name="org.jboss.rookout" slot="main"/>
    </global-modules>
</subsystem>
```

Due to JavaEE class isolation we need to add the rookout sdk as a global module. 

4. Set these variables in the `standalone.conf` at the top of the file like so in order to connect to the right ETL Controller:
```bash
export ROOKOUT_TOKEN="YOUR_TOKEN"
```

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
