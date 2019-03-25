cd /app

sls deploy --force

aws lambda update-function-configuration \
            --function-name node-serverless-regression-test-dev-example \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=node-serverless-regression-test-dev-example,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}"
