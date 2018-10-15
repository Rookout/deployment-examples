# Quickstart for debugging a Django app 

A sample application for debugging Django using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout] guide.

* [Running Django Server with Rookout](#running-django-server-with-rookout)
* [Rookout integration explained](#Rookout-integration-explained)

## Running Django Server with Rookout
1. *Run the Rookout agent*:
``` bash
$ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
```

2. *Install dependencies*:
 ```bash
    pip install -r requirements.txt
    python manage.py migrate
```

3. *Run the Django Server*:
```bash
    #start the server (default: http://localhost:8001)
    python manage.py runserver localhost:8001
```
4. *Enjoy the debugging*:
Go to https://app.rookout.com and start debugging :)

## Rookout Integration explained

The demo application is based on https://github.com/rtzll/django-todolist

We have added Rookout to original project by:
1. Adding rook to requirements.txt 
2. Adding the following snippet to the code (`setting.py`)
```Python
from rook import auto_start
```

[Python + Rookout]: https://docs.rookout.com/docs/installation-python.html
[here]: https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/appengine/hello-world
