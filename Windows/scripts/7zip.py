import requests
from bs4 import BeautifulSoup
import os

url = "https://www.7-zip.org/"
extension = ".exe"

response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

# Find all <a> tags with href attribute
links = soup.find_all('a', href=True)

for link in links:
    href = link['href']
    if href.endswith(extension):
        filename = os.path.basename(href)
        response = requests.get(url + "/" + href)
        if response.status_code == 200:
            with open(filename, 'wb') as f:
                f.write(response.content)
                print(f"File '{filename}' downloaded successfully.")
        else:
            print(f"Failed to download '{filename}'. Status code: {response.status_code}")
