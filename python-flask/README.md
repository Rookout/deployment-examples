# Quickstart for Flask + Rookout

A sample application for using Rookout + Flask

Before following this guide we recommend reading the basic [Python + Rookout] guide.

* [Running Flask Server + Rookout](#running)

## Running
1. *Run the agent*:
``` bash
$ docker run -p 7486:7486 -e "ROOKOUT_TOKEN=<Your-Token>" us.gcr.io/rookout/go_agent
```

2. *Install dependencies*:
 ```bash
	pip install flask
    pip install rook
```

3. *Enable flask debugging*:
	Set environment variable ROOKOUT_HTTP_SERVICES=flask
```bash
	export ROOKOUT_HTTP_SERVICES=flask
```

4. *Run*:
```bash
    #start the server (default: http://localhost:5000)
    python flask_rookout.py
```

5. *Setup global rule*:
	use flask_rule.json as new rule template


6. *Enjoy the debugging*:
Go to https://app.rookout.com and start debugging :)

[Python + Rookout]: https://docs.rookout.com/docs/installation-python.html
