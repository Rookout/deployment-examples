FROM golang:1.18-alpine3.15 as builder

WORKDIR /app
ADD . .

ARG ROOKOUT_TOKEN
ARG ARTIFACTORY_CREDS

RUN go env -w GONOSUMDB="github.com/Rookout/GoSDK"
RUN go env -w GOPROXY="https://proxy.golang.org,https://${ARTIFACTORY_CREDS}@rookout.jfrog.io/artifactory/api/go/rookout-go,direct"

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