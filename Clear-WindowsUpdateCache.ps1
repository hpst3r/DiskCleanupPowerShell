Function Purge-Directory {
  param (
    [string] $Path
  )

  [string] $Name = (Split-Path $Path -LeafBase)
  [string] $NewPath = (Join-Path (Split-Path $Path -Parent) "$($Name).old")

  Write-Host "Purging directory: $Path"

  try { # cmdlets don't like long PATHs, cmd does not care

    Write-Host "Renaming $($Path) to $($NewPath) to sidestep locked files."

    # rename is sometimes necessary as SoftwareDistribution can sometimes be locked - a rename works regardless
    & cmd /c "ren $($Path) $($Name)"

    Write-Host "Deleting $($NewPath) recursively."
    
    # delete /S recursively, /F forces delete of read-only files, /Q quiet mode (no prompt)
    & cmd /c "del /S /F /Q $($NewPath)"

    Write-Host "Removing $($NewPath) directory."

    # delete /S recursively, /Q quiet mode (no prompt)
    & cmd /c "rmdir /S /Q $($NewPath)"

  }
  catch {

    Write-Error "Attempt to remove the  directory failed. Please check that nothing is accessing the directory (e.g. SpaceSniffer) and try again."

  }

}

Function Clear-WindowsUpdateCache {

  Write-Host "Stopping BITS, wuauserv, appidsvc, cryptsvc"

  Stop-Service -Name BITS
  Stop-Service -Name wuauserv
  Stop-Service -Name appidsvc
  Stop-Service -Name cryptsvc

  Purge-Directory -Path 'C:\Windows\SoftwareDistribution\'

  Write-Host "Starting BITS, wuauserv, appidsvc, cryptsvc"
 
  Start-Service -Name BITS
  Start-Service -Name wuauserv
  Start-Service -Name appidsvc
  Start-Service -Name cryptsvc

}

Clear-WindowsUpdateCache