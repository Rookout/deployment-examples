# Kubernetes Rookout Deployment Example

This is a full example for deploying Rookout using Kubernetes

## prerequisite:

1. `Have a rookout token`

2. `Have a running kubernetes cluster and kubectl`

## Installation

1. `git clone https://github.com/rookout/deployment-examples.git`

2. `cd python-kubernetes`

3. change the token inside `agent-deployment.yaml` with your token

3. `kubectl apply -f agent-deployment.yaml`

4. `kubectl apply -f agent-service.yaml`

3. `kubectl apply -f app-deployment.yaml`

4. `kubectl apply -f app-service.yaml`

5. http://localhost:8888/

6. Send a REST call:


## License

MIT
