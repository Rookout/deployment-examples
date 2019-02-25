FROM lambci/lambda:build-python2.7 AS img1

# # Update
# RUN apt-get update
# RUN apt-get install -y python 
# RUN apt-get install -y python-pip
 
WORKDIR /app

ADD . . 

# Install app dependencies
RUN pip install --upgrade pip
RUN pip install rook -t .

FROM kramos/alpine-zip AS img2

RUN apk add --update zip

WORKDIR /build

COPY --from=img1 /app /build

RUN zip -r rookout_lambda_test.zip .

FROM lambci/lambda:build-python2.7

USER root 

ENV AWS_DEFAULT_REGION us-east-2

ADD awsTest.sh ../../

COPY --from=img2 /build/rookout_lambda_test.zip ../../

ENTRYPOINT ["/bin/bash"]