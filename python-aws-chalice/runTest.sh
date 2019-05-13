#!bin/bash
cd /var/task
echo "Deploying the lambda, and update with envs" 
RESULT=$(chalice deploy) ; echo $RESULT ; \
echo "Sleeping for 10 secs"
sleep 10
aws lambda update-function-configuration \
            --function-name python_chalice_lambda_regression_test-dev \
            --region us-east-2 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=python_chalice_lambda_regression_test-dev,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}" 
echo "Sleeping for 10 secs"
sleep 10
echo "Fetching URL to trigger"
URL=$(echo $RESULT | grep -oE 'Rest API URL: (.+\/api\/)' | cut -d\  -f4)
echo "URL_TO_TRIGGER -- START"
echo $URL
echo "URL_TO_TRIGGER -- END"
echo "Sleeping for 90 seconds more"
sleep 90
echo "Trying to get logs" 
chalice logs  --name index
chalice logs  --name python_chalice_lambda_regression_test-dev
echo "Deleting the stage"
chalice delete --stage dev
echo "DONEEE"
