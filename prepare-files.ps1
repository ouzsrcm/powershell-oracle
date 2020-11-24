function Redo-Scripts {
    param(
        [string]$Path
    )

    $testPath = Test-Path -Path $Path
    if (!$testPath) {
        Write-Output "Dir Not Found : $Path"
        return;
    }
    
    Write-Output "Fetching Directory: $Path";

    $filesCount = (Get-ChildItem -Path $Path | Measure-Object).Count

    Write-Output "Files Found       : $filesCount";

    Import-Objects -Path $Path
}