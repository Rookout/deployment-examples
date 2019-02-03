from sanic import Sanic
from sanic.response import json

app = Sanic()

@app.route('/')
async def test(request):
    return json({'hello': 'world'})

print("Starting rook from-", __file__)
from rook import auto_start
print("Rook start has finished!")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, workers=4)