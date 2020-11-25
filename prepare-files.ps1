function Redo-Scripts {
    param(
        [string]$Path
    )

    $testPath = Test-Path -Path $Path
    if (!$testPath) {
        Write-Output "Dir Not Found : $Path"
        return;
    }

    $outputFolder = Test-Path -Path $outputfolder
    if (!$outputFolder) {
        New-Item -ItemType Directory $outputFolder
    }
    
    Write-Output "Fetching Directory: $Path";
    Write-Output "Output   Directory: $Path";

    $filesCount = (Get-ChildItem -Path $Path | Measure-Object).Count

    Write-Output "Files Found       : $filesCount";

    Import-Objects -Path $Path -WithSqlPlus ($withsqlplus -eq 1)
}