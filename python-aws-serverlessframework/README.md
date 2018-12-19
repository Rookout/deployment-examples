# Quickstart for debugging Python + AWS + Serverless Framework

A sample application for debugging Python apps deployed in AWS + Serverless Framework using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout] guide

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Rookout Integration Explained

To integrate Rookout into your existing Serverless Framework Python Lambda app, follow these steps:

1. Add the pip dependency `rook` in the project folder.

1. Set dockerizePip for true in the serverless.yml file in order to allow cross compiling.

1. Add Rookout's decorator to your lambda_handler function.

1. Set your Rookout Token as an environment variables in the serverless.yml file:

- `ROOKOUT_TOKEN` : Your Organization Token

## Rookout Integration Process

We have added Rookout to the original project by:
1. Installing the Rookout SDK (aka "Rook") as a dependency : `pip install rook` 

1. Wrapping our function by using our Rookout lambda decorator as follows:
    ```python
    from rook.serverless import serverless_rook

    @serverless_rook
    def lambda_handler(event, context):
        return 'Hello World'
    ```

1. sls plugin install -n serverless-python-requirements

1. Add to your serverless.yml the serverless-python-requirements plugin:

```
plugins:
  - serverless-python-requirements
```

1. Set your Rookout Token as a Lambda environment variable:

```
environment:
 ROOKOUT_TOKEN:<YOUR_TOKEN>
```

1. Deploy your serverless functions using the serverless framework:

```
serverless deploy 
```

1. Go to [app.rookout.com](https://app.rookout.com) and start debugging!

[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

