cd /app
aws s3 cp java-aws-tomcat-test.zip s3://java-tomcat-elastic-beanstalk-reg-test

version=$(uuidgen)

aws elasticbeanstalk create-application-version \
                                --application-name regression-tests \
                                --version-label $version \
                                --source-bundle S3Bucket="java-tomcat-elastic-beanstalk-reg-test",S3Key="java-aws-tomcat-test.zip" ; \

aws elasticbeanstalk update-environment \
                            --application-name regression-tests \
                            --environment-name java-tomcat-aws-elasticbeanstalk \
                            --version-label $version \
                            --option-settings Namespace=aws:elasticbeanstalk:application:environment,OptionName=ROOKOUT_TOKEN,Value=$ROOKOUT_TOKEN OptionName=ROOKOUT_ROOK_TAGS,Value="java-tomcat-aws-elasticbeanstalk" OptionName=ROOKOUT_DEBUG,Value=1
