import requests
from bs4 import BeautifulSoup
import os
import glob
import shutil
url = "https://mirror.mangohost.net/videolan/vlc/last/win64/"
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



# Get a list of all .exe files in the current directory
exe_files = glob.glob("*.exe")

# Rename all .exe files to vlc.exe
for file in exe_files:
    shutil.move(file, "vlc.exe")
