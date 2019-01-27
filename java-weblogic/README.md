# Quickstart for debugging Java + Oracle WebLogic 

A sample application for debugging Java + Oracle WebLogic using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

* [Running the app](#running-the-app)
* [Rookout Integration explained](#rookout-integration-explained)


## Running the app
1. [Download the Rookout Java Agent](http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST)
1. Add the Rookout Java Agent and set your organization token in the `startWebLogic.sh` script
    ```bash
        JAVA_OPTIONS="${SAVE_JAVA_OPTIONS} -javaagent=<ROOK_LOCATION>/rook.jar"
        export ROOKOUT_TOKEN="<Your-Rookout-Token>"
    ```
1. Start your WebLogic server
1. Build and deploy the WebLogic webservice:
    You can change the weblogic configuration in the `weblogic-helloworld/build.xml`  
    default url is `localhost:7001`  
    default username/password is `weblogic:weblogic12`
    ``` bash
    $ cd weblogic-helloworld
    $ ant -lib $WEBLOGIC_HOME/wlserver/server/lib/weblogic.jar
    ```
    The built web application is now situated in `output/helloWorldEar/helloWorldEar.war`
1. Test your WebService using the [WebLogic Test Client](http://localhost:7001/ws_utc/begin.do?wsdlUrl=http://localhost:7001/HelloWorldImpl/HelloWorldService?WSDL)
1. Go to [app.rookout.com](https://app.rookout.com/) and start debugging !

## Rookout Integration explained

This example is based of the Java javalin "Hello-World" example available [here].

We have added Rookout to the original project by:
1. Including source files and compiling with debug information in the ant task:
    ```xml
       <target name="build-service">
           <jwsc
                   srcdir="src"
                   destdir="${ear-dir}"
                   debug="true">
               <module name="${ear.deployed.name}">
                   <jws file="examples/webservices/hello_world/HelloWorldImpl.java"
                        type="JAXWS"/>
                   <zipfileset dir=".">
                       <include name="src/**"/>
                   </zipfileset>
               </module>
       
           </jwsc>
       </target>
    ```
1. Downloading the Rookout Java Agent available on [maven central]:
    ```bash
        wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
    ```
1. Specified the Rookout Java Agent in Weblogic startup script:
    
   - File location: `WEBLOGIC_HOME/user_projects/domains/DOMAIN_NAME/bin/startWebLogic.sh`
   
   - Find the line `JAVA_OPTIONS="${SAVE_JAVA_OPTIONS} "`
   - Append the Rookout SDK (aka "Rook") :
   ```bash
        JAVA_OPTIONS="${SAVE_JAVA_OPTIONS} -javaagent=ROOK_LOCATION/rook.jar"
   ```
   - Set your `ROOKOUT_TOKEN`:
   ```bash
        export ROOKOUT_TOKEN="<Your-Rookout-Token>"
   ```


[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
