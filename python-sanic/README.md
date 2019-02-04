
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

## Rookout Integration explained
1. When running number of workers that handle requests in parallel, we need to import rook only after forking.
```python
    async def load_rookout():
    try:
        if os.environ["ROOKOUT_TOKEN"]:
            try:
                from rook import auto_start
            except:
                print("Rookout occured an error while loading")
            print("Succesfully imported rook")
    except KeyError:
        print("Please set the environment variable ROOKOUT_TOKEN")
```

[Python + Rookout]: https://docs.rookout.com/docs/sdk-setup.html

