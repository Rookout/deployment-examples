# Rookout for Chalice/AWS Lambda

This example shows how to debug Chalice apps on AWS Lambda using [Rookout](https://rookout.com).

To know more about Rookout on AWS Lambda, it is recommended to read [Rookout on Lambda documentation](https://github.com/Rookout/deployment-examples/blob/master/node-aws-lambda/README.md) first.

This example is based on a plain Chalice app, with the following modifications applied:

1. Set the Rookout Agent host, port and token via environment variables in `.chalice/config.json`:

```json
"environment_variables": {
    "ROOKOUT_AGENT_HOST": "cloud.agent.rookout.com",
    "ROOKOUT_AGENT_PORT": "443",
    "ROOKOUT_TOKEN": "<token>"
  }
```

2. Add `rook` to your `requirements.txt`

3. Initialize your Chalice app with `RookoutChalice`

```python
from rook.serverless import RookoutChalice

app = RookoutChalice(app_name='python-aws-chalice')
```

You can use then the Chalice API as usual.