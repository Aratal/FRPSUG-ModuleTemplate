$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"
$Author = "<%= $PLASTER_PARAM_AuthorName %>"           
$Manifest = ($ModuleName + ".psd1")   

Write-Host "[BUILD][START] Launching Build Process : $($ModuleName)" -ForegroundColor RED -BackgroundColor White

# Retrieve parent folder
$Current = (Split-Path -Path $MyInvocation.MyCommand.Path)
$Root = ((Get-Item $Current).Parent).FullName
$ModuleFolderPath = Join-Path -Path $Root -ChildPath $ModuleName

if (Test-Path $ModuleFolderPath) {
    $null = Remove-Item -Path $ModuleFolderPath -Force -Recurse -Confirm:$false
}
$null = New-Item -Path $ModuleFolderPath -ItemType Directory -Force -Confirm:$false

$CodeSourcePath = Join-Path -Path $Root -ChildPath "Sources"

$ExportPath = Join-Path -Path $ModuleFolderPath -ChildPath ($ModuleName + ".psm1")
if(Test-Path $ExportPath){
    Write-Host "[BUILD][PSM1] PSM1 file detected. Deleting..." -ForegroundColor RED -BackgroundColor White
    Remove-Item -Path $ExportPath -Force
}
$DAte = Get-DAte
"#Generated at $($Date) by $($Author)" | out-File -FilePath $ExportPath -Encoding utf8 -Append

Write-Host "[BUILD][Code] Loading Enums, Class, public and private functions" -ForegroundColor RED -BackgroundColor White

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
Write-Host "[BUILD][START][MAIN PSM1] Building main PSM1" -ForegroundColor RED -BackgroundColor White
Foreach($file in $MainPSM1Contents){
    Get-Content $File.FullName | out-File -FilePath $ExportPath -Encoding utf8 -Append
    
}

Write-Host "[BUILD][START][PSD1] Adding functions to export" -ForegroundColor RED -BackgroundColor White

$FunctionsToExport = $PublicFunctions.BaseName
Copy-Item -Path $root\$Manifest -Destination $ModuleFolderPath\$Manifest
$Manifest = Join-Path -Path $ModuleFolderPath -ChildPath $Manifest
Update-ModuleManifest -Path $Manifest -FunctionsToExport $FunctionsToExport

Write-Host "[BUILD][END][MAIN PSM1] building main PSM1 " -ForegroundColor RED -BackgroundColor White

Write-Host "[BUILD][END]End of Build Process" -ForegroundColor RED -BackgroundColor White