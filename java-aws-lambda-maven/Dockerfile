FROM maven:3.6-jdk-8-slim as builder

WORKDIR /app

COPY . .

RUN mvn package

FROM lambci/lambda:build-java8

ENV AWS_DEFAULT_REGION us-east-2

COPY --from=builder /app/target/java-aws-lambda-maven-1.0-SNAPSHOT-jar-with-dependencies.jar .

CMD aws lambda create-function \
            --region us-east-2 \
            --function-name java_aws_lambda_maven_test \
            --zip-file fileb://java-aws-lambda-maven-1.0-SNAPSHOT-jar-with-dependencies.jar \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler TestLambda.TestLambda::handleRequest \
            --runtime java8 \
	    --timeout 25 \
	    --memory-size 400 \
            --environment Variables="{ROOKOUT_TOKEN=${ROOKOUT_TOKEN},ROOKOUT_ROOK_TAGS=lambda}" ; \
            aws lambda invoke --region us-east-2 --function-name java_aws_lambda_maven_test /dev/stdout ; \
            aws lambda delete-function --region us-east-2 --function-name java_aws_lambda_maven_test 