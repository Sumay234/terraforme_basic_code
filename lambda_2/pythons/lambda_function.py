def lambda_handler(event, context):
   message = 'Hello {} !'.format(event['key1'])
   return {
       'message' : message
   }

   




'''import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    # Log the event payload
    logger.info(f"Received event: {json.dumps(event)}")
    
    # Your business logic here
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
'''