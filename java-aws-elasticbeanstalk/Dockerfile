FROM lambci/lambda:java8

ADD . . 

RUN sed -i '10s/.*/    ROOKOUT_TOKEN: '$ROOKOUT_TOKEN'\n    ROOKOUT_DEBUG: '1'\n    ROOKOUT_ROOK_TAGS: 'http://java-aws-elasticbeanstalk'/' .ebextensions/rook.config