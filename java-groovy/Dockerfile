FROM groovy:2.5.1-jdk8

USER root

RUN wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST" -O /opt/groovy/bin/rook.jar
RUN chmod 777 /opt/groovy/bin/rook.jar
ADD test_groovy.groovy /home/groovy/

ENV JAVA_OPTS=-javaagent:/opt/groovy/bin/rook.jar

ENV ROOKOUT_AGENT_HOST=cloud.agent.rookout.com
ENV ROOKOUT_AGENT_PORT=443
ENV ROOKOUT_TOKEN=INSERT_TOKEN_HERE