"""
* This script is used to get environment variables from CircleCI and upload them to a new project.
* This needs to be run from CircleCI runner.
* Make sure you have the CIRCLECI_TOKEN, NEW_CIRCLE_PROJECT_REPONAME environment variable set.
"""

import os
from json import JSONEncoder

import requests
from dotenv import load_dotenv

load_dotenv()

repoName = os.environ.get('CIRCLE_PROJECT_REPONAME')
newRepoName = os.environ.get('NEW_CIRCLE_PROJECT_REPONAME')

# Get Environment Variables from CircleCI
envvars = requests.get(
    f"https://circleci.com/api/v2/project/bb/elucidatainc/{repoName}/envvar",
    headers={
        "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
    },
    timeout=10
).json()

output = []

# Get environment variables from local machine
for envvar in envvars.get('items'):
    output.append({
        "variable": envvar.get('name'),
        "value": os.environ.get(envvar.get('name'))
    })

# Write output to file
with open(f"{repoName}.json", 'w', encoding='utf-8') as f:
    f.write(JSONEncoder().encode(output))

# Write Environment Variables to CircleCI
for envvar in output:
    requests.post(
        f'https://circleci.com/api/v2/project/gh/ElucidataInc/{newRepoName}/envvar',
        headers={
            "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
        },
        json={
            "name": envvar.get('variable'),
            "value": envvar.get('value')
        },
        timeout=10
    )
