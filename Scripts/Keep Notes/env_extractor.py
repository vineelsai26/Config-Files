"""
* Environment variables extractor
* This script is used to extract env variables from .env files and upload them to Google Keep.
"""

import os
import gkeepapi
from dotenv import load_dotenv

load_dotenv()

keep = gkeepapi.Keep()
keep.login(os.environ.get("EMAIL"), os.environ.get("PASSWORD"))

folder = "D:\\GoogleDrive\\GitHub"

if os.path.exists(folder):
    for i in os.listdir(folder):
        if os.path.exists(f"{folder}/{i}/.env"):
            title = f"Environment variables for {i}"
            body = ""

            with open(f"{folder}/{i}/.env", "r", encoding="utf-8") as f:
                for line in f:
                    body += line

            body = body.strip()

            notes = list(keep.find(query=title, trashed=False))

            for note in notes:
                print(note.title + " Updated")
                note.trash()

            label = keep.findLabel("Environment Variables")

            note = keep.createNote(title, body)

            note.labels.add(label)
            note.archived = True
            note.color = gkeepapi.node.ColorValue.Gray

keep.sync()
