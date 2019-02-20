FROM gradle:jdk8 as builder

COPY . .

COPY --chown=gradle:gradle . /home/gradle

WORKDIR /home/gradle/src

RUN cd /home/gradle && gradle build

FROM lambci/lambda:build-java8

ENV AWS_DEFAULT_REGION us-east-2

COPY --from=builder /home/gradle/build/distributions/aws-lambda-java-1.0-SNAPSHOT.zip .

COPY awsTest.sh /