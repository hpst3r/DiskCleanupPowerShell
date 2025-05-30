<#
.SYNOPSIS
Removes temporary files from all user profiles and the system temporary directory.

.EXAMPLE
Remove-TemporaryFiles

#>
Function Remove-TemporaryFiles {

  $SystemTemp = 'C:\Windows\Temp'
  $UserLocalTemp = 'AppData\Local\Temp'

  foreach ($User in (Get-ChildItem -Path 'C:\Users' -Directory)) {
    
    $TempPath = Join-Path -Path $User.FullName -ChildPath $UserLocalTemp
      
    if (Test-Path -Path $TempPath) {

      Write-Host "Temporary files found for user: $($User.Name)."

    try {

      Write-Host "Clearing temporary files for user: $($User.Name)..."

      Remove-Item -Path "$TempPath\*" -Recurse -Force

      Write-Host "Cleared temporary files for user: $($User.Name)."

    } catch {

      Write-Error "Failed to clear temporary files for user: $($User.Name). Error: $($_.Exception.Message)."

    }

    } else {

      Write-Host "No temporary files found for user: $($User.Name)."

    }

  }
  
  Write-Host "Clearing system temporary files at $($SystemTemp)..."

  Remove-Item -Path 'C:\Windows\Temp\*' -Recurse -Force -ErrorAction SilentlyContinue

  Write-Host "Cleared system temporary files at $($SystemTemp)."

}

Remove-TemporaryFiles