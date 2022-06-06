package main

import (
	"context"
	"encoding/json"
	"time"

	rook "github.com/Rookout/GoSDK"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type response struct {
	UTC time.Time `json:"utc"`
}

func handleRequest(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	rook.Start(rook.RookOptions{})
	defer rook.Flush()

	now := time.Now()
	resp := &response{
		UTC: now.UTC(),
	}
	body, err := json.Marshal(resp)
	if err != nil {
		return events.APIGatewayProxyResponse{}, err
	}
	return events.APIGatewayProxyResponse{Body: string(body), StatusCode: 200}, nil
}

func main() {
	lambda.Start(handleRequest)
}
