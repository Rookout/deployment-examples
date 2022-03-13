import time
from flask import Flask
from random import randint
import os
from datetime import datetime
import rook


app = Flask(__name__)

@app.route("/")
def home():
    time.sleep(0.01 * randint(10, 200) + 0.1)
    return 'Index Main Page'

@app.route('/hello')
def hello():
    time.sleep(0.01 * randint(10, 200) + 0.1)
    return 'Hello, World'  # Set bp here


def debug_here(i):
    j = i * i
    return j  # Set bp here


def child_routine():
    for i in range(30):
        debug_here(i)
        time.sleep(5)


if __name__ == "__main__":
    rook.start(throw_errors=True, fork=True)
    if 0 == os.fork():
        app.run(host="0.0.0.0", port=5000, threaded=True)
    else:
        child_routine()
