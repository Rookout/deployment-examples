# Quickstart for debugging Java Tomcat + AWS Elastic Beanstalk 

A sample application for debugging Java Tomcat + AWS Elastic Beanstalk using Rookout.

Before following this guide we recommend reading the basic [Java + Rookout] guide.

This sample application is the Tomcat sample app provided by AWS.
For more information about the project structure and how to use it refer to [this page](https://github.com/Rookout/deployment-examples/tree/master/aws-beanstalk/java-tomcat-elasticbeanstalk/eb-tomcat-helloworld/README.md).

## Adding Rookout to an existing EBS Project

To integrate Rookout into your existing java beanstalk application follow these steps:

1. Add the source files to your built .jar/.war

2. Add these [.ebextensions standalone config scripts](.ebextensions) to your project configuration(.ebextensions)
    * Sets up the Rookout ETL Agent, responsible for communicating with the Rookout service.
__The process is described here : [Rookout Integration Process](#rookout-integration-process)__

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

1. Adding Rookout's Elastic Beanstalk .ebextensions to install Rook:
    ```
    files:
        "/opt/elasticbeanstalk/lib/rook.jar" :
            mode: "000444"
            owner: root
            group: root
            source: "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"
    ```
2. Adding Rookout's token to elastic beasntalk environment variables and add the Java Agent to communicate with the app:
```
  - namespace:  aws:elasticbeanstalk:container:tomcat:jvmoptions
    option_name:  JVM Options
    value:  '-javaagent:/opt/elasticbeanstalk/lib/rook.jar'
  - namespace:  aws:elasticbeanstalk:container:tomcat:jvmoptions
    option_name:  JVM Options
    value:  '-javaagent:/opt/elasticbeanstalk/lib/rook.jar'
  - namespace: aws:elasticbeanstalk:application:environment
    option_name: ROOKOUT_TOKEN
    value: '<your-token>'
    
```

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
