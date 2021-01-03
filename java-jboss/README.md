# Quickstart for Java + JBoss debugging

A sample application for debugging Java + JBoss apps using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

## Rookout Integration Explained

There are up to 6 simple steps to integrate Rookout into your existing JBoss web application:

1. Copy the `module.xml` and the `rook.jar` to the `<JBOSS_FOLDER>\modules\org\jboss\rookout\main` folder.

2. Add the following JAVA_OPTS arguments in the standalone (<JBOSS_FOLDER>\bin\standalone.sh) config script:
```bash
-javaagent:<PATH_TO_ROOK>
```

This will add the rookout sdk as a java agent.

3. Add rookout SDK as a global module by modify the standalone.xml file: 
```bash
<subsystem xmlns="urn:jboss:domain:ee:<EE-SUBSYSTEM-VERSION>">
    <global-modules>
        <module name="org.jboss.rookout" slot="main"/>
        ........
    </global-modules>
</subsystem>
```

Due to JavaEE class isolation we need to add the rookout sdk as a global module. 

4. Set these variables in the `standalone.conf` at the top of the file like so in order to connect to the right ETL Controller:
```bash
export ROOKOUT_TOKEN="YOUR_TOKEN"
```
5. On some JBoss deployments you might need to update your jboss.modules.system.pkgs property.
It is probably already defined in your JBoss' startup script (maybe standalone.sh), and should probably be something like this right now:
```bash
JAVA_OPTS="$JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman"
```
Change it and append Rookout's packages:
```bash
JAVA_OPTS="$JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman,com.rookout,com.rookout."
```
(Note the placement of dots in package names. The package name without the dot (e.g., com.rookout) identifies the package itself, while the same package with a dot (com.rookout.) causes sub-packages to be included. Be sure to include both. 

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
