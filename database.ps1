$global:con = New-Object System.Data.OracleClient.OracleConnection($connection_string)

function Push-Database {
    param(
        [string]$Query
    )
    try {        
        $cmd = $con.CreateCommand()
        $cmd.CommandText = $Query

        return $cmd.ExecuteNonQuery()
    }
    catch {
        throw $_.Exception.ToString()
    }
    finally {        
    }
}

function Import-Objects {
    param(
        [string]$Path
    )
    $scripts = Get-ChildItem -Path $Path
    try {
        $con.Open()
        foreach ($script in $scripts) {

            $content = Get-Content -Path "$Path/$script"
            $content = $content -replace "/", ""
            
            #$res = Push-Database -query $content   !!!
        
            Write-Output "$script > executed $res"
        }        
    }
    catch {
        Write-Error ("Execution Exception: `n{1}" -f ` $_.Exception.ToString())
    }
    finally {
        if ($con.State -eq 'Open') {
            $con.close() 
        }
    }
}