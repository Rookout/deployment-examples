from rook.serverless import RookoutChalice

app = RookoutChalice(app_name='python-aws-chalice')

@app.route('/')
def index():
    return {'hello': 'world'}
