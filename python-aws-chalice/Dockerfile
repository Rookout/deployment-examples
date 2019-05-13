FROM lambci/lambda:build-python2.7
 
ADD . .

# Install app dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install 'chalice == 1.7.0'

RUN sed -i '11s/.*/  "app_name": "python_chalice_lambda_regression_test"/' .chalice/config.json
