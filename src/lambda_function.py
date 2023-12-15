import json
import requests
import boto3
from datetime import datetime

def lambda_handler(event, context):
    # APIリクエスト
    response = requests.get("https://pokeapi.co/api/v2/pokemon/pikachu")
    data = response.json()

    # S3への保存
    s3 = boto3.client('s3')
    bucket_name = "original-data"
    file_name = datetime.now().strftime("%Y%m%d") + ".json"
    s3.put_object(Bucket=bucket_name, Key=file_name, Body=json.dumps(data))

    return {
        "statusCode": 200,
        "body": json.dumps("Data saved to S3")
    }
