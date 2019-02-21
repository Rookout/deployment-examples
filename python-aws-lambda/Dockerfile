# FROM python:2.7-stretch AS builder

# COPY . .

# RUN pip install rook -t .

FROM ubuntu AS img1

WORKDIR /app

# Update
RUN apt-get update
RUN apt-get install -y python 
RUN apt-get install -y python-pip
 
# Install app dependencies
RUN pip install --upgrade pip
RUN pip install rook -t .

FROM kramos/alpine-zip AS img2

WORKDIR /apps

COPY --from=img1 /app /apps

RUN zip -r rookout_lambda_test.zip .

FROM lambci/lambda:python2.7

ENV AWS_DEFAULT_REGION us-east-2

USER root

ADD awsTest.sh .

COPY --from=img2 /apps/rookout_lambda_test.zip .