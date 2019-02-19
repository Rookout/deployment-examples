# FROM python:2.7-stretch AS builder

# COPY . .

# RUN pip install rook -t .

FROM python:2.7-stretch AS img1

WORKDIR /app

ADD . /app
RUN set -xe \
    && apt-get -y update \
    && apt-get -y install python-pip

RUN pip install --upgrade pip

RUN pip install rook -t .

FROM kramos/alpine-zip AS img2

WORKDIR /apps

COPY --from=img1 /app /apps

RUN zip -r rookout_lambda_test.zip .

FROM lambci/lambda:python2.7

COPY --from=img2 /apps/rookout_lambda_test.zip .

CMD aws lambda create-function \
            --region us-east-2 \
            --function-name regression_test_python_lambda \
            --zip-file fileb://rookout_lambda_test.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler lambda_function.lambda_handler \
            --runtime python2.7 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=lambda}" \
            --timeout 25 \
            --memory-size 400 ; \
            aws lambda invoke --region us-east-2 --function-name regression_test_python_lambda /dev/stdout ; \
            aws lambda delete-function --region us-east-2 --function-name regression_test_python_lambda