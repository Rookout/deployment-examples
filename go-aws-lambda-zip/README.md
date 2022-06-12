# Golang + AWS Lambda Docker Image Example

A sample application for debugging Go + AWS Lambda using a docker image.

## Rookout Integration Process

### main.go
Let's first change your main go file, there are 2 changes:
1. Import the GoSDK like so: `rook "github.com/Rookout/GoSDK"`
2. Add a call to our `rook.Start` at the start of your handler function: `rook.Start(rook.RookOptions{})` like so, and add a defer call to our `rook.Flush` like so: `defer rook.Flush()`
You can look in `main.go` to see these lines in code.

### Dockerfile
Now we need to compile the code with the GoSDK, for that we'll just use a docker.
Use this Dockerfile to compile your code (don't forget to add files to the `go build` command if you need to).

### Creating the Function
After adding the Dockerfile we need to run it to get the binary:
`docker build . --build-arg ARTIFACTORY_CREDS=<artifactory_credentials> --output .`

artifactory_credentials - The credentials needed to get the GoRook from jfrog.
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
