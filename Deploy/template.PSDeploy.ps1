$source = ""
$destination_dev =""
$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"

$source = $PSScriptRoot+"\..\"+$ModuleName
$destination_dev = [environment]::getfolderpath("mydocuments") + '\WindowsPowerShell\Modules\' + $ModuleName


Deploy ExampleDeployment {

    By FileSystem Scripts {

        FromSource $source
        To $destination_dev
        Tagged Dev
        WithOptions @{
            Mirror = $true
        }
    }
}

