import asyncio
import os
import shutil
import wget
from fortune import fortune

filePath = 'ChromeStandaloneSetup64.exe';
Dir='repos';
if os.path.exists(Dir):
  shutil.rmtree(Dir)
if os.path.exists(filePath):
  os.remove(filePath)
url = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BCEC27557-0338-A6BE-F10F-A625517C44BB%7D%26lang%3Dzh-CN%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dx64-stable%26installdataindex%3Ddefaultbrowser/update2/installers/ChromeStandaloneSetup64.exe'
filename = wget.download(url)
from directory_downloader import DDownloader
async def main():
    url = "https://bmrf.org/repos/tron/"
    downloader = DDownloader()
    await downloader.crawl(url)  # fetch all the links from /directory/
    await downloader.download_files()  # download all files to current directory
print(fortune())
if __name__ == '__main__':
    asyncio.run(main())



$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)
