add-type -AssemblyName System.Data.OracleClient

#scripts base directory
$dir = "./temp/db";

$global:appSettings = @{}

$configFile = "./ps.config"

if (Test-Path $configFile) {
    Try {
        $config = [xml](get-content $configFile)
        foreach ($addNode in $config.configuration.appsettings.add) {
            if ($addNode.Value.Contains(',')) {
                $value = $addNode.Value.Split(',')
                for ($i = 0; $i -lt $value.length; $i++) { 
                    $value[$i] = $value[$i].Trim()
                }
            }
            else {
                $value = $addNode.Value
            }
            $global:appSettings[$addNode.Key] = $value
        }
    }
    Catch [system.exception] {
        
    }
}
else {
    Write-Error -Message "Config dosyası okunamadı." -Category ReadError
}

$username = $global:appSettings["username"]
$password = $global:appSettings["password"]
$data_source = $global:appSettings["data_source"]
$connection_string = "User Id=$username;Password=$password;Data Source=$data_source"

$objects = @(
    "$dir/SCRIPT/BEFORE_UPDATE"
    , "$dir/H4A/VIEW"
    , "$dir/H4A/FUNCTION"
    , "$dir/H4A/PROCEDURE"
    , "$dir/H4A/TYPE_SPEC"
    , "$dir/H4A/TYPE_BODY"
    , "$dir/H4A/TRIGGER"
    , "$dir/H4A/PACKAGE_SPEC"
    , "$dir/H4A/PACKAGE_BODY"
    , "$dir/SCRIPT/AFTER_UPDATE"
)