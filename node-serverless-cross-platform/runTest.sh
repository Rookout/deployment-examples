sls deploy

aws lambda update-function-configuration \
            --function-name serverless-app-dev-hello \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=python-aws-serverlessframework-regression-test-dev-hello,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}"