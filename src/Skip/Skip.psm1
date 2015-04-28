$PSScriptRoot = Split-Path  $script:MyInvocation.MyCommand.Path

$ErrorActionPreference = "Stop"

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1 | Foreach-Object{ . $_.FullName }
Export-ModuleMember -Function * -Alias *

function ResolvePath() {
    param($PackageId, $RelativePath)
    $paths = @("$PSScriptRoot\..\..\packages", "$PSScriptRoot\..\tools\packages")
    foreach($packPath in $paths) {
        $path = Join-Path $packPath "$PackageId\$RelativePath"
        if((Test-Path $packPath) -and (Test-Path $path)) {
            Resolve-Path $path
            return
        }
    }
    Write-Error "No path found for $RelativePath in package $PackageId"
}


Import-Module (ResolvePath "Unic.Bob.Config" "tools\BobConfig")
$nuget = [System.IO.File]::ReadAllBytes((ResolvePath "NuGet.CommandLine" "tools\nuget.exe"))
[System.Reflection.Assembly]::Load($nuget)
