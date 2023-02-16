"""
* This script is used to migrate a repository from Bitbucket to GitHub.
"""

import os

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


res = requests.put(
    f"https://api.github.com/repos/{GITHUB_OWNER}/{GITHUB_REPO}/import",
    headers={
        "Accept": "application/vnd.github+json",
        "Authorization": f"Bearer {GITHUB_TOKEN}",
        "X-GitHub-Api-Version": "2022-11-28"
    },
    data={
        "vcs": "git",
        "vcs_url": f"https://bitbucket.org/{BITBUCKET_OWNER}/{BITBUCKET_REPO}",
        "vcs_username": BITBUCKET_USERNAME,
        "vcs_password": BITBUCKET_PASSWORD,
    },
    timeout=10
).json()

print(res)
