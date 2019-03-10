
# Quickstart for debugging Sanic

A sample application for debugging Python Sanic apps using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

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

4. *Have fun debugging*:
	Go to https://app.rookout.com and start debugging :)

## Rookout Integration explained
1. When running number of workers that handle requests in parallel, we need to import rook for each process.
```python
    async def load_rookout():
    	from rook import auto_start
```

[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

