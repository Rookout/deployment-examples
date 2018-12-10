# Quickstart for debugging Flask

A sample application for debugging Python Flask apps using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/rooks-setup.html) guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Running flask Server with Rookout

1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples/tree/master/python-flask
    pip install flask
    pip install rook
```
2. *Export organization token*:
 ```bash
 	export ROOKOUT_TOKEN=<Your Rookout Token>
```

3. *Enable flask debugging*:
	Set environment variable ROOKOUT_HTTP_SERVICES=flask
```bash
	export ROOKOUT_HTTP_SERVICES=flask
```

4. *Run the Flask server*:
```bash
    #start the server (default: http://localhost:5000)
    python flask_rookout.py
```

5. *Enjoy the debugging*:
	Go to https://app.rookout.com and start debugging :)

6. *Bonus: Setup a global HTTP rule*:
	Use flask_rule.json in this deployment example as a template for a new Rookout Rule.

## Running with docker and Agentless

[Python + Rookout]: https://docs.rookout.com/docs/rooks-setup.html

