[cmdletbinding()]

$ModuleName = "<%= $PLASTER_PARAM_ModuleName %>"

$SourceFolder = split-path $PSScriptRoot

Write-Verbose -Message "Working in $SourceFolder"

$Module = Get-ChildItem -Path $SourceFolder -Filter *.psd1 -Recurse |

    Where-Object {$_.FullName -notlike '*Output*'} |

    Select-String -Pattern 'RootModule' |

    Select-Object -First 1 -ExpandProperty Path

$Module = Get-Item -Path $Module

$OutputFolder = Join-Path -Path $($Module.Directory.FullName) -ChildPath $ModuleName

$null = New-Item -Path $OutputFolder -ItemType Directory -Force -Confirm:$false

$DestinationModule = Join-Path -Path $($Module.Directory.FullName) -ChildPath "$($ModuleName)\$($Module.BaseName).psm1"

$OutputManifest = Join-Path -Path $($Module.Directory.FullName) -ChildPath "$($ModuleName)\$($Module.BaseName).psd1"

Copy-Item -Path $Module.FullName -Destination $OutputManifest -Force



Write-Verbose -Message "Attempting to work with $DestinationModule"



if (Test-Path -Path $DestinationModule ) {

    Remove-Item -Path $DestinationModule -Confirm:$False -force

}


$Classes = Get-ChildItem -Path "$($SourceFolder)\Sources\" -Include 'Class', 'Classe', 'Classes' -Recurse -Directory | Get-ChildItem -recurse -Include *.ps1 -File

$Functions = Get-ChildItem -Path "$($SourceFolder)\Sources\" -Include 'Fonction', 'Functions', 'Fonctions', 'Function' -Recurse -Directory | Get-ChildItem -recurse -Include *.ps1 -File

$Enums = Get-ChildItem -Path "$($SourceFolder)\Sources\" -Include 'Enum', 'Enums' -Recurse -Directory | Get-ChildItem -Recurse -Include *.ps1 -File

Foreach ($Enum in $Enums) {

    Get-Content -Path $Enum.FullName | Add-Content -Path $DestinationModule

}
Write-Verbose -Message "Found $($Enums.Count) enums and added them to the psm1."

Foreach ($Class in $Classes) {

    Get-Content -Path $Class.FullName | Add-Content -Path $DestinationModule

}

Write-Verbose -Message "Found $($Classes.Count) classes and added them to the psm1."

Foreach ($Function in $Functions) {

    Get-Content -Path $Function.FullName | Add-Content -Path $DestinationModule

}

Write-Verbose -Message "Found $($Functions.Count) functions and added them to the psm1."


$FunctionNames = $Functions |

    Select-String -Pattern 'Function (\w+-\w+) {' -AllMatches |

    Foreach-Object {

    $_.Matches.Groups[1].Value

}

Write-Verbose -Message "Making $($FunctionNames.Count) functions available via Export-ModuleMember"


"Export-ModuleMember -Function $($FunctionNames -join ',')" | Add-Content -Path $DestinationModule

$Null = Get-Command -Module Configuration

Update-Metadata -Path $OutputManifest -PropertyName FunctionsToExport -Value $FunctionNames