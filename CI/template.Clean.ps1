$ErrorActionPreference = "Stop";

Write-output "[CLEAN] START"
Write-Output "[CLEAN] Suppress build module if exist"

$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"
$Current = $PSScriptRoot
$Root = ((Get-Item $Current).Parent).FullName
$ModuleFolderPath = Join-Path -Path $Root -ChildPath $ModuleName

if (test-path -Path $ModuleFolderPath) {
    Write-Output "[CLEAN] Pre-build module find => Suppress"
    Remove-item -Path $ModuleFolderPath -force -recurse -confirm:$false
}
$null = New-Item -Path $ModuleFolderPath -ItemType Directory -Force -Confirm:$false
Write-Output "[CLEAN] END"