import os

from dotenv import load_dotenv
from pymongo import MongoClient

load_dotenv()

CONNECTION_STRING = os.getenv("NEXT_MONGODB_URL")

client = MongoClient(CONNECTION_STRING)

collection = client["articals"]["articles"]

items = collection.find({})

# print(items)

for item in items:
    if str(item["imageUrl"]).startswith("/"):
        print(item["imageUrl"])
        newImageUrl = "https://static.vineelsai.com/blog" + item["imageUrl"]
        print(newImageUrl)
        collection.update_one({"_id": item["_id"]}, {"$set": {"imageUrl": newImageUrl}})

    item["longDescription"] = str(item["longDescription"]).replace(
        "](/images", "](https://static.vineelsai.com/blog/images"
    )

    collection.update_one(
        {"_id": item["_id"]}, {"$set": {"longDescription": item["longDescription"]}}
    )
