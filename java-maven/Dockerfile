FROM maven:3.6-jdk-8-slim
ADD pom.xml pom.xml
#https://stackoverflow.com/questions/42208442/maven-docker-cache-dependencies
RUN mvn -B -f ./pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
RUN apt update  -y && apt install -y wget
ADD . .
RUN mvn package
ENTRYPOINT [ "java" ]
CMD [ "-javaagent:/rook.jar", "-jar", "/target/rookoutDemo-1.0.0-jar-with-dependencies.jar"]
