properties {
    $DeployType
}

task default -depends Deploy

task Deploy {
    if ($null -eq $DeployType) {
        $DeployType = "DEV"
    }
    ../CI/Deploy.ps1 -DeployType $DeployType
}