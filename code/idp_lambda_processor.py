import json
import boto3
import base64
import os

prompt = """
This image shows a birth certificate application form. 
Please precisely copy all the relevant information from the form.
Leave the field blank if there is no information in corresponding field.
If the image is not a birth certificate application form, simply return an empty JSON object. 
If the application form is not filled, leave the fees attributes blank. 
Translate any non-English text to English. 
Organize and return the extracted data in a JSON format with the following keys:
{
    "applicantDetails":{
        "applicantName": "",
        "dayPhoneNumber": "",
        "address": "",
        "city": "",
        "state": "",
        "zipCode": "",
        "email":""
    },
    "mailingAddress":{
        "mailingAddressApplicantName": "",
        "mailingAddress": "",
        "mailingAddressCity": "",
        "mailingAddressState": "",
        "mailingAddressZipCode": ""
    },
    "relationToApplicant":[""],
    "purposeOfRequest": "",
    
    "BirthCertificateDetails":
    {
        "nameOnBirthCertificate": "",
        "dateOfBirth": "",
        "sex": "",
        "cityOfBirth": "",
        "countyOfBirth": "",
        "mothersMaidenName": "",
        "fathersName": "",
        "mothersPlaceOfBirth": "",
        "fathersPlaceOfBirth": "",
        "parentsMarriedAtBirth": "",
        "numberOfChildrenBornInSCToMother": "",
        "diffNameAtBirth":""
    },
    "fees":{
        "searchFee": "",
        "eachAdditionalCopy": "",
        "expediteFee": "",
        "totalFees": ""
    } 
  }
""" 

s3 = boto3.client('s3')
bedrock = boto3.client('bedrock-runtime', region_name=os.environ.get('REGION_NAME'))
MODEL_ID = os.environ.get('MODEL_NAME')
BUCKET_NAME = os.environ.get('BUCKET_NAME')
FILE_NAME = os.environ.get('FILE_NAME')

def lambda_handler(event, context):
    image_data = s3.get_object(Bucket=BUCKET_NAME, Key=FILE_NAME)['Body'].read()
    base64_image = base64.b64encode(image_data).decode('utf-8')

    response = invoke_claude_3_multimodal(prompt, base64_image)
    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }

def invoke_claude_3_multimodal(prompt, base64_image_data):
    request_body = {
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": 2048,
        "messages": [
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": prompt,
                    },
                    {
                        "type": "image",
                        "source": {
                            "type": "base64",
                            "media_type": "image/png",
                            "data": base64_image_data,
                        },
                    },
                ],
            }
        ],
    }

    try:
        response = bedrock.invoke_model(modelId=MODEL_ID, body=json.dumps(request_body))
        return json.loads(response['body'].read())
    except bedrock.exceptions.ClientError as err:
        print(f"Couldn't invoke Claude 3 Sonnet. Here's why: {err.response['Error']['Code']}: {err.response['Error']['Message']}")
        raise