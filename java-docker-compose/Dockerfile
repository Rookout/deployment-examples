FROM maven:3.5.2-jdk-8-alpine

WORKDIR /code

RUN mkdir -p /usr/src/app/target/
WORKDIR /usr/src/app

# Copy the jar image (which already include resoures)
COPY target/rookoutDemo-1.0.0.jar  /usr/src/app/target/rookoutDemo-1.0.0.jar
#Download the Rookout agent jar
RUN   apk update \
  &&   apk add ca-certificates wget \
  &&   update-ca-certificates
RUN wget "http://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.rookout&a=rook&v=LATEST"  -O rook.jar
