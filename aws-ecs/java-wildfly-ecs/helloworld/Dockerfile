FROM jboss/wildfly:8.2.1.Final
ADD target/wildfly-helloworld.war /opt/jboss/wildfly/standalone/deployments/
ADD --chown=jboss:jboss http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST /opt/jboss/wildfly/lib/rook.jar
ADD rookout-conf/standalone.conf /opt/jboss/wildfly/bin/
EXPOSE 8080