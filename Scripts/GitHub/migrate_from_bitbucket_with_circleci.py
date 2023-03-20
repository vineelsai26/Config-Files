"""
* This script is used to migrate a repository from Bitbucket to GitHub
* and migrate circleci env variables from old project to new project.
* This needs to be run from CircleCI runner.
"""

import os
from json import JSONEncoder

import requests
from dotenv import load_dotenv

load_dotenv()

GITHUB_OWNER = os.environ.get("GITHUB_OWNER")
GITHUB_REPO = os.environ.get("GITHUB_REPO")
GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")

BITBUCKET_OWNER = os.environ.get("BITBUCKET_OWNER")
BITBUCKET_REPO = os.environ.get("BITBUCKET_REPO")
BITBUCKET_USERNAME = os.environ.get("BITBUCKET_USERNAME")
BITBUCKET_PASSWORD = os.environ.get("BITBUCKET_PASSWORD")


res = requests.post(
    f"https://api.github.com/orgs/{GITHUB_OWNER}/repos",
    headers={
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_TOKEN}",
        "X-GitHub-Api-Version": "2022-11-28"
    },
    json={
        "name": GITHUB_REPO,
        "private": True,
    },
    timeout=10
).json()

if res.get('full_name'):
    print(f"Successfully created repository {res.get('full_name')}")
else:
    print(f"Failed to create repository {res.get('message')}")

input("Disable actions from repo settings and Press Enter to continue...")

res = requests.put(
    f"https://api.github.com/repos/{GITHUB_OWNER}/{GITHUB_REPO}/import",
    headers={
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_TOKEN}",
        "X-GitHub-Api-Version": "2022-11-28"
    },
    json={
        "vcs": "git",
        "vcs_url": f"https://bitbucket.org/{BITBUCKET_OWNER}/{BITBUCKET_REPO}",
        "vcs_username": BITBUCKET_USERNAME,
        "vcs_password": BITBUCKET_PASSWORD,
    },
    timeout=10
).json()

print(res.get('status'))

input("Connect CircleCI to repo and Press Enter to continue...")

repoName = os.environ.get('CIRCLE_PROJECT_REPONAME')
newRepoName = os.environ.get('NEW_CIRCLE_PROJECT_REPONAME')

# Get Environment Variables from CircleCI
envvars = requests.get(
    f"https://circleci.com/api/v2/project/bb/{BITBUCKET_OWNER}/{repoName}/envvar",
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
        f'https://circleci.com/api/v2/project/gh/{GITHUB_OWNER}/{newRepoName}/envvar',
        headers={
            "Circle-Token": os.environ.get("CIRCLECI_TOKEN")
        },
        json={
            "name": envvar.get('variable'),
            "value": envvar.get('value')
        },
        timeout=10
    )
