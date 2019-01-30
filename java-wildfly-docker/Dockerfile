

FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY helloworld/pom.xml /tmp/
COPY helloworld/src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM jboss/wildfly:8.2.1.Final
USER root
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/wildfly-helloworld.war /opt/jboss/wildfly/standalone/deployments/
ADD --chown=root:root helloworld/rookout /var/log/rookout
ADD --chown=root:root http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST /opt/jboss/wildfly/lib/rook.jar
ADD helloworld/rookout-conf/standalone.conf /opt/jboss/wildfly/bin/
EXPOSE 8080
RUN chmod +x /opt/jboss/wildfly/bin/standalone.sh