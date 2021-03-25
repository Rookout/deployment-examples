# Quickstart for debugging Python + AWS Lambda + Chalice

A sample application for debugging Python apps deployed in AWS Chalice using Rookout.

Before following this guide we recommend completing the basic [Python + Rookout tutorial](https://github.com/Rookout/tutorial-python) and reading the [Python + Lambda debugging guide](https://github.com/Rookout/deployment-examples/blob/master/python-aws-lambda/README.md).

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

You may also pass parameters using the Rookout API (use before the RookoutChalice initialization):

```python
import rook
rook.start(token="<token>", tags=["tag1", "tag2"])
```

4. Go to [app.rookout.com](https://app.rookout.com) and start debugging!
