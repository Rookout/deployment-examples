FROM lambci/lambda:build-java8

WORKDIR /app

ADD . . 

#Add sed for tagging url and setting ROOKOUT_TOKEN from environment variables.
RUN sed -i '10s/.*/    ROOKOUT_TOKEN: '\'$ROOKOUT_TOKEN\''\n    ROOKOUT_DEBUG: "1"\n    ROOKOUT_ROOK_TAGS: "http:\/\/java-aws-elasticbeanstalk"/' .ebextensions/rook.config

RUN zip -r java-elastic-beanstalk.zip . 