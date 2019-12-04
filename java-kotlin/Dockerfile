FROM openjdk:8-slim
RUN mkdir /proj
ADD gradlew /proj/gradlew
ADD build.gradle /proj/build.gradle
ADD gradle /proj/gradle
ADD settings.gradle /proj/settings.gradle
RUN /proj/gradlew build
RUN apt update  -y && apt install -y wget
ADD . /proj
WORKDIR /proj
RUN ./gradlew jar

