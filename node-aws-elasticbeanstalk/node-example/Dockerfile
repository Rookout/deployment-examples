FROM lambci/lambda:build-nodejs12.x AS img1

WORKDIR /build

COPY . . 

RUN npm install

FROM alpine:latest as img2

RUN apk add --update zip

WORKDIR /apps

COPY --from=img1 /build /apps

RUN zip -r node_aws_elastic_beanstalk.zip .

FROM lambci/lambda:build-nodejs12.x

COPY --from=img2 /apps /