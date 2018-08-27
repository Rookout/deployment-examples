import time
from flask import Flask
from random import randint

print("Starting rook from-", __file__)
from rook import auto_start
print("Rook start has finished!")

app = Flask(__name__)


@app.route("/")
def home():
    time.sleep(0.01 * randint(10, 200) + 0.1)
    return 'Index Main Page'

@app.route('/hello')
def hello():
    time.sleep(0.01 * randint(10, 200) + 0.1)
    return 'Hello, World'


if __name__== "__main__":
    app.run(host="127.0.0.1", port=5000, threaded=True)