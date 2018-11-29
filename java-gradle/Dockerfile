FROM openjdk:8-slim
ADD gradlew gradlew
ADD build.gradle build.gradle
ADD gradle gradle
ADD settings.gradle settings.gradle
RUN ./gradlew build
RUN apt update  -y && apt install -y wget 
ADD . .
RUN ./gradlew jar
ENV DISABLE_ROOKOUT "true"
ARG NO_CACHE
RUN wget https://sget.rookout.com/rook.jar -O rook.jar #redo
ENV JAVA_OPTS "-javaagent:/rook.jar"
ENTRYPOINT [ "/gradlew" ]
CMD [ "jar", "run",   "--project-dir=/"  ]
