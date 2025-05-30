# clear the Windows Search Indexer's cache C:\ProgramData\Microsoft\Search\Data\Applications\Windows
function Clear-SearchIndex {
  
  Stop-Service -Name WSearch
  
  Remove-Item `
    -Path 'C:\ProgramData\Microsoft\Search\Data\Applications\Windows\' `
    -Recurse `
    -Force

  Start-Service WSearch
  
}

Clear-SearchIndex