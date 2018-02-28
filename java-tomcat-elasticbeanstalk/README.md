# Quickstart for Java Tomcat + Rookout and AWS Elastic Beanstalk

A sample application for using Rookout + Java Tomcat + AWS Elastic Beanstalk .

Before following this guide we recommend reading the basic [Java + Rookout] guide .

This sample application is the Tomcat sample app provided by AWS.
For more information about the project structure and how to use it refer to [this documentation](https://github.com/Rookout/deployment-examples/tree/master/java-tomcat-elasticbeanstalk/eb-tomcat-snakes/README.md)

## Elastic Beanstalk Rookout Integration Explained

There are 2 simple steps to integrate Rookout into your existing java beanstalk application:

1. Add the source files to your built .jar

2. Add our 2 .ebextensions standalone config scripts [available here](https://github.com/Rookout/deployment-examples/tree/master/java-tomcat-elasticbeanstalk/.ebextensions)
    * First one download and install the agent that is responsible for communication
    * Second one download and tells the JVM to use Rookout's java agent

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__


## Running locally
__REQUIREMENTS: This sample project requires Tomcat8 and a PostgreSQL 9.4 running__

Run the Rookout agent:
    ~$ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent

Run ``make local-unix`` or ``make local-win`` depending on your OS to add the rook java agent to Tomcat locally

Run ``build.sh`` to compile the web app and create a WAR file (OS X or Linux):

	~$ cd eb-tomcat-snakes
	~/eb-tomcat-snakes$ ./build.sh

Or in Windows with Git Bash:

	~/eb-tomcat-snakes$ ./build-windows.sh

**IMPORTANT**
Always run build.sh from the root of the project directory.

The script compiles the project's classes, packs the necessary files into a web archive, and then attempts to copy the WAR file to ``/Library/Tomcat`` for local testing. If you installed Tomcat to another location, change the path in ``build.sh`` and in the Makefile:

	if [ -d "/path/to/Tomcat/webapps" ]; then
	  cp ROOT.war /path/to/Tomcat/webapps

Open [localhost:8080](http://localhost:8080/) in a web browser to view the application running locally.

**Finally** Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Deploying on AWS Elastic Beanstalk

You can use either the AWS Management Console or the EB CLI to launch the compiled WAR. Scroll down for EB CLI instructions.

##### To deploy with the AWS Management Console
1. Open the [Elastic Beanstalk Management Console](https://console.aws.amazon.com/elasticbeanstalk/home)
2. Choose *Create New Application*
3. For *Application Name*, type **tomcat-snakes**. Choose *Next*.
4. Choose *Web Server Environment*
5. Set the platform to *Tomcat* and choose *Next*.
6. Choose *Upload your own* and *Choose File*.
7. Upload *ROOT.war* from your project directory and choose *Next*.
8. Type a unique *Environment URL* and choose *Next*.
9. Check *Create an RDS DB Instance with this environment* and choose *Next*.
10. Set *Instance type* to *t2.nano* and choose *Next*. Choose *Next* again to skip tag configuration.
11. Apply the following RDS settings and choose *Next* (leave the other settings default):
    - DB engine: *postgres*
    - Engine version: *9.4.5*
    - Instance class: *db.t2.micro*
    - Master username: any username
    - Master password: any password
12. Choose **Next** to create and use the default role and instance profile. 
13. Choose **Launch**.

The process takes about 15 minutes. If you want to save time during the initial environment creation, you can launch the environment without a database, and then add one after the environment is running from the Configuration page. Launching an RDS DB instance takes about 10 minutes.

##### To deploy with the EB CLI

The EB CLI requires Python 2.7 or 3.4 and the package manager ``pip``. For detailed instructions on installing the EB CLI, see [Install the EB CLI](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html) in the AWS Elastic Beanstalk Developer Guide.

Install the EB CLI:

	~$ pip install awsebcli

Initialize the project repository:

	~/eb-tomcat-snakes$ eb init

Add the following to ``.elasticbeanstalk/config.yml``:

	deploy:
	  artifact: ROOT.war

Create an environment with an RDS database:

	~/eb-tomcat-snakes$ eb create tomcat-snakes --sample --single --timeout 20 -i t2.micro --database.engine postgres --database.instance db.t2.micro --database.username *any username* --database.password *any password*

Deploy the project WAR to your new environment:

	~/eb-tomcat-snakes$ eb deploy --staged

Open the environment in a browser:

	~/eb-tomcat-snakes$ eb open


## Rookout Integration Process
We have added Rookout to the original project by:
1. Adding the source files to the project .war when building (we added the 'com' folder here):
    
    ~$ jar -cf ROOT.war *.jsp images css js WEB-INF .ebextensions/*.config .ebextensions/*.json com

2. Adding Rookout's Elastic Beanstalk .ebextensions to install agent on machine and add the javaagent to communicate with the app:
    ```
    commands: 
        "01": 
            command: wget "https://get.rookout.com" -O setup.sh
        "02": 
            command: sudo /bin/bash setup.sh agent --token=<YOUR_TOKEN>
        "03": 
            command: /etc/init.d/rookout-agent start
    ```
    ```
    files:
        "/opt/elasticbeanstalk/lib/rook.jar" :
            mode: "000444"
            owner: root
            group: root
            source: "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"
    option_settings:
        aws:elasticbeanstalk:container:tomcat:jvmoptions:
            JVM Options: '-javaagent:/opt/elasticbeanstalk/lib/rook.jar'
    ```

[Java + Rookout]: https://rookout.github.io/tutorials/java
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook