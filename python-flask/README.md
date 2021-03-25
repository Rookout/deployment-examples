# Quickstart for Python + Flask

A sample application for using Rookout API to debug Python Flask apps.

Before following this guide we recommend completing the basic [Python + Rookout tutorial](https://github.com/Rookout/tutorial-python).

* [Running locally](#running-locally)
* [Rookout Integration explained](#rookout-integration-explained)

## Running locally

1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/python-flask
    pip install -r requirements.txt
```
21. *Export organization token*:
 ```bash
 	export ROOKOUT_TOKEN=<Your Rookout Token>
```

1. *Run the Flask server*:
```bash
    # starts the server (default URL: http://localhost:5000)
    python flask_rookout.py
```

1. Make sure everything worked: [http://localhost:5000](http://localhost:5000)

1. Go to [http://app.rookout.com](http://app.rookout.com) and start debugging! 


## Rookout Integration explained

1. Rookout's Python SDK was installed as part of `requirements.txt` / `pip install rook`

1. Add the import to the main file of the application `import rook`

1. Start the SDK using `rook.start()` as early as possible in your code - it will look for the `ROOKOUT_TOKEN` environment variable, or can be passed as a parameter `rook.start(token="ROOKOUT_TOKEN")`


[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html
