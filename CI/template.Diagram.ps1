$ErrorActionPreference = "Stop";

$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"
$Current = $PSScriptRoot
$Root = ((Get-Item $Current).Parent).FullName
$CodeSourcePath = Join-Path -Path $Root -ChildPath "Sources"

$PublicClasses = Get-ChildItem -Path "$CodeSourcePath\Classes\" -Filter *.ps1 | sort-object Name

if (!($null -eq $PublicClasses)) {
    Write-Output "[DIAGRAM][START] Launching Diagram Generation : $($ModuleName)"
    if (test-path -Path "$Root\Docs\Diagrams") {
        Write-Output "[DIAGRAM] Old Diagrams found => Suppress"
        Remove-item -Path "$Root\Docs\Diagrams" -force -recurse -confirm:$false
    }
    New-Item -Path "$Root\Docs\Diagrams" -ItemType Directory -Force -confirm:$false

    Foreach ($file in $PublicClasses) {
        Write-Output "[DIAGRAM] Generate Diagram for $File"
        Write-CUClassDiagram -Path $file.FullName -ExportFolder "$Root\Docs\Diagrams" -OutputFormat png -IgnoreCase -ShowComposition
    }

    Write-Output "[DIAGRAM] Generate Generic Diagram"
    Write-CUClassDiagram -Path "$Root\Sources" -Recurse -ExportFolder "$Root\Docs\Diagrams" -OutputFormat png -ShowComposition
} else {
    Write-Output "[DIAGRAM] No classes found in the directory $CodeSourcePath\Classes"
}
