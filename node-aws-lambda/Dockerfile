FROM lambci/lambda:build-nodejs8.10 AS builder

COPY . .

RUN npm install

WORKDIR /build

ADD /node_modules /build
ADD awsTest.sh /build
ADD index.js /build
ADD package-lock.json /build 
ADD package.json /build 

FROM kramos/alpine-zip AS img2

WORKDIR /apps

COPY --from=builder /build /apps

RUN zip -r rookout_lambda_test.zip /apps

FROM lambci/lambda:build-nodejs8.10 

ENV AWS_DEFAULT_REGION us-east-2

COPY --from=img2 /apps .

# docker build -t mylambda .
# docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY mylambda