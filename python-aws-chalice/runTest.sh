#!/bin/bash
cd /var/task
echo "Updating reg-test chalice config.json and replacing the original config.json"
sed -i-E "s/ROOKOUT_TOKEN_GOES_HERE/$ROOKOUT_TOKEN/g" .chalice/config-reg-test.json
echo "Printing config-reg-test.json"
cat .chalice/config-reg-test.json
mv .chalice/config-reg-test.json .chalice/config.json
echo "Printing configjson"
cat .chalice/config.json
echo "Deploying the lambda, and update with envs" 
RESULT=$(chalice deploy) ; echo $RESULT ;
echo "Fetching URL to trigger"
URL=$(echo $RESULT | grep -oE 'Rest API URL: (.+\/api\/)' | cut -d\  -f4)
echo "URL_TO_TRIGGER -- START"
echo $URL
echo "URL_TO_TRIGGER -- END"
echo "Sleeping for 240 seconds more"
sleep 240
echo "Trying to get logs" 
chalice logs --name index
chalice logs --name python_chalice_lambda_regression_test-dev
echo "Deleting the stage"
chalice delete --stage dev
echo "DONEEE"
