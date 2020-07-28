# Quickstart for debugging a celery app 

A sample application for debugging celery using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

## Running Django Server with Rookout
1. *Run redis and rabbitmq*:
 ```bash
    docker run -d -p 6379:6379 redis
    docker run -d -p 5672:5672 rabbitmq
```

2. *Install requirements*
```bash
    pip -r requirements.txt
```

3. *Add your token*:
```bash
    export ROOKOUT_TOKEN=[YOUR-TOKEN]
```

4. *Run the server*:
```bash
    celery -A tasks worker --loglevel=info
```

5. *Calling the task (python)*:
```py
    from tasks import add
    res = add.delay(3, 4)
    print(res.get(timeout=1))
```

6. *Have fun debugging*:
Go to https://app.rookout.com and start debugging :)

## Rookout Integration explained

1. Install the Rookout pypi package
```bash
    pip install rook
```

2. Import the package in your app's entry-point file, just before it starts
```bash
   import rook
   rook.start(fork=True)
```

[Python + Rookout]: https://docs.rookout.com/docs/python-setup/

