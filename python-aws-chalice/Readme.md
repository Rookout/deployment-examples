# Quickstart for debugging Python + AWS Lambda + Chalice

A sample application for debugging Python apps deployed in AWS Chalice using Rookout.

Before following this guide we recommend reading the basic [Python + Lambda debugging guide](https://github.com/Rookout/deployment-examples/blob/master/python-aws-lambda/README.md).

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

This example is based on a plain Chalice app, with the following modifications applied:

1. Set your Rookout token as an environment variable in `.chalice/config.json`:

```json
"environment_variables": {
    "ROOKOUT_TOKEN": "<token>"
  }
```

2. Add the `rook` SDK dependancy to your `requirements.txt` Chalice file.

3. Initialize your Chalice app using `RookoutChalice` :

```python
from rook.serverless import RookoutChalice

app = RookoutChalice(app_name='python-aws-chalice')
```

4. Go to [app.rookout.com](https://app.rookout.com) and start debugging!