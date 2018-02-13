import json

import tornado
from tornado import websocket, web, ioloop

cl = []
import os

dir_path = os.path.dirname(os.path.realpath(__file__))


class IndexHandler(web.RequestHandler):
    def get(self):
        self.render("index.html")


class SocketHandler(websocket.WebSocketHandler):
    def check_origin(self, origin):
        return True

    def open(self):
        if self not in cl:
            cl.append(self)

    def on_close(self):
        if self in cl:
            cl.remove(self)


class ApiHandler(web.RequestHandler):

    @web.asynchronous
    def get(self, *args):
        self.finish()
        id = self.get_argument("id")
        value = self.get_argument("value")
        data = {"id": id, "value": value}
        data = json.dumps(data)
        for c in cl:
            c.write_message(data)

    @web.asynchronous
    def post(self):
        pass


app = web.Application([
    (r'/', IndexHandler),
    (r'/ws', SocketHandler),
    (r'/api', ApiHandler),
    (r'/(favicon.ico)', web.StaticFileHandler, {'path': '../'}),
    (r"/images/(.*)", tornado.web.StaticFileHandler, {'path': os.path.join(dir_path, "./images")})
])

from rook import auto_start
if __name__ == '__main__':
    app.listen(8888)
    ioloop.IOLoop.instance().start()
