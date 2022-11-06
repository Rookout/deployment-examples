aws s3 cp /app/java-elastic-beanstalk.zip s3://java-elastic-beanstalk-regression-test

version=$(uuidgen)

aws elasticbeanstalk create-application-version \
                                --application-name regression-tests \
                                --version-label $version \
                                --source-bundle S3Bucket="java-elastic-beanstalk-regression-test",S3Key="java-elastic-beanstalk.zip" ; \

aws elasticbeanstalk update-environment \
                            --application-name regression-tests \
                            --environment-name java-aws-elasticbeanstalk \
                            --version-label $version \
                            --option-settings \
                            Namespace=aws:elasticbeanstalk:application:environment,OptionName=ROOKOUT_TOKEN,Value=$ROOKOUT_TOKEN \
                            Namespace=aws:elasticbeanstalk:application:environment,OptionName=ROOKOUT_LABELS,Value=$LABELS \
                            Namespace=aws:elasticbeanstalk:application:environment,OptionName=ROOKOUT_DEBUG,Value=1
