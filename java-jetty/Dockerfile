FROM maven:3.5.2-jdk-8-alpine AS SAMPLE_LIB
COPY SampleLib/pom.xml /tmp/
COPY SampleLib/src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM jetty:latest

COPY --from=SAMPLE_LIB /tmp/target/jetty-helloworld.war /var/lib/jetty/webapps/
#RUN echo '--exec \n-javaagent:/var/lib/jetty/rook.jar' >> /var/lib/jetty/start.d/server.ini
ADD --chown=jetty:jetty http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST /var/lib/jetty/rook.jar
USER root
RUN chown -R 10000:10000 /var

USER 10000
EXPOSE 8080
CMD ["java","-jar","/usr/local/jetty/start.jar"]

