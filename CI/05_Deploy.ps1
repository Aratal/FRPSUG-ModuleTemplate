param(
    [ValidateSet("Dev","Prod", "Gallery","Support")][string]$Tag = "Dev"
)

$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"

if (!(Get-Module -ListAvailable -Name PSDeploy)) {
    Install-Module -Name PSDeploy -Scope CurrentUser -Confirm:$false -AllowClobber -Force
}
Import-Module PSDeploy

$source  =   $PSScriptRoot +'\..\Deploy\'+ $ModuleName +'.PSDeploy.ps1'

Invoke-PSDeploy -Path $source -tag $Tag -Force
