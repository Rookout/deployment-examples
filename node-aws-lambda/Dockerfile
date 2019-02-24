FROM lambci/lambda:build-nodejs8.10 AS builder

WORKDIR /build

ADD awsTest.sh /build
ADD index.js /build
ADD package-lock.json /build 
ADD package.json /build 

RUN npm install

FROM kramos/alpine-zip AS img2

WORKDIR /apps

COPY --from=builder /build /apps

RUN zip -r rookout_lambda_test.zip .

FROM lambci/lambda:build-nodejs8.10 

ENV AWS_DEFAULT_REGION us-east-2

COPY --from=img2 /apps .
