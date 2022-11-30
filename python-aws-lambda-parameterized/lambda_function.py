from rook.serverless import serverless_rook_params

@serverless_rook_params(quiet=True)
def lambda_handler(event, context):
  return "Hello world"
