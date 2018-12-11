# Quickstart for debugging Java Tomcat + AWS Elastic Beanstalk 

A sample application for debugging Java Tomcat + AWS Elastic Beanstalk using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

This sample application is the Tomcat sample app provided by AWS.
For more information about the project structure and how to use it refer to [this page](https://github.com/Rookout/deployment-examples/tree/master/aws-beanstalk/java-tomcat-elasticbeanstalk/eb-tomcat-helloworld/README.md).

## Adding Rookout to an existing EBS Project

To integrate Rookout into your existing java beanstalk application follow these steps:

1. Add the source files to your built .jar/.war

2. Add these [.ebextensions standalone config scripts](.ebextensions) to your project configuration(.ebextensions)
    * One sets up the Rookout SDK (aka "Rook"), responsible for communicating with the Rookout service.
    * The other sets up and runs the Rookout Java Agent.

__The process is described here : [Rookout Integration Process](#rookout-integration-process)__


## Running locally
__NOTE: This sample project requires Tomcat8__

Run the Rookout Java Agent:
    ~$ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent

Run ``make local`` to add the Rookout Java Agent to Tomcat environment locally.

Run ``build.sh`` to compile the web app and create a WAR file (OS X or Linux):

	~/eb-tomcat-helloworld$ ./build.sh

**IMPORTANT**
Always run build.sh from the root of the project directory.

The script compiles the project's classes, packs the necessary files into a web archive, and then attempts to copy the WAR file to ``/Library/Tomcat`` for local testing. If you installed Tomcat to another location, change the path in ``build.sh`` and in the Makefile:

	if [ -d "/path/to/Tomcat/webapps" ]; then
	  cp ROOT.war /path/to/Tomcat/webapps

Open [http://localhost:8080/?name=rookout](http://localhost:8080/?name=rookout) in a web browser to view the application running locally.
Try to change the query parameter "name" - /?name=rookout, /?name=John

**Finally** Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Deploying on AWS Elastic Beanstalk

You can use either the AWS Management Console or the EB CLI to launch the compiled WAR. Scroll down for EB CLI instructions.

##### To deploy with the AWS Management Console
1. Open the [Elastic Beanstalk Management Console](https://console.aws.amazon.com/elasticbeanstalk/home).

2. Upload the source (ROOT.war) bundle when creating a [new Beanstalk app](https://console.aws.amazon.com/elasticbeanstalk/home#/gettingStarted).

3. Choose 'Tomcat' Platform.

4. Make sure everything worked by accessing the url provided by Elastic Beanstalk after build completed.

5. Change the "name" query parameter to see changes - /?name=rookout, /?name=John

6. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Rookout Integration Process
We have added Rookout to the original project by:
1. Adding the source files to the project .war when building (we added the 'com' folder here):
    
    ~$ jar -cf ROOT.war WEB-INF .ebextensions/* com

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

[Java + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
