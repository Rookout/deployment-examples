# Golang + AWS Lambda Docker Image Example

A sample application for debugging Go + AWS Lambda using a compiled Go binary.

## Rookout Integration Process

### main.go
First, add the following to your main.go file:
1. Import the GoSDK like so: `rookout "github.com/Rookout/GoSDK"`
2. Add a call to our `rookout.Start` at the start of your handler function: `rookout.Start(rookout.RookOptions{})` like so, and add a defer call to our `rookout.Flush` like so: `defer rookout.Flush()`
You can look in `main.go` to see these lines in code.

### Dockerfile
Now we need to compile the code with the GoSDK, for that we'll just use a Docker.
Use this Dockerfile to compile your code (don't forget to add files to the `go build` command if you need to).

### Creating the Function
After adding the Dockerfile we need to run it to get the binary:
`docker build .`

artifactory_credentials - The credentials needed to get the GoRook from JFrog.
* NOTE: Please contact us in order to get the artifactory credentials.

Now you should have a binary `main` file in the folder, all we need to do is zip it and create the function.
* NOTE: If you don't have the binary, rerun the last step but add `DOCKER_BUILDKIT=1` before the command.
To zip it run: `zip go_lambda.zip main`
To create the function:
```bash
aws lambda create-function \
            --region <REGION> \
            --function-name <FUNCTION_NAME> \
            --zip-file fileb://go_lambda.zip \
            --role <ROLE-ARN> \
            --handler main \
            --runtime go1.x \
            --environment Variables="{ROOKOUT_TOKEN=<org_token>}" \
            --timeout 25
```

That's it, you should now have a new AWS Lambda Go function.
