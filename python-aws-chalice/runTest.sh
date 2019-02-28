#!bin/bash
cd /var/task
declare RESULT=($(chalice deploy)) ; \
for i in “${RESULT[@]}” do echo " " + %i done 
aws lambda update-function-configuration \
            --function-name python_chalice_lambda_regression_test-dev \
            --region us-east-2 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=python_chalice_lambda_regression_test-dev,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}" 
sleep 20
curl ${RESULT[26]}
sleep 450
aws lambda delete-function --region us-east-2 --function-name python_chalice_lambda_regression_test-dev

