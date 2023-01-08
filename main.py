import os
import gkeepapi
import requests
from dotenv import load_dotenv
from config import repos

load_dotenv()

keep = gkeepapi.Keep()
keep.login(os.environ['EMAIL'], os.environ['PASSWORD'])

for repo in repos.items():
    title = repo[1]['title']

    notes = list(keep.find(query=title, trashed=False))
    label = keep.findLabel("Projects")

    for i in notes:
        if i.title == title:
            note = i
            break
    else:
        note = keep.createList(title, [])

    if label and not note.labels.get(label.id):
        note.labels.add(label)

    issues = requests.get(
        f"https://api.github.com/repos/{repo[0]}/issues?state=all",
        headers={
            "Accept": "application/vnd.github.v3+json",
            "Authorization": f"Bearer {os.environ['GITHUB_TOKEN']}"
        },
        timeout=5
    ).json()

    for issue in issues:
        item = f"{issue['title']} - {issue['html_url']}"
        for listItem in note.items:
            if listItem.text == item:
                listItem.checked = (issue['state'] == 'closed')
                break
        else:
            note.add(
                item,
                checked=(issue['state'] == 'closed')
            )


keep.sync()
