cd /app

sls deploy

aws lambda update-function-configuration \
            --function-name node-serverless-regression-test-dev \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=node-serverless-regression-test-dev,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}"
