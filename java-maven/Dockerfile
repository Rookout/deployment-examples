FROM maven:3.6-jdk-8-slim
ADD pom.xml pom.xml
#https://stackoverflow.com/questions/42208442/maven-docker-cache-dependencies
RUN mvn -B -f ./pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
RUN apt update  -y && apt install -y wget
ADD . .
ENV DISABLE_ROOKOUT "true"
ARG NO_CACHE
RUN wget https://sget.rookout.com/rook.jar -O rook.jar
#We dont want to install the maven dep from maven central, so we trick it.
RUN mvn install:install-file -Dfile=/rook.jar -DgroupId=com.rookout -DartifactId=rook -Dversion=0.1.36 -Dpackaging=jar -DgeneratePom=true
RUN mvn package
ENTRYPOINT [ "java" ]
CMD [ "-javaagent:/rook.jar", "-jar", "/target/rookoutDemo-1.0.0.jar"]
