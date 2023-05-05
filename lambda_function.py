import os
import boto3

dynamodb = boto3.client('dynamodb')

def lambda_handler(event, context):

    table_name = os.environ['TABLE_NAME']

    response = dynamodb.update_item(
        TableName=table_name,
        Key={
            'website':{
                'S': 'resume.arfeljunvelasco.live'}    },
        UpdateExpression='SET visitor_count = visitor_count + :inc',
        ExpressionAttributeValues={
            ':inc': {'N': '1'}
        },
        ReturnValues="UPDATED_NEW")

    print("UPDATING ITEM")

    print(response["Attributes"]["visitor_count"]["N"])
