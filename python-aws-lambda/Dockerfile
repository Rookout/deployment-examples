# FROM python:2.7-stretch AS builder

# COPY . .

# RUN pip install rook -t .

FROM python:2.7-stretch AS img1

WORKDIR /app

COPY . /app
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