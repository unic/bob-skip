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
        [string] $Version,
        [Parameter(Mandatory=$true, ParameterSetName ="InstallPackage")]
        [NuGet.IPackage] $Package,
        [string] $ProjectPath,
        [bool] $RemoveFiles = $false
    )
    Process
    {
        if(-not $Package) {
            $packages = Get-NugetPackage $PackageId $ProjectPath

            if($Version) {
                $packageToInstall = $packages | ? {$_.Version -eq $version}
            }
            else {
                $packageToInstall = $packages | sort {$_.Version} | select -last 1
            }
            if(-not $packageToInstall) {
                Write-Error "Package $packageId with version $version not found"
            }
        }
        else {
            $packageToInstall = $Package
        }
        $outputFileSystem = New-Object NuGet.PhysicalFileSystem $OutputLocation
        if ($RemoveFiles) {
            $outputFileSystem.DeleteFiles($packageToInstall.GetFiles(), $OutputLocation)
        }
        $outputFileSystem.AddFiles($packageToInstall.GetFiles(), $OutputLocation)
    }
}
