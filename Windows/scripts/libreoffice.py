import subprocess
import os
import wget
import shutil
from clint.textui import progress
import requests
Arch="/x86_64"
ARCH="X86_64"
ARCH_FILE = 'x86-64'
PACK = '/win'
Packs = 'Win'
stable = "stable/"
SERVER = 'https://download.documentfoundation.org/libreoffice/'
VER = subprocess.check_output('curl -s https://www.libreoffice.org/download/download-libreoffice/ | grep dl_download_link | head -1 | cut -d\\" -f 4 | cut -d/ -f 7', shell=True).decode().strip()
SERVER_PATH = f'{SERVER}stable/{VER}/{PACK}/{ARCH}'
MAIN_FILE = f'LibreOffice_{VER}_{Packs}_{ARCH_FILE}.msi'
fname = MAIN_FILE
url = SERVER + stable + VER + PACK + Arch + '/' + MAIN_FILE

r = requests.get(url, stream=True)
with open(fname, 'wb') as f:
    total_length = int(r.headers.get('content-length'))
    for chunk in progress.bar(r.iter_content(chunk_size=1024), expected_size=(total_length/1024) + 1): 
        if chunk:
            f.write(chunk)
            f.flush()
            print(url)
