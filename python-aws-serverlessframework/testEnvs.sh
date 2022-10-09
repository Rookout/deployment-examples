cd /app

sls deploy --force

sls package --package /tmp/pkg

aws lambda update-function-code --function-name python-aws-serverless-reg-test-dev-hello \
            --zip-file fileb:/tmp/pkg/python-aws-serverless-reg-test.zip

aws lambda update-function-configuration \
            --function-name python-aws-serverless-reg-test-dev-hello \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_LABELS=regression_test:python-aws-serverless-reg-test-dev-hello,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}"

