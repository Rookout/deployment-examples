# Quickstart for debugging a Django app 

A sample application for debugging Django using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/rooks-setup.html) guide.

## Running Django Server with Rookout
1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples/tree/master/python-django
    pip install -r requirements.txt
    python manage.py migrate
```

2. *Export Organization Token*
```bash
    export ROOKOUT_TOKEN=<Your-Token>
```

3. *Run the Django Server*:
```bash
    #start the server (default: http://localhost:8001)
    python manage.py runserver localhost:8001
```
4. *Enjoy the debugging*:
Go to https://app.rookout.com and start debugging :)

## Rookout Integration explained

1. Install the Rookout pypi package
```bash
    pip install rook
```


2. Import the package in your app's entry-point file, just before it starts
```bash
   import rook
   rook.start(token=<Your-Token>)
```

[Python + Rookout]: https://docs.rookout.com/docs/rooks-setup.html
[here]: https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/appengine/hello-world

