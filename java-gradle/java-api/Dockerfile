FROM openjdk:8-slim
ADD gradlew gradlew
ADD build.gradle build.gradle
ADD gradle gradle
ADD settings.gradle settings.gradle
RUN ./gradlew build
RUN apt update  -y && apt install -y wget
ADD . .
RUN cd /src/main/java/com/HelloWorld
RUN sed -i '14s/.*/\topts.token = "$ROOKOUT_TOKEN";/' HelloWorld.java
RUN ./gradlew jar
