# Remove C:\ProgramData\Dell directory if it exists, which may contain logs or other data that can be safely removed.
Function Remove-ProgramDataDell {

  $Path = 'C:\ProgramData\Dell'

  Stop-Service -Name 'Dell Digital Delivery Services' # Digital Delivery Services
  Stop-Service -Name 'Dell SupportAssist Remediation' # SAR
  Stop-Service -Name 'DellClientManagementService' # DCMS
  Stop-Service -Name 'DellTechHub' # Dell Tech Hub
  Stop-Service -Name 'FusionService' # Dell Fusion Service

  try {

    Write-Host "Removing $($Path) directory..."

    Write-Host "Attempting to recursively take ownership of $($Path)..."

    takeown.exe /f $Path /r /d y

    Write-Host "Granting full control to SYSTEM for $($Path)..."

    icacls.exe $Path /grant system:F /t

    Write-Host "Removing $($Path) recursively..."

    Remove-Item -Path $Path -Recurse -Force

  } catch {

    Write-Error "Failed to remove $($Path): $($_)"

  }

}

Remove-ProgramDataDell

cmd -c 'rmdir /s /q $Path'