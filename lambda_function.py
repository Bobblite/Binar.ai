import os
import io
import boto3
import json
import csv
import base64
import numpy as np
from PIL import Image

# grab environment variables
ENDPOINT_NAME = 'binarai-endpoint'
runtime= boto3.client('runtime.sagemaker')

def prepare_image(payload):
    # Decode
    buffer = io.BytesIO(base64.b64decode((payload)))
    img = Image.open(buffer)
    
    # Resize and centralize
    new_image = Image.new('RGBA', (28,28), (255,255,255,0)) # Create white image
    new_image.paste(img.resize((20,20)), (4,4))
    return new_image.getchannel('A')

def lambda_handler(event, context):
    data = json.loads(json.dumps(event))

    # Decode base64 image to PIL image
    img0 = prepare_image(data['data0'])
    img1 = prepare_image(data['data1'])
    img2 = prepare_image(data['data2'])
    img3 = prepare_image(data['data3'])
    imgData = np.hstack((np.asarray(img1), np.asarray(img0)))
    imgData = np.hstack((np.asarray(img2), imgData))
    imgData = np.hstack((np.asarray(img3), imgData))
    
    # Pre-processing
    imgData = imgData.flatten()
    imgData = imgData.reshape(1, 28, 112, 1)
    imgData = imgData.astype('float32') / 255
    endpoint_payload = json.dumps(imgData.tolist())
    
    response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,
                                       ContentType='application/json',
                                       Body=endpoint_payload)
    result = json.loads(response['Body'].read().decode())
    predictions = np.array(result['predictions'][0])

    return (predictions.argmax()).item()