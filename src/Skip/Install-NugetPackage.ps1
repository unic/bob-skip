<#
.SYNOPSIS
Installs the specified NuGet package to the specified location.

.DESCRIPTION
Downloads and extracts the specified NuGet package to a specified location.
A Nuget package can be specified by either passing the package id and the version
or by passing directly the package-object.

.PARAMETER PackagId
The id of the package to install.

.PARAMETER OutputLocation
The location where the content of the package will be extracted to.

.PARAMETER Version
The version of the package to install.
If none is specified, the newest prerelease will be installed.

.PARAMETER Source
The source feed url to use

.EXAMPLE
Install-NugetPackage -PackageId Unic.Bob.Keith D:\temp\Keith

#>
function Install-NugetPackage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, ParameterSetName ="FindPackage")]
        [string] $PackageId,
        [Parameter(Mandatory=$true)]
        [string] $OutputLocation,
        [Parameter(ParameterSetName ="FindPackage")]
        [string] $Version,
        [Parameter(ParameterSetName ="FindPackage")]
        [string] $Source
    )
    Process {

        $nuget = ResolvePath -PackageId "NuGet.CommandLine" -RelativePath "tools\NuGet.exe"

        $args = ("install", $PackageId, "-ExcludeVersion", "-PreRelease", "-NonInteractive")
        $args = $args + @("-OutputDirectory", $OutputLocation)
        if($Version) {
            $args = $args + @("-Version", $Version)
        }
        if($Source) {
            $args = $args + @("-Source", $Source)
        }
        & $nuget $args | Out-Null

        $InstallPath = Join-Path $OutputLocation $PackageId

        if(Test-Path $InstallPath) {
            Get-ChildItem -Path $InstallPath -Exclude *.nupkg | Copy-Item -Destination $OutputLocation -Recurse -Force
            Remove-Item -Path $InstallPath -Recurse -Force
        }

    }
}
