
# Quickstart for debugging Nameko

A sample application for debugging Python Nameko apps using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

## Running Nameko Server with Rookout

1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/python-nameko
    pip3 install -r requirements.txt
```

2. *Export organization token*:
 ```bash
 	export ROOKOUT_TOKEN=<Your Rookout Token>
```

3. *Run nameko*:
```bash
    # start the server (default: http://localhost:8000)
    nameko run nameko_example.py
```

4. *Have fun debugging*:
	Go to https://app.rookout.com and start debugging :)


[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

