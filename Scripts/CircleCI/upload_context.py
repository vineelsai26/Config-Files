"""
* Upload context to CircleCI
* This script will upload the context to CircleCI.
* This can run from circleci runner or local meachine. 
* You need to have the CIRCLECI_TOKEN environment variable set.
* If you want to create the context, you need to uncomment "Create context in CircleCI" part code.
"""

import os
from json import JSONDecoder

import requests
from dotenv import load_dotenv

load_dotenv()

with open('output.json', 'r', encoding='utf-8') as f:
    contexts = f.read()

contexts = JSONDecoder().decode(contexts)

for context in contexts:
    # Create context in CircleCI
    # response = requests.post(
    #     'https://circleci.com/api/v2/context',
    #     headers={
    #         'content-type': 'application/json',
    #         "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
    #     },
    #     json={
    #         "name": context.get('name'),
    #         "owner": {
    #             "id": "0374c68d-c8f8-42d2-9f43-993f5dc66724",
    #             "type": "organization"
    #         }
    #     },
    #     timeout=10
    # ).json()

    # Get context from CircleCI
    response = requests.get(
        f"https://circleci.com/api/v2/context/{context.get('newId')}",
        headers={
            "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
        },
        timeout=10
    ).json()

    # Add environment variables to context
    for variable in context.get('variables'):
        res = requests.put(
            f"https://circleci.com/api/v2/context/{response.get('id')}/environment-variable/{variable.get('variable')}",
            headers={
                'content-type': 'application/json',
                "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
            },
            json={
                "value": variable.get('value')
            },
            timeout=10
        ).json()

        print(res.get('variable'))
