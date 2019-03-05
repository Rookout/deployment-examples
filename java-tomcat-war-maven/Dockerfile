FROM maven:3.5.2-jdk-8-alpine AS SAMPLE_LIB
COPY SampleLib/pom.xml /tmp/
COPY SampleLib/src /tmp/src/
WORKDIR /tmp/
RUN mvn package



FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY sample/pom.xml /tmp/
COPY sample/src /tmp/src/
COPY --from=SAMPLE_LIB /tmp/target/sample-lib-1.0-SNAPSHOT.jar /tmp/src/main/webapp/WEB-INF/lib/
WORKDIR /tmp/
RUN mvn package

FROM tomcat:8
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/sample.war $CATALINA_HOME/webapps/

ADD --chown=root:root http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST $CATALINA_HOME/rook.jar

EXPOSE 8080
CMD ["/bin/bash", "-c", "CATALINA_OPTS=\"$CATALINA_OPTS -javaagent:$CATALINA_HOME/rook.jar\" catalina.sh run"]

