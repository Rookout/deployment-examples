from celery import Celery

import rook
rook.start(fork=True)

app = Celery('tasks', broker='amqp://host.docker.internal', backend='redis://host.docker.internal')


@app.task
def add(x, y):
    return x + y
