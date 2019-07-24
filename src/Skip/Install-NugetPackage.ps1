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

.PARAMETER Package
The package to install.

.PARAMETER ProjectPath
The path to the website project containing e.g. the Bob.config.

.PARAMETER RemoveFiles
If yes, every file contained in the package to install is removed before the
package is extracted to the filesystem.

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
        [string] $Version
    )
    Process {

        $nuget = ResolvePath -PackageId "NuGet.CommandLine" -RelativePath "tools\NuGet.exe"

        if($Version) {
            & $nuget install $PackageId -ExcludeVersion -PreRelease -NonInteractive -Version $Version
        } else {
            & $nuget install $PackageId -ExcludeVersion -PreRelease -NonInteractive        
        }

        if(Test-Path $PackageId) {
            Get-ChildItem -Path $PackageId -Exclude *.nupkg | Copy-Item -Destination $OutputLocation -Force
            Remove-Item -Path $PackageId -Recurse -Force
        }

    }
}
