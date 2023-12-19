import os
import json
from datetime import datetime
import requests
import boto3

def lambda_handler(event, context):
    # APIリクエスト
    response = requests.get("https://pokeapi.co/api/v2/pokemon/pikachu")
    data = response.json()

    # S3への保存
    s3 = boto3.client('s3')
    bucket_name = os.environ['BUCKET_NAME']
    file_name = datetime.now().strftime("%Y%m%d%H%M%S") + ".json"
    s3.put_object(Bucket=bucket_name, Key=file_name, Body=json.dumps(data))

    return {
        "statusCode": 200,
        "body": json.dumps("Data saved to S3")
    }
