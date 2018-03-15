# Quickstart for Django + Rookout

A sample application for using Rookout + Django

Before following this guide we recommend reading the basic [Python + Rookout] guide.

* [Running Django Server + Rookout](#running)
* [Rookout integration explain](#Rookout-integration-explain)
## Running
1. *Run the agent*:
``` bash
$ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" rookout/agent
```

2. *Install dependencies*:
 ```bash
    pip install -r requirements.txt
    python manage.py migrate
```

3. *Run*:
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

[Python + Rookout]: https://rookout.github.io/tutorials/python
[here]: https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/appengine/hello-world
