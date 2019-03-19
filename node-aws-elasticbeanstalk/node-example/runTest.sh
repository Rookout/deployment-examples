aws s3 cp /node_aws_elastic_beanstalk.zip s3://node-aws-elasticbeanstalk-reg-test

version=$(uuidgen)

aws elasticbeanstalk create-application-version \
                                --application-name regression-tests \
                                --version-label $version \
                                --source-bundle S3Bucket="node-aws-elasticbeanstalk-reg-test",S3Key="node_aws_elastic_beanstalk.zip" ; \

aws elasticbeanstalk update-environment \
                            --application-name regression-tests \
                            --environment-name node-aws-elasticbeanstalk \
                            --version-label $version \
                            --option-settings Namespace=aws:elasticbeanstalk:application:environment,OptionName=ROOKOUT_TOKEN,Value=$ROOKOUT_TOKEN,OptionName=ROOKOUT_ROOK_TAGS,Value="node-aws-elasticbeanstalk",OptionName=ROOKOUT_DEBUG,Value=1,OptionName=PORT,Value=8081