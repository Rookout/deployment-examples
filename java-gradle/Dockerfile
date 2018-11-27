FROM openjdk:8-slim
ADD gradlew gradlew
ADD build.gradle build.gradle
ADD gradle gradle
ADD settings.gradle settings.gradle
RUN ./gradlew build
ADD . .
RUN ./gradlew jar
ENTRYPOINT ["/gradlew"]
CMD []

