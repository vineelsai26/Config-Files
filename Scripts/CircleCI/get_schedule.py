"""
* This script is used to get environment variables from CircleCI and upload them to a new project.
* This needs to be run from CircleCI runner.
* Make sure you have the CIRCLECI_TOKEN, NEW_CIRCLE_PROJECT_REPONAME environment variable set.
"""

import os

import requests
from dotenv import load_dotenv

load_dotenv()

repoName = os.environ.get('CIRCLE_PROJECT_REPONAME')
newRepoName = os.environ.get('NEW_CIRCLE_PROJECT_REPONAME')

res = requests.get(
    f"https://circleci.com/api/v2/project/bitbucket/elucidatainc/{repoName}/schedule",
    headers={
        "Circle-Token": os.environ.get('CIRCLECI_TOKEN')
    },
    timeout=10
).json()

for item in res.get('items'):
    print(item)
    res = requests.post(
        f"https://circleci.com/api/v2/project/github/ElucidataInc/{newRepoName}/schedule",
        headers={
            "Circle-Token": os.environ.get('CIRCLECI_TOKEN')
        },
        json={
            "name": item.get('name'),
            "description": item.get('description'),
            "attribution-actor": "system",
            "parameters": item.get('parameters'),
            "timetable": item.get('timetable'),
        },
        timeout=10
    ).json()
    print(res)
