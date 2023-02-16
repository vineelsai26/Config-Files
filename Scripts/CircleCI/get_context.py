"""
* This Should be run on the circleci runner. You should ssh into the runner and run this script.
* This script will get the context from CircleCI and write it to a file.
* You should then manually edit the file and add the new context id to the file.
* Then you should run the upload_context.py script.
* You need to have the CIRCLECI_TOKEN environment variable set.
"""

import os
from json import JSONDecoder, JSONEncoder

import requests
from dotenv import load_dotenv

load_dotenv()

# Get contexts from file (need to be created manually)
with open('contexts.json', 'r', encoding='utf-8') as f:
    contexts = f.read()

# Decode contexts in JSON format
contexts = JSONDecoder().decode(contexts)

output = []

for context in contexts:
    # Get context from CircleCI
    response = requests.get(
        f'https://circleci.com/api/v2/context/{context.get("id")}/environment-variable',
        headers={
            "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
        }, timeout=10).json()

    out = []

    out += response.get('items')

    while response.get('next_page_token') is not None:
        # Get variables from context
        response = requests.get(
            f'https://circleci.com/api/v2/context/{context.get("id")}/environment-variable?page-token={response.get("next_page_token")}',
            headers={
                "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
            },
            timeout=10
        ).json()

        out += response.get('items')

    # Get environment variables from local machine
    out = list(map(lambda x: {
        "variable": x.get('variable'),
        "value": os.environ.get(x.get('variable'))
    }, out))

    # Append variables with variables from local meachine in context to output
    output.append({
        "name": context.get('name'),
        "id": context.get('id'),
        "newId": context.get('newId'),
        "variables": out,
    })

# Write output to file
with open('output.json', 'w', encoding='utf-8') as f:
    f.write(JSONEncoder().encode(output))
