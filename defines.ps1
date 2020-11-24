add-type -AssemblyName System.Data.OracleClient

#scripts base directory
$dir = "./temp/db";

$username = "h4a"
$password = "h4a"
$data_source = "h4a_mapfre"
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