$ErrorActionPreference = "Stop";

Write-Output "[INSTALL] Start"

if (!(Get-Module -ListAvailable -Name Pester | Where-Object { $_.Version -eq '4.7.1' })) {
    Write-Output "[INSTALL] Pester"
    Install-Module -Name pester -MinimumVersion 4.7.1 -Scope CurrentUser -Force -Confirm:$false
}

if (!(Get-Module -ListAvailable -Name PlatyPS | Where-Object { $_.Version -eq '0.12.0' })) {
    Write-Output "[INSTALL] PlatyPS"
    Install-Module -Name PlatyPS -MinimumVersion 0.12.0 -Scope CurrentUser -Force -Confirm:$false
}

if (!(Get-Module -ListAvailable -Name PSDeploy | Where-Object { $_.Version -eq '1.0.1' })) {
    Write-Output "[INSTALL] PSDeploy"
    Install-Module -Name PSDeploy -MinimumVersion 1.0.1 -Scope CurrentUser -Force -Confirm:$false
}

if (!(Get-Module -ListAvailable -Name PSScriptAnalyzer | Where-Object { $_.Version -eq '1.17.1' })) {
    Write-Output "[INSTALL] PSSCriptAnalyser"
    Install-Module -Name PSScriptAnalyzer -MinimumVersion 1.17.1 -Scope CurrentUser -Force -Confirm:$false
}

if (!(Get-Module -ListAvailable -Name PSClassUtils | Where-Object { $_.Version -eq '2.2.6' })) {
    Write-Output "[INSTALL] PSClassUtils"
    Install-Module -Name PSClassUtils -MinimumVersion 2.2.6 -Scope CurrentUser -Force -Confirm:$false
    Import-module PSClassUtils
    Install-PackageProvider -Name Chocolatey -force;
    Register-PackageSource -Name Chocolatey -ProviderName Chocolatey -Location http://chocolatey.org/api/v2/ -Force -Trusted;
    Find-Package graphviz -Source "http://chocolatey.org/api/v2/"  | Install-Package -ForceBootstrap -Force;
    Start-Sleep -Seconds 2;

    Install-PackageProvider -Name NuGet -Force -Scope "CurrentUser";
    Install-Module -Name PSGraph -Force -verbose -Scope "CurrentUser";
}
Write-Output "[INSTALL] End"