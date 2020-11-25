$global:con = New-Object System.Data.OracleClient.OracleConnection($connection_string)

function Push-Database {
    param([string]$Query)
    try {
        $cmd = $con.CreateCommand()
        $cmd.CommandText = $Query
        return $cmd.ExecuteNonQuery()
    }
    catch {
        Write-Error ("Execution Error : `n{1}" -f $_.Exception.ToString())
    }
    finally {        
    }
}

function Push-Database-SqlPlus {
    param(
        [string]
        [parameter(Mandatory = $true)]
        $Username,
        [SecureString]
        [parameter(Mandatory = $true, ParameterSetName = "Password")]
        $Password,
        [string]
        $Tns,
        [string]
        [parameter(Mandatory = $true)]
        $Script,
        [string]
        [parameter(Mandatory = $true)]
        $Outputfile
    )

    try {
        sqlplus $Username/$Password@$Tns "$Script" | Out-File $Outputfile
    }
    catch {
        Write-Error ("Execution Error -sqlplus : `n{1}" -f $_.Exception.ToString())
    }
}

function Import-Objects {
    param(
        [parameter(Mandatory = $true, ParameterSetName = "Path")]
        [string]
        $Path,

        [bool]
        [parameter(Mandatory = $true, ParameterSetName = "WithSqlPlus")]
        $WithSqlPlus
    )
    
    $scripts = Get-ChildItem -Path $Path
    try {
        if ($WithSqlPlus) {
            foreach ($script in $scripts) {
                $outputfile = "$outputfile/$script"
                Push-Database-SqlPlus -Username $username -Password $password -Tns $data_source -Script $script -Outputfile $outputfile
                Write-Output "$script > executed $res"
            }
        }
        else {
            $con.Open()
            foreach ($script in $scripts) {
                $content = Get-Content -Path "$Path/$script"
                $content = $content -replace "/", ""            
                $res = Push-Database -query $content                    
                Write-Output "$script > executed $res"
            }
            if ($con.State -eq 'Open') {
                $con.close() 
            }
        }
    }
    catch {
        Write-Error ("Execution Exception: `n{1}" -f $_.Exception.ToString())
    }
    finally {
        #TODO : logs
    }
}