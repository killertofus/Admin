# Find the current download link
$url1 = "https://www.videolan.org/vlc/download-windows.html"
$response1 = Invoke-WebRequest -Uri $url1
#
# response1 contains a bunch of links, find the ones with ".msi", return the First one.
$url2 = $response1.Links | Where-Object { $_.href -match ".msi"} | Select-Object href -First 1
$url2.href  # Should be something like "//get.videolan.org/vlc/3.0.18/win32/vlc-3.0.18-win32.msi"
$response2 = Invoke-WebRequest -Uri ("https:" + $url2.href) # Href is missing the protocol so add it back.
#
# response2 contains a bunch of links to Mirror sites, find the First one containing ".msi".
$url3 = $response2.Links | Where-Object { $_.href -match ".msi"} | Select-Object href -First 1
$url3.href # Should be something like "https://mirror.aarnet.edu.au/pub/videolan/vlc/3.0.18/win32/vlc-3.0.18-win32.msi"
$filename = Split-Path $url3.href -Leaf # Gets the last part of the URL as the filename.
#
$ProgressPreference = 'SilentlyContinue' # Disables the progress meter, showing the progress is incredibly slow
Invoke-WebRequest -Uri $url3.href -OutFile $filename
#
MsiExec.exe /x %filename.msi /qn

