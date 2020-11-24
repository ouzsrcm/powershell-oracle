
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
try {
    . ("$ScriptDirectory\defines.ps1")
    . ("$ScriptDirectory\database.ps1")
    . ("$ScriptDirectory\prepare-files.ps1")
}
catch {
    Write-Host "Error while loading supporting PowerShell Scripts" 
}

#https://codingbee.net/powershell/powershell-run-sql-queries-using-sqlplus

foreach ($item in $objects) {
    Redo-Scripts -Path $item
}