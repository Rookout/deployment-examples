cd /app 

sls deploy --force

aws lambda update-function-configuration \
            --function-name python-aws-serverless-reg-test-dev-hello \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=python-aws-serverless-reg-test-dev-hello,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}"