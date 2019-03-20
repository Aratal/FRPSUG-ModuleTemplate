task Default -depends Tests

task Tests {
    ../CI/Tests.ps1
}