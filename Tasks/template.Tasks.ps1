task Clean {
    Invoke-psake -buildFile "Clean.Tasks.ps1"
}

task Install -depends Clean {
    Invoke-psake -buildFile "Install.Tasks.ps1"
}

task Compile -depends Install {
    Invoke-psake -buildFile "Compile.Tasks.ps1"
}

task Deploy -depends Compile {
    Invoke-psake -buildFile "Deploy.Tasks.ps1"
}

task Tests -depends Deploy {
    Invoke-psake -buildFile "Tests.Tasks.ps1"
}

task Diagram -depends Compile {
    Invoke-psake -buildFile "Diagram.Tasks.ps1"
}

task Docs -depends Deploy {
    Invoke-psake -buildFile "Docs.Tasks.ps1"
}