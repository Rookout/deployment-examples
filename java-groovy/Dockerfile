FROM groovy:2.5.1-jdk8

USER root

RUN wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST" -O /home/groovy/rook.jar
RUN chmod 777 /home/groovy/rook.jar
ADD test_groovy.groovy /home/groovy/

ENV JAVA_OPTS=-javaagent:/home/groovy/rook.jar

RUN groovy /home/groovy/test_groovy.groovy