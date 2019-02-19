# Quickstart for debugging Flask

A sample application for debugging Python Flask apps using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

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

3. *Run the Flask server*:
```bash
    #start the server (default: http://localhost:5000)
    python flask_rookout.py
```

4. *Enjoy the debugging*:
	Go to https://app.rookout.com and start debugging :)


[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

