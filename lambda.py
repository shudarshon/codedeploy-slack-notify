import boto3
import json
import logging
import os

from base64 import b64decode
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError

ENCRYPTED_HOOK_URL = os.environ['kmsEncryptedHookUrl']
SLACK_CHANNEL = os.environ['slackChannel']
ORGANIZATION = os.environ['organization']
HOOK_URL = "https://" + boto3.client('kms').decrypt(CiphertextBlob=b64decode(ENCRYPTED_HOOK_URL))['Plaintext'].decode('utf-8')

# color code by codebuild states
COLORS = {
    'READY': '#F0F8FF',
    'START': '#1E90FF',
    'SUCCESS': '#008000',
    'FAILURE': '#B22222',
    'STOP': '#808080'
}

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Event: " + str(event))

    if 'detail' in event:
        application = event["detail"]["application"]
        state = event["detail"]["state"]

        footer = u"\u00A9 %s" %(ORGANIZATION)
        title = "CodeDeploy Status Information"
        buildstatus = "_*" + state + "*_"

        # create json object with webhook variables
        data = {}

        data["color"] = COLORS[state]
        data["title"] = title
        data['footer'] = footer

        data["fields"] = []
        fields = data["fields"]

        field_application = {}
        field_application["title"] = "Application"
        field_application["value"] = application
        field_application["short"] = 0

        field_status = {}
        field_status["title"] = "State"
        field_status["value"] = buildstatus
        field_status["short"] = 0

        fields.append(field_application)
        fields.append(field_status)

        # convert json object as array
        attachments_json = []
        attachments_json.append(data)

        slack_message = {
            'channel': SLACK_CHANNEL,
            'attachments' : attachments_json
        }
        if state == "SUCCESS" or state == "FAILURE" or state == "STOP":
            req = Request(HOOK_URL, json.dumps(slack_message).encode('utf-8'))
            try:
                response = urlopen(req)
                response.read()
                logger.info("Message posted to %s", slack_message['channel'])
            except HTTPError as e:
                logger.error("Request failed: %d %s", e.code, e.reason)
            except URLError as e:
                logger.error("Server connection failed: %s", e.reason)
