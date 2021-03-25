# Quickstart for Dataflow + Google Cloud Platform

A sample application for using Rookout API to debug a Java app built using Maven.

Before following this guide we recommend completing the basic [Java + Rookout tutorial](https://github.com/Rookout/tutorial-java).

## Rookout Integration explained

This example is based of the Java word-count-beam example available [here].

1. Add your sources to the package:
    ```xml
    <resources>
        <resource>
           <directory>${basedir}/src/main/java</directory>
        </resource>
    </resources>
    ```

2. We imported Rookout packages and the Google services API to the project jar(`pom.xml`):
    ```xml
        <dependency>
            <groupId>com.rookout</groupId>
           <artifactId>rook</artifactId>
           <version>LATEST</version>
        </dependency>
        
        <dependency>
           <groupId>com.sun</groupId>
           <artifactId>tools</artifactId>
           <version>1.7.0.13</version>
        </dependency>
        
        <dependency>
           <groupId>com.google.auto.service</groupId>
           <artifactId>auto-service</artifactId>
           <version>1.0-rc6</version>
        </dependency>
    ```
   
3. Add nuiton repository to your repositories section:
    ```xml
        <repository>
            <id>nuiton</id>
            <name>nuiton</name>
            <url>http://maven.nuiton.org/release/</url>
        </repository> 
   ```
4. Adding the RookoutJvmInitializer class to your solution
    ```java
    package <YOUR-PACKAGE>;
   
    import com.rookout.rook.API;
    import com.rookout.rook.RookOptions;
    import org.apache.beam.sdk.harness.JvmInitializer;
    import org.apache.beam.sdk.options.PipelineOptions;
    import com.google.auto.service.AutoService;
    import java.util.HashMap;

    @AutoService(JvmInitializer.class)
    public class RookoutJvmInitializer implements JvmInitializer {
        @Override
        public void beforeProcessing(PipelineOptions options) {
            RookOptions opts = new RookOptions();
            opts.token = "<YOUR-TOKEN>";
            opts.labels = new HashMap<String, String>() {{
                put("env", "prod");
            }};
            API.start(opts);
        }
    }
    ```

5. Deploy your app and go to [http://app.rookout.com](http://app.rookout.com) and start debugging!

[Java + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
[here]: https://beam.apache.org/get-started/wordcount-example/
[maven central]: https://mvnrepository.com/artifact/com.rookout/rook
