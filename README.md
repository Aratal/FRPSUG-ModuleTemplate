---------------------------------
-REDACTION ET RELECTURE EN COURS-
---------------------------------

# Sommaire
`FRPSUG-Moduletemplate` est un template à utiliser avec [PLASTER](https://github.com/PowerShell/Plaster) pour déployer des modules standardisés.

Il s'agit d'un template créé par mes soins et pour une utilisation la plus large possible.
Le but étant de pouvoir l'utiliser dans le maximum de cas possible :
* simple module
* module plus complexe
* module avec intégration continu.

le travail sur le templage `FRPSUG-ModuleTemplate` n'est pas terminé mais il reste utilisable en l'état.

# Structure du template

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

# Utilisation

Pour utiliser le template il faut au prélable récupérer le repo Github sur votre ordianteur.
le module [PLASTER](https://github.com/PowerShell/Plaster) est indispensable pour l'utilisation du template.

Installation du module
``` Powershell
Install-Module Plaster -Scope CurrentUser -force
```

Création d'un module basé sur le template
``` Powershell
Invoke-Plaster -TemplatePath CheminVers\FRPSUG-ModuleTemplate -DestinationPath c:\temp
```

```
  ____  _           _
 |  _ \| | __ _ ___| |_ ___ _ __
 | |_) | |/ _` / __| __/ _ \ '__|
 |  __/| | (_| \__ \ ||  __/ |
 |_|   |_|\__,_|___/\__\___|_|
                                            v1.1.3
==================================================

Enter the name of the module: ModuleTest
```
Le module va être créé dans le repertoire donné en parametre à `DestinationPath`

```
Enter a description of the module (required for publishing to the PowerShell Gallery): Module test pour plaster
```
Cette description va être utilisée pour publier le module dans la PSGallery

```
Enter your full name (Laurent LIENHARD):

Enter your email address (laurent.lienhard@outlook.com):
```
Le nom et l'adresse email apparaitront dans le fichier psd1 du module. Par défaut ces 2 champs sont remplis par les donnèes de l'utilisateur local.

```
Enter the company name (None):
```
Nom de la compagnie. se retrouvera également dans le fichier psd1

```
Please select folders to include
[F] Functions [C] Classes [E] Enums [?] Help (default is "Functions, Classes, Enums"):
```
Par défaut les 3 répertoires vont être créés. C'est dans ces repertoires que seront déposés les sources de votre futur module. La tâche de buil récupére ces sources pour les compiler dans le module final. Nous en parlerons un peu plus loin.
Pour n'installer que les Functions et les Classes il faut répondre `f,c`

```Select a license for your module
[A] Apache [M] MIT [N] None [?] Help (default is "MIT"):
```
Je vous propose par défaut d'ajouter une licence Apache ou MIT au choix

```
Add UnitTests Folder
[Y] Yes [N] No [?] Help (default is "Yes"):
```
Est-ce qu'il faut créer un dossier pour les tests unitaires

```
Add Deploy Folder
[Y] Yes [N] No [?] Help (default is "Yes"):
```
Est-ce qu'il faut créer un dossier pour le deploiement du module

```
Which editor do you use
[I] ISE [C] Visual Studio Code [N] None [?] Help (default is "Visual Studio Code"):
```
Quel editeur faut-il utiliser

```
Add support for Github
[Y] Yes [N] No [?] Help (default is "Yes"):
```
Le support github ajoute des modèles de documents pour contribuer, ouvrir une issue ...

```
Add Docs Folder
[Y] Yes [N] No [?] Help (default is "Yes"):
```
Ajoute un dossier pour y mettre la documentation

```
Add Continous Integration Folder
[Y] Yes [N] No [?] Help (default is "Yes"):
```
Cette partie ajoute les scripts necessaire à [appveyor](https://www.appveyor.com/) pour faire l'intégration continu

Le résultat avec les choix par défaut et le suivant
```
Destination path: C:\temp
____________________________________

-> Creating your root folders for module : ModuleTest
____________________________________
   Create ModuleTest\

-> Creating module manifest
   Create ModuleTest\ModuleTest.psd1

-> Creating your source code folders
   Create ModuleTest\Sources\Functions\Private\
   Create ModuleTest\Sources\Functions\Private\.gitkeep
   Create ModuleTest\Sources\Functions\Public\
   Create ModuleTest\Sources\Functions\Public\.gitkeep
   Create ModuleTest\Sources\Classes\
   Create ModuleTest\Sources\Classes\.gitkeep
   Create ModuleTest\Sources\Enums\
   Create ModuleTest\Sources\Enums\.gitkeep

-> Creating UnitTests folder
   Create ModuleTest\UnitTests\

-> Copying UnitTests files
   Create ModuleTest\UnitTests\Manifest.Tests.ps1

-> Creating Licence file
   Create ModuleTest\Licenses\
   Create ModuleTest\Licenses\MIT.md

-> Creating Deploy folder
   Create ModuleTest\Deploy\

-> Copying Deploy files
   Create ModuleTest\Deploy\ModuleTest.PSDeploy.ps1

-> Creating VSCode folder and files
   Create ModuleTest\.vscode\settings.json
   Create ModuleTest\.vscode\launch.json
   Create ModuleTest\.vscode\PSScriptAnalyzerSettings.psd1

-> Creating Continous Integration folder
   Create ModuleTest\CI\

-> Copying Continous Integration files
   Create ModuleTest\CI\02_Install.ps1
   Create ModuleTest\CI\03_Build.ps1
   Create ModuleTest\CI\04_Tests.ps1
   Create ModuleTest\appveyor.yml
   Verify The required module Pester (minimum version: 3.4.0) is already installed.
   Verify The required module PSScriptAnalyzer is already installed.
   Verify The required module PSdeploy is already installed.
```
