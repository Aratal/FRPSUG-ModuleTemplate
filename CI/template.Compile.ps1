$ErrorActionPreference = "Stop";

$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"
$Author = "<%= $PLASTER_PARAM_AuthorName %>"
$Manifest = ($ModuleName + ".psd1")

Write-Output "[BUILD][START] Launching Build Process : $($ModuleName)"

# Retrieve parent folder
$Current = $PSScriptRoot
$Root = ((Get-Item $Current).Parent).FullName
$ModuleFolderPath = Join-Path -Path $Root -ChildPath $ModuleName
$CodeSourcePath = Join-Path -Path $Root -ChildPath "Sources"
$ExportPath = Join-Path -Path $ModuleFolderPath -ChildPath ($ModuleName + ".psm1")

if (Test-Path $ExportPath) {
    Write-Output "[BUILD][PSM1] PSM1 file detected. Deleting..."
    Remove-Item -Path $ExportPath -Force
}
New-Item -Path $ExportPath -ItemType File -Force

Write-Output "[BUILD][Code] Loading Enums, Class, public and private functions"

$PublicEnums = Get-ChildItem -Path "$CodeSourcePath\Enums\" -Filter *.ps1 | sort-object Name
$PublicClasses = Get-ChildItem -Path "$CodeSourcePath\Classes\" -Filter *.ps1 | sort-object Name
$PrivateFunctions = Get-ChildItem -Path "$CodeSourcePath\Functions\Private" -Filter *.ps1
$PublicFunctions = Get-ChildItem -Path "$CodeSourcePath\Functions\Public" -Filter *.ps1

$MainPSM1Contents = @()
$MainPSM1Contents += $PublicEnums
$MainPSM1Contents += $PublicClasses
$MainPSM1Contents += $PrivateFunctions
$MainPSM1Contents += $PublicFunctions

#Creating PSM1
Write-Output "[BUILD][START][MAIN PSM1] Building main PSM1"

$Date = Get-Date
"#Generated at $($Date) by $($Author)" | out-File -FilePath $ExportPath -Encoding utf8 -Append

Foreach ($file in $MainPSM1Contents) {
    Get-Content $File.FullName | out-File -FilePath $ExportPath -Encoding utf8 -Append

}

Write-Output "[BUILD][START][PSD1] Adding functions to export"

$FunctionsToExport = $PublicFunctions.BaseName
Copy-Item -Path $root\$Manifest -Destination $ModuleFolderPath\$Manifest
$Manifest = Join-Path -Path $ModuleFolderPath -ChildPath $Manifest
if ($null -ne $FunctionsToExport) {
    Update-ModuleManifest -Path $Manifest -FunctionsToExport $FunctionsToExport
}

Write-Output "[BUILD][END][MAIN PSM1] building main PSM1 "

Write-Output "[BUILD][END]End of Build Process"