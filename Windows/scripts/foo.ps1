# Set variables
$Arch = "/x86_64"
$ARCH = "X86_64"
$ARCH_FILE = 'x86-64'
$PACK = '/win'
$Packs = 'Win'
$stable = "stable/"
$SERVER = 'https://download.documentfoundation.org/libreoffice/'

# Get LibreOffice version
$VER = (Invoke-WebRequest -Uri "https://www.libreoffice.org/download/download-libreoffice/" | Select-String -Pattern 'dl_download_link' -Context 0,1 | Select-String -Pattern 'href="(.+?)"' | ForEach-Object { $_.Matches.Groups[1].Value.Split('/')[6] }).Trim()

$SERVER_PATH = "$SERVER$stable$VER$PACK$Arch"
$MAIN_FILE = "LibreOffice_$VER_$Packs_$ARCH_FILE.msi"
$fname = $MAIN_FILE
$url = "$SERVER$stable$VER$PACK$Arch/$MAIN_FILE"

# Download MSI file
Invoke-WebRequest -Uri $url -OutFile $fname

# Move MSI file
$exe_file = Get-ChildItem -Filter "*.msi"
foreach ($file in $exe_file) {
    Move-Item -Path $file.FullName -Destination "libreoffice.msi"
}
