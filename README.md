
# Sommaire
`FRPSUG-Moduletemplate` est un template à utiliser avec [PLASTER](https://github.com/PowerShell/Plaster) pour déployer des modules standardisés.

Il s'agit d'un template créé par mes soins et pour une utilisation la plus large possible.
Le but étant de pouvoir l'utiliser dans le maximum de cas possible :
* simple module
* module plus complexe
* module avec intégration continu.

le travail sur le templage `FRPSUG-ModuleTemplate` n'est pas terminé mais il reste utilisable en l'état.

# Structure

Les repertoires sont structurés de la façon suivante :
```
ROOT
|-CI
    |-02_Install.ps1
    |-03_Build.ps1
    |-04_Tests.ps1
|
|-Deploy
    |-template.PSDeploy.ps1
|
|-Github
    |-Bug_report.md
    |-contributing.md
    |-Feature_Request.md
    |-Pull_Request_template.md
|
|-Licenses
    |-Apache.md
    |-MIT.md
|
|-Sources
    |-Classes
    |-Enums
    |-Functions
        |-Private
        |-Public
|
|-UnitTests
    |-Manifest.Tests.ps1
|
|vscode
    |-launch.json
    |-PSScriptAnalyzerSettings.psd1
    |-settings.json
    |-tasks_pester.json
    |-tasks_psake_pester.json
    |-tasks_psake.json
|
|-appveyor.yml
```