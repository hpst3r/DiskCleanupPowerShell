$DownloadUri = 'https://github.com/windirstat/windirstat/releases/download/release/v2.2.2/WinDirStat.zip'
$WorkingDirectory = (Join-Path $env:TEMP (Get-Date -UFormat %s))
$Archive = (Join-Path $WorkingDirectory 'wds.zip')
$Directory = (Join-Path $WorkingDirectory 'wds')

Invoke-WebRequest -Uri $DownloadUri -Outfile $Archive -Method GET

Expand-Archive -Path $Archive -DestinationPath $Directory

Start-Process -FilePath (Join-Path $Directory -ChildPath 'x64' -AdditionalChildPath 'WinDirStat.exe') -Wait