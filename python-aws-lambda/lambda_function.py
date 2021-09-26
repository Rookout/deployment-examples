from rook.serverless import serverless_rook

@serverless_rook
def lambda_handler(event, context):
  return "Hello world"
