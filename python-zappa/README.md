# Quickstart for debugging Python + AWS Lambda + Zappa

A sample application for debugging Python apps deployed in AWS Zappa using Rookout.

Before following this guide we recommend reading the basic [Python + Lambda debugging guide](https://github.com/Rookout/deployment-examples/blob/master/python-aws-lambda/README.md).

This example is based on a plain Zappa app, with the following modifications applied:

1. Set your Rookout token as an environment variable in `zappa_settings.json`:

```json
{
    "dev": {
        ....
        ....,
        "aws_environment_variables" : {"ROOKOUT_TOKEN": "<token>"}
    }
}
```

2. Add the `rook` SDK dependancy to your `requirements.txt` Zappa file.

3. Add the following code in your main app code:

```python
from rook.serverless import setup_zappa_support
setup_zappa_support()
```

4. Go to [app.rookout.com](https://app.rookout.com) and start debugging!
