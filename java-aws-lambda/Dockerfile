FROM gradle:jdk8 as builder

COPY . .

COPY --chown=gradle:gradle . /home/gradle

WORKDIR /home/gradle/src

RUN cd /home/gradle && gradle build

RUN cd ../../

FROM lambci/lambda:build-java8

ENV AWS_DEFAULT_REGION us-east-2

COPY --from=builder /home/gradle/build/distributions/aws-lambda-java-1.0-SNAPSHOT.zip .

COPY awsTest.sh .

CMD aws lambda create-function \
            --region us-east-2 \
            --function-name java_aws_lambda_test \
            --zip-file fileb://aws-lambda-java-1.0-SNAPSHOT.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler TestLambda.TestLambda::handleRequest \
            --runtime java8 \
	    --timeout 25 \
	    --memory-size 400 \
            --environment Variables="{ROOKOUT_TOKEN=${ROOKOUT_TOKEN},ROOKOUT_ROOK_TAGS=lambda}" ; \
            aws lambda invoke --region us-east-2 --function-name java_aws_lambda_test /dev/stdout ; \
            aws lambda delete-function --region us-east-2 --function-name java_aws_lambda_test 