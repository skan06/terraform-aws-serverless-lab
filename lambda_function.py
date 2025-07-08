import json
import logging
import boto3
import datetime
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3 = boto3.client('s3')

def lambda_handler(event, context):
    bucket_name = os.environ.get("BUCKET_NAME")
    filename = f"log-{datetime.datetime.utcnow().isoformat()}.txt"
    message = "Hello from Lambda, stored in S3!"

    # Write to CloudWatch
    logger.info(message)

    # Write to S3
    s3.put_object(Bucket=bucket_name, Key=filename, Body=message)

    return {
        'statusCode': 200,
        'body': json.dumps(f"Logged message and saved to S3: {filename}")
    }
