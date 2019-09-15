FROM maven:3.5.2-jdk-8-alpine AS SAMPLE_LIB
COPY SampleLib/pom.xml /tmp/
COPY SampleLib/src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM jetty:latest
USER root

COPY --from=SAMPLE_LIB /tmp/target/jetty-helloworld.war /var/lib/jetty/webapps/
RUN echo '--exec \n-javaagent:/home/jenkins/agent/rook.jar' >> /var/lib/jetty/start.d/server.ini

CMD ["java","-jar","/usr/local/jetty/start.jar"]

