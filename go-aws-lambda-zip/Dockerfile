FROM golang:1.18-alpine3.15 as builder

WORKDIR /app
ADD . .

RUN apk --update --no-cache add git gcc musl-dev protobuf-dev openssl-libs-static openssl-dev build-base zlib-static

# Change the version here to the newest one
RUN go get -d github.com/Rookout/GoSDK@v0.1.11

RUN go mod download
RUN go mod tidy

RUN go build -tags=alpine314,rookout_static -gcflags='all=-N -l' main.go

FROM scratch as release
COPY --from=builder /app/main ./
