aws lambda create-function \
            --region us-east-2 \
            --function-name regression_test_python_lambda \
            --zip-file fileb:///rookout_lambda_test.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler lambda_function.lambda_handler \
            --runtime python2.7 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=lambda,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}" \
            --timeout 25 \
            --memory-size 400 \
            sleep 60 ; \
for run in {1..5}
do
  aws lambda invoke --region us-east-2 --function-name regression_test_python_lambda /dev/stdout ; \
done
aws lambda delete-function --region us-east-2 --function-name regression_test_python_lambda