# Quickstart Debugging Scala-Spark app using Rookout

A sample application for debugging a Scala app using Rookout.

## Integrate Rookout into your Scala application

To integrate Rookout into your existing Scala application, follow these steps:

1. [Download the Rookout Java Agent](http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST)

2. Set your Rookout Token as the `ROOKOUT_TOKEN` environment variable.

3. Add your sources to your jar by adding the following line to your main `build.sbt` file:
```bash
resourceDirectory in Compile := sourceDirectory.value
```
4. Pack your app.

5. Run your app:
	spark-submit \
  --class "SimpleApp" \
  --master local \
  --driver-java-options "-javaagent:PATH-TO-ROOK.JAR" YOUR_APP.JAR
```


Go to [app.rookout.com](https://app.rookout.com) and start debugging !

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
