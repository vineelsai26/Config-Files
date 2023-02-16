"""
* This script will fetch all the repositories from the Bitbucket account and 
* print the ones that are updated in the last 180 days.
"""

import os
from datetime import datetime, timedelta

import requests
from dotenv import load_dotenv

load_dotenv()

count = 1
while True:
    print(f'################ Page: {count} ################')
    res = requests.get(
        f'https://api.bitbucket.org/2.0/repositories/ElucidataInc?pagelen=100&page={count}',
        headers={
            "Authorization": f"Basic {os.environ.get('BASE64_ENCODED_BITBUCKET_CREDENTIALS')}"
        },
        timeout=10
    ).json()

    for value in res.get('values'):
        if (datetime.now() - datetime.strptime(value.get('updated_on').split("T")[0], "%Y-%m-%d")) < timedelta(days=180):
            print(value.get('name'))

    if res.get('next') is None:
        break

    count += 1
