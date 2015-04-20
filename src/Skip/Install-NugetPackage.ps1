<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

#>
function Install-NugetPackage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $PackageId,
        [Parameter(Mandatory=$true)]
        [string] $OutputLocation,
        [string] $Version,
        [string] $ProjectPath
    )
    Process
    {
        $config = Get-ScProjectConfig $ProjectPath
        $source = $config.NuGetFeed
        if(-not $source) {
            Write-Error "Source for Sitecore package could not be found. Make sure Bob.config contains the NuGetFeed key."
        }

        $nugetConfig = [System.Environment]::GetFolderPath("ApplicationData") + "\NuGet\NuGet.config"
        if($env:NuGetConfig) {
            $nugetConfig = $env:NuGetConfig
        }

        $fs = New-Object NuGet.PhysicalFileSystem $pwd
        $setting = [NuGet.Settings]::LoadDefaultSettings($fs,  $nugetConfig, $null);
        $sourceProvider = New-Object NuGet.PackageSourceProvider $setting

        $credentialProvider = New-Object NuGet.SettingsCredentialProvider -ArgumentList ([NuGet.ICredentialProvider][NuGet.NullCredentialProvider]::Instance), ([NuGet.IPackageSourceProvider]$sourceProvider)

        [NuGet.HttpClient]::DefaultCredentialProvider = $credentialProvider

        $repo = New-Object  NuGet.DataServicePackageRepository $Source

        Write-Verbose "Install $packageId $version to $OutputLocation"
        $packages = $repo.FindPackagesById($packageId)
        if($Version) {
            $packageToInstall = $packages | ? {$_.Version -eq $version}
        }
        else {
            $packageToInstall = $packages | sort {$_.Version} | select -last 1
        }
        if(-not $packageToInstall) {
            Write-Error "Package $packageId with version $version not found"
        }

        $outputFileSystem = New-Object NuGet.PhysicalFileSystem $OutputLocation
        $outputFileSystem.AddFiles($packageToInstall.GetFiles(), $OutputLocation)
    }
}
