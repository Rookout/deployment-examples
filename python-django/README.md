# Quickstart for debugging a Django app 

A sample application for debugging Django using Rookout.

Before following this guide we recommend reading the basic [Python + Rookout](https://docs.rookout.com/docs/sdk-setup.html) guide.

## Running Django Server with Rookout
1. *Clone and install dependencies*:
 ```bash
    git clone https://github.com/Rookout/deployment-examples.git
    cd deployment-examples/python-django
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
4. *Have fun debugging*:
Go to https://app.rookout.com and start debugging :)

## Rookout Integration explained

1. Install the Rookout pypi package
```bash
    pip install rook
```

2. Import the package in your app's entry-point file, just before it starts
```bash
   import rook
   rook.start()
```

## Usage

- Log in to the [Rookout IDE](https://app.rookout.com/)
- Set up your debug session by selecting the Python app you started. See [Debug session setup](https://docs.rookout.com/docs/debug-session-setup) for more information
- Add the source code according to the following [instructions](https://docs.rookout.com/docs/source-repos/). In this case, use the [local filesystem option](https://docs.rookout.com/docs/source-repos/) to associate the code in your local 'python-django' folder.
- Open the file 'manage.py'
- Add a Breakpoint next to a line of code by clicking next the the line number in the file viewer
- Go the the app webpage http://localhost:8001/ and add a todo in order to trigger the Breakpoint
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

