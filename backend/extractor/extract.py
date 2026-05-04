import requests
import csv

url = "http://localhost:7700/indexes/contracts/documents?limit=10000"
headers = {"Authorization": "Bearer YOUR_MASTER_KEY"}

data = requests.get(url, headers=headers).json()

docs = data["results"] if "results" in data else data

with open("contracts.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=docs[0].keys())
    writer.writeheader()
    writer.writerows(docs)

print("Exported to contracts.csv")