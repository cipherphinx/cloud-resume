import os
import boto3

dynamodb = boto3.client('dynamodb')

def lambda_handler(event, context):
    table_name = os.environ['TABLE_NAME']

    response = dynamodb.update_item(
        TableName=table_name,
        Key={
            'website': {
                'S': 'resume.arfeljunvelasco.live'
            }
        },
        UpdateExpression='SET visitor_count = if_not_exists(visitor_count, :zero) + :inc',
        ExpressionAttributeValues={
            ':zero': {'N': '0'},
            ':inc': {'N': '1'}
        },
        ReturnValues='UPDATED_NEW'
    )

    print('UPDATING ITEM')
    return response
