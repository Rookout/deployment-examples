
# Quickstart for debugging Sanic

A sample application for debugging Python Sanic apps using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

This sample may be out of date. If you face any issues, please reach out to mailto:support@rookout.com and let us know.

## Running Sanic Server with Rookout

1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples/tree/master/python-sanic
    pip3 install -r requirements.txt
```
2. *Export organization token*:
 ```bash
 	export ROOKOUT_TOKEN=<Your Rookout Token>
```

3. *Run the sanic server*:
```bash
    #start the server (default: http://localhost:5000)
    python3 sanic_rookout.py
```

4. *Enjoy the debugging*:
	Go to https://app.rookout.com and start debugging :)


[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

