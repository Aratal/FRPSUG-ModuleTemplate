
write-host "[INSTALL] Start" -ForegroundColor Red -BackgroundColor White
write-host "[INSTALL] Install core modules" -ForegroundColor Red -BackgroundColor White
Install-Module -Name PSScriptAnalyzer -Force  -Scope CurrentUser
Install-Module -Name Pester -Force  -Scope CurrentUser
Install-Module -Name PSake -Force  -Scope CurrentUser
Install-Module -Name PSDeploy -Force  -Scope CurrentUser
write-host "[INSTALL] End" -ForegroundColor Red -BackgroundColor White