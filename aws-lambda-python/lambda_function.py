def _lambda_handler(event, context):
  return "Hello world"

from rook import lambda_wrapper
lambda_handler = lambda_wrapper.wrapper(_lambda_handler)