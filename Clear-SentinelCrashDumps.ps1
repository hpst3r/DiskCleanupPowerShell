Function Clear-SentinelCrashDumps {
  
  Write-Host "Clearing Sentinel Crash Dumps..."
  
  $CrashDumpPath = 'C:\ProgramData\Sentinel\CrashDumps'
  
  if (Test-Path -Path $CrashDumpPath) {

    try {

      Remove-Item -Path $CrashDumpPath -Recurse -Force

      Write-Host "Sentinel Crash Dumps cleared successfully."

    } catch {

      Write-Error "Failed to clear Sentinel Crash Dumps: $($_)"

    }

  } else {

    Write-Host "No Sentinel Crash Dumps found at $($CrashDumpPath)."

  }

}

Clear-SentinelCrashDumps