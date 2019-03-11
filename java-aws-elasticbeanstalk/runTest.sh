aws s3 cp /app/java-elastic-beanstalk.zip s3://java-elastic-beanstalk-regression-test ; \
now="$(date +'%d-%m-%Y-%H:%M:%S')" ; \
aws elasticbeanstalk create-application-version --application-name regression-tests --version-label $now --source-bundle S3Bucket="java-elastic-beanstalk-regression-test",S3Key="java-elastic-beanstalk.zip" ; \
aws elasticbeanstalk update-environment --application-name regression-tests --environment-name java-aws-elasticbeanstalk --version-label $now --option-settings file:///app/options.json ; \
sleep 40 ; \
curl http://java-aws-elasticbeanstalk.us-east-2.elasticbeanstalk.com/