import requests
from bs4 import BeautifulSoup
import os
import glob
import shutil
import pretty_errors
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


# Get a list of all .exe files in the current directory
exe_files = glob.glob("*-x64.exe")
exe_file = glob.glob("*.exe")
# Rename all .exe files to 7zip.exe
for file in exe_files:
    shutil.move(file, "7zip.exe")

for file in glob.glob("*.exe"):
  os.remove(file)
