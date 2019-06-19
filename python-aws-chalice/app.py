from rook.serverless import RookoutChalice

# In order to pass parameters using the Rookout API, uncomment the section below:
# import rook
# rook.start(token="<token>", tags=["tag1", "tag2"])

app = RookoutChalice(app_name='python-aws-chalice')

@app.route('/')
def index():
    return {'hello': 'world'}
