# Quickstart for debugging Kubernetes deployments

This is a full example for deploying an application with Rookout using Kubernetes.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

## prerequisite:

1. Get your Rookout token at [app.rookout.com](https://app.rookout.com).

1. Make sure you have a running kubernetes cluster and kubectl.

## Installation

1. Clone the repository `git clone https://github.com/rookout/deployment-examples.git`

1. Go to this example directory `cd python-kubernetes`

1. Create a kubernetes secret for your ROOKOUT_TOKEN: `kubectl create secret generic rookout --from-literal=token=<Your-Rookout-Token>`

1. Deploy the demo application `kubectl apply -f app-deployment.yaml -f app-service.yaml`

1. Access the external IP received for the app service in port 80 `kubectl get svc rookout-demo-app-service`

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging !

**Check out https://github.com/Rookout/tutorial-python to see how to use the demo application**

## License

MIT
