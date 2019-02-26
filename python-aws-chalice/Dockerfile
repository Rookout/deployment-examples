FROM lambci/lambda:build-python2.7 AS img1
 
WORKDIR /app

ADD . .

# Install app dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install 'chalice == 0.0.1'

ADD . .

RUN sed -i '5s/.*/    "ROOKOUT_TOKEN": "$ROOKOUT_TOKEN"/' .chalice/config.json

RUN sed -i '13s/.*/  "app_name": "python-aws-chalice","region": "us-east-2"/' .chalice/config.json

RUN chalice deploy
#TODO - add to jenkinsfile URL = python-aws-chalice 