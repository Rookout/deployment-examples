# Golang + AWS Lambda Docker Image Example

A sample application for debugging Go + AWS Lambda using a Docker image.

## Rookout Integration Process

First, add the following to your main.go file:
1. Import the GoSDK like so: `rookout "github.com/Rookout/GoSDK"`
2. Add a call to our `rook.Start` at the start of your handler function: `rookout.Start(rookout.RookOptions{})` like so, and add a defer call to our `rookout.Flush` like so: `defer rookout.Flush()`
You can look in `main.go` to see these lines in code.

The Dockerfile requires more changes, so let's look at a before and after:
#### Before
```Docker
FROM golang:1.18-alpine3.15 as builder

WORKDIR /app
ADD . .

RUN go mod download
RUN go mod tidy

RUN go build main.go

FROM alpine:3.15 as release
COPY --from=builder /app/main ./

ENV PORT 1994
EXPOSE 1994
CMD ["./main"]
```

#### After
```Docker
FROM golang:1.18-alpine3.15 as builder

WORKDIR /app
ADD . .

ARG ROOKOUT_TOKEN

RUN apk --update --no-cache add git gcc musl-dev protobuf-dev openssl-libs-static openssl-dev build-base zlib-static

# Change the version here to the newest one
RUN go get -d github.com/Rookout/GoSDK@v0.1.11

RUN go mod download
RUN go mod tidy

RUN go build -tags=alpine314,rookout_static -gcflags='all=-N -l' main.go

FROM alpine:3.15 as release
COPY --from=builder /app/main ./

ENV ROOKOUT_TOKEN=${ROOKOUT_TOKEN}

ENV PORT 1994
EXPOSE 1994
CMD ["./main"]
```

The changes include:
1. Two `go env` commands to properly use the Rookout artifactory.
    * NOTE: Please contact us in order to get the artifactory credentials.
2. The `apk` command to install tools required to build with the Rookout SDK.
3. `go get` to Install the Rookout SDK.
4. Adding `-tags=alpine314,rookout_static -gcflags='all=-N -l'` to the `go build`, this is needed for the Rookout SDK to work.
5. ROOKOUT_TOKEN `ENV` is for convenience, you can add it manually to the Lambda function or pass it in the `RookOptions` variable in `main.go` instead.

### Uploading the Docker
Now after adding those changes (and running `go mod init <name>` if you are creating a new go module) you need to upload the docker to AWS' Elastic Container Registry (ECR) so you could use it as a Lambda function.

For this you need to run four commands:
```bash
aws ecr get-login-password --region <aws_region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<aws_region>.amazonaws.com
docker build . --tag <docker_tag>
docker tag <docker_tag>:latest <aws_account_id>.dkr.ecr.<aws_region>.amazonaws.com/<docker_tag>:latest
docker push <aws_account_id>.dkr.ecr.<aws_region>.amazonaws.com/<docker_tag>
```

aws_region - Your aws region.
aws_account_id - Your account id on AWS.
docker_tag - Just a tag to identify the Docker image you are building.
artifactory_credentials - The credentials needed to get the Rookout SDK from JFrog.
* NOTE: Please contact us in order to get the artifactory credentials.

After running all these commands you should be able to go and create a new AWS Lambda function from a Docker image.
