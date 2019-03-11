FROM lambci/lambda:build-java8

WORKDIR /app

ADD . . 

#Add sed for Deleting ROOKOUT_TOKEN line.
RUN sed -i '10s/.*//' .ebextensions/rook.config

RUN zip -r java-elastic-beanstalk.zip . 