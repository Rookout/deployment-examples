import os
import boto3
import uuid

from flask import request, jsonify
from flask_lambda import FlaskLambda
from flask_cors import CORS
from rook.serverless import rookout_serverless

REGION = os.environ['REGION_NAME']
TABLE_NAME = os.environ['TABLE_NAME']
app = FlaskLambda(__name__)
cors = CORS(app)

# add dynamo DB instance
dynamo_db = boto3.resource('dynamodb', region_name=REGION)

@rookout_serverless(quiet=True)
def handler(event, context):
    app(event, context)


@app.route('/todos', methods=("OPTIONS", ))
def get_options():
    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "*"
        },
        "body": {"status": "success"}
    }


@app.route('/todos/<todo_id>', methods=("OPTIONS", ))
def get_todo_options(todo_id):
    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "*"
        },
        "body": {"status": "success"}
    }


@app.route('/todos', methods=['GET', ])
def get_todos():
    try:
        table_response = dynamo_db.Table(TABLE_NAME).scan()
        return jsonify(table_response['Items'])
    except Exception as e:
        return jsonify({'error': f'an error has occurred: {e}'}), 500


@app.route('/todos', methods=['POST', ])
def create_todo():
    todo_id = str(uuid.uuid4())
    todo_item = request.get_json()
    data = {
        'id': todo_id,
        'completed': False,
        'url': f'{request.base_url.removesuffix("/todos")}/Prod/todos/{todo_id}',
        'title': todo_item['title'],
        'order': todo_item['order'] if 'order' in todo_item else 0
    }

    try:
        dynamo_db.Table(TABLE_NAME).put_item(Item=data)
        res = dynamo_db.Table(TABLE_NAME).get_item(Key={'id': todo_id})
        res['Item']['order'] = int(res['Item']['order'])
        return jsonify(res['Item'])
    except Exception as e:
        return jsonify({'error': f'an error has occurred: {e}'}), 500


@app.route('/todos', methods=['DELETE', ])
def delete_todos():
    todos = dynamo_db.Table(TABLE_NAME).scan()
    for todo in todos['Items']:
        dynamo_db.Table(TABLE_NAME).delete_item(Key={'id': todo['id']})
    todos = dynamo_db.Table(TABLE_NAME).scan()
    return jsonify(todos['Items'])


@app.route('/todos/<todo_id>', methods=['GET', ])
def get_todo(todo_id):
    tbl_res = dynamo_db.Table(TABLE_NAME).get_item(Key={'id': todo_id})
    tbl_res['Item']['order'] = int(tbl_res['Item']['order'])
    return jsonify(tbl_res['Item'])


@app.route('/todos/<todo_id>', methods=['PATCH', ])
def edit_todo(todo_id):
    todo_obj = request.get_json()
    tbl_res = dynamo_db.Table(TABLE_NAME).get_item(Key={'id': todo_id})
    if not tbl_res['Item']:
        return jsonify({'error': 'Todo ID does not exist'})
    if "completed" in todo_obj:
        tbl_res['Item']['completed'] = todo_obj['completed']
    if "title" in todo_obj:
        tbl_res['Item']['title'] = todo_obj['title']
    if "order" in todo_obj:
        tbl_res['Item']['order'] = todo_obj['order']
    try:
        dynamo_db.Table(TABLE_NAME).update_item(Key={'id': todo_id},
                                                AttributeUpdates={
                                                    'completed': {'Value': tbl_res['Item']['completed']},
                                                    'title': {'Value': tbl_res['Item']['title']},
                                                    'order': {'Value': tbl_res['Item']['order']}
                                                })
        return jsonify(tbl_res['Item'])
    except Exception as e:
        return jsonify({"error": f"failed updating todo item with error {e}"})


@app.route('/todos/<todo_id>', methods=['DELETE', ])
def delete_todo(todo_id):
    try:
        dynamo_db.Table(TABLE_NAME).delete_item(Key={'id': todo_id})
    except Exception as e:
        return jsonify({'error': f'An error occurred during delete: {e}'})
    return jsonify({"status": "success"})


if __name__ == '__main__':
    app.run()


