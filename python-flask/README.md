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

## Usage

- Log in to the [Rookout IDE](https://app.rookout.com/)
- Set up your debug session by selecting the Python app you started. See [Debug session setup](https://docs.rookout.com/docs/debug-session-setup) for more information
- Add the source code according to the following [instructions](https://docs.rookout.com/docs/source-repos/). In this case, use the [local filesystem option](https://docs.rookout.com/docs/source-repos/) to associate the code in your local 'python-flask' folder.
- Open the file 'flask_rookout.py'
- Add a Breakpoint to a line by clicking next the the line number in the file viewer
- Go the the app webpage http://localhost:5000/ and add a todo in order to trigger the Breakpoint
- Check the bottom pane **Messages** and you'll see the snapshot you just added, as it was triggered by the handler of the web api when you added a todo

Go through the [bug list](https://docs.rookout.com/docs/sample-applications.html#bug-hunt) and follow instructions to see some basic use cases.

## Common Pitfalls

- Breakpoint status is pending (hollow with purple outline) -- Connection to the app was not able to be established. Make sure that you inserted the Rookout Token in the right place and that the SDK was properly installed.
- Breakpoing status is disabled (solid grey) -- The breakpoint was disabled from collecting more data due to the limits being hit.
- Brekapoint error -- something went wrong. Check the breakpoint status to get more information on the error type, and for more information go to our [breakpoint status guide][https://docs.rookout.com/docs/breakpoints-status/].

## Want to learn more ?

- [Our website](https://rookout.com/) for more information
- [Our documentation](https://docs.rookout.com/) for more information
- [our deployment examples](https://docs.rookout.com/docs/deployment-examples.html) for platform-specific integration examples

## License
[APACHE 2](LICENSE)