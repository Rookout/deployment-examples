# Rookout AWS Lambda Python Deployment

Pre-requisite:
[AWS SAM cli](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) is installed and an amazon account is configured.

### Step 1:
Update your S3 bucket inside `samconfig.toml`.

### Step 2:
```sam build --region=[YOUR REGION NAME]```

### Step 3:
```sam deploy --guided``` and follow the guided deployment.