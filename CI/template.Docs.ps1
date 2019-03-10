$ErrorActionPreference = "Stop";

$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"
$Current = $PSScriptRoot
$Root = ((Get-Item $Current).Parent).FullName
$MarkdownPath = Join-Path -Path $Root -ChildPath $ModuleName\Docs\EN-US
#$HelpFilePath = Join-Path -Path $Root -ChildPath $ModuleName\Docs

try {
    Import-module $ModuleName
}
catch {
    Write-Output "[DOCS] the $ModuleName module is not available : Compile and Deploy module First !"
    . $Root\CI\Clean.ps1
    . $Root\CI\Compile.ps1
    . $Root\CI\Deploy.ps1
}

Write-Output "[DOCS]Start the documentation generation" 
Write-Output "[DOCS]Generation of markdown files"
New-MarkdownHelp -Module $ModuleName -OutputFolder $MarkdownPath -Force

#New-ExternalHelp -Path $MarkdownPath -OutputPath $HelpFilePath -ShowProgress -Force

