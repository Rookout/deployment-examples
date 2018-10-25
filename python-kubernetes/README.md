# Quickstart for debugging Kubernetes deployments

This is a full example for deploying Rookout using Kubernetes.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## prerequisite:

1. Get your Rookout token at [app.rookout.com](https://app.rookout.com).

2. Make sure you have a running kubernetes cluster and kubectl.

## Installation

1. `git clone https://github.com/rookout/deployment-examples.git`

2. `cd python-kubernetes`

3. Set your own Rookout toeen in `agent-deployment.yaml`

3. `kubectl apply -f agent-deployment.yaml`

4. `kubectl apply -f agent-service.yaml`

3. `kubectl apply -f app-deployment.yaml`

4. `kubectl apply -f app-service.yaml`

5. Access the external IP received for the hello-world service in port 80

6. Go to [app.rookout.com](https://app.rookout.com) and start debugging !

## License

MIT
