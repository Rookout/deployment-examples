# Quickstart for Java + JBoss debugging

A sample application for debugging Java + JBoss apps using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

## Rookout Integration Explained

There are 4 simple steps to integrate Rookout into your existing JBoss web application:

1. Copy the `module.xml` and the rook.jar to the `<JBOSS_FOLDER>\modules\org\jboss\rookout\Main` folder.

2. Add the following JAVA_OPTS arguments in the standalone config script:
```bash
-javaagent:<PATH_TO_ROOK> -Djava.util.logging.manager=org.jboss.logmanager.LogManager -Djboss.modules.system.pkgs=org.jboss.byteman,org.jboss.logmanager 
-Xbootclasspath/p:<JBOSS_FOLDER>\modules\org\jboss\logmanager\main\jboss-logmanager-1.2.2.GA.jar 
-Xbootclasspath/p:<JBOSS_FOLDER>\modules\org\jboss\logmanager\log4j\main\jboss-logmanager-log4j-1.0.0.GA.jar 
-Xbootclasspath/p:<JBOSS_FOLDER>\modules\org\apache\log4j\main\log4j-1.2.16.jar
```

This will add the rookout sdk as a java agent, and will fix any logmanager loading issues.

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
