$ErrorActionPreference = "Stop";

Write-Output "[TEST][START]"
import-module pester
start-sleep -seconds 2
$Current = $PSScriptRoot
$Root = ((Get-Item $Current).Parent).FullName

#Pester Tests
write-verbose "invoking pester"
$res = Invoke-Pester -Path "$Root\UnitTests" -OutputFormat NUnitXml -OutputFile $Root\UnitTests\TestsResults.xml -PassThru -CodeCoverage $Root\<%= $PLASTER_PARAM_ModuleName %>\<%= $PLASTER_PARAM_ModuleName %>.psm1

if ($res.FailedCount -gt 0 -or $res.PassedCount -eq 0) {
    throw "$($res.FailedCount) tests failed - $($res.PassedCount) successfully passed"
};

Write-Output "[TEST][END]"