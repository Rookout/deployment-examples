aws lambda create-function \
            --region us-east-2 \
            --function-name node_aws_lambda_regression_test \
            --zip-file fileb:///var/task/rookout_lambda_test.zip \
            --role arn:aws:iam::032275105219:role/rookout-lambda-role \
            --handler index.handler \
            --runtime nodejs8.10 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=lambda,ROOKOUT_LOG_TO_STDERR=1}" \
            --timeout 25 ; \
for run in {1..5}
do
  aws lambda invoke --region us-east-2 --function-name node_aws_lambda_regression_test /dev/stdout ; \
done
aws lambda delete-function --region us-east-2 --function-name node_aws_lambda_regression_test