# print("Starting rook from-", __file__)
# from rook import auto_start
# print("Rook start has finished!")

from .rookout_loader import load_rookout
from sanic import Blueprint, Sanic
from sanic.response import file, json
import os

app = Sanic(__name__)
blueprint = Blueprint('name', url_prefix='/my_blueprint')
blueprint2 = Blueprint('name2', url_prefix='/my_blueprint2')
blueprint3 = Blueprint('name3', url_prefix='/my_blueprint3')


@blueprint.route('/foo')
async def foo(request):
    return json({'msg': 'hi from blueprint'})


@blueprint2.route('/foo')
async def foo2(request):
    return json({'msg': 'hi from blueprint2'})


@blueprint3.route('/foo')
async def index(request):
    return await file('websocket.html')


@app.websocket('/feed')
async def foo3(request, ws):
    while True:
        data = 'hello!'
        print('Sending: ' + data)
        await ws.send(data)
        data = await ws.recv()
        print('Received: ' + data)

app.blueprint(blueprint)
app.blueprint(blueprint2)
app.blueprint(blueprint3)

def start_server():
    app.add_task(load_rookout())
    app.run(host='0.0.0.0',
            port=os.environ.get('PORT', 5000),
            access_log=False,
            debug=False,
            workers=3)

start_server()
