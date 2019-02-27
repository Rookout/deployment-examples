FROM lambci/lambda:build-python2.7
 
WORKDIR /app

ADD . .

# Install app dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install 'chalice == 1.7.0'

ADD . .

RUN sed -i '5s/.*/    "ROOKOUT_TOKEN": "process.env.ROOKOUT_TOKEN",\n    "ROOKOUT_ROOK_TAGS": "python_chalice_lambda_regression_test",\n    "ROOKOUT_DEBUG": "1"/' .chalice/config.json

RUN sed -i '15s/.*/  "app_name": "python_chalice_lambda_regression_test"/' .chalice/config.json

# RUN chalice deploy

#TODO - add to jenkinsfile URL = python-aws-chalice 