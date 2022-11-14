import time
from flask import Flask, render_template
from random import randint
from datetime import datetime
import rook


app = Flask(__name__)


@app.errorhandler(404)
def page_not_found(e):
    return '404 Page Not Found'

@app.errorhandler(500)
def internal_server_error(e):
    return '500 Internal Server Error'

@app.route("/render")
def render_bad_template():
    try:
        invalid_oper = 42 / 0
    except Exception as e:
        print('Operation failed to complete')
    animal_list = ['dog', 'cat', 'turtle', 'fish', 'bird', 'cow', 'sealion']
    time = datetime.now()
    number = 0.01 * randint(10, 200) + 0.1
    return render_template('doesnotexist.html', animal_list=animal_list, time=time, number=number)

@app.route("/")
def home():
    time.sleep(0.01 * randint(10, 200) + 0.1)
    return 'Index Main Page'

@app.route('/hello')
def hello():
    time.sleep(0.01 * randint(10, 200) + 0.1)
    return 'Hello, World'


if __name__== "__main__":
    rook.start()
    app.run(host="0.0.0.0", port=5000, threaded=True)