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

        $nugetConfig = Get-NugetConfig

        $fs = New-Object NuGet.PhysicalFileSystem $pwd
        $setting = [NuGet.Settings]::LoadDefaultSettings($fs,  $nugetConfig, $null);
        $sourceProvider = New-Object NuGet.PackageSourceProvider $setting

        $credentialProvider = New-Object NuGet.SettingsCredentialProvider -ArgumentList ([NuGet.ICredentialProvider][NuGet.NullCredentialProvider]::Instance), ([NuGet.IPackageSourceProvider]$sourceProvider)

        [NuGet.HttpClient]::DefaultCredentialProvider = $credentialProvider

        $repo = New-Object  NuGet.DataServicePackageRepository $Source

        Write-Verbose "Install $packageId $version to $OutputLocation"
        try {
            $packages = $repo.FindPackagesById($packageId)
        }
        catch {
            if($_.Exception.InnerException.GetType() -eq [System.InvalidOperationException]) {
                Read-NugetCredentials -Source $source

                # NuGet caches the metdata, we need to clear the cache in order to get the correct one after adding the credentials
                $cache = [NuGet.MemoryCache].GetProperty("Instance", ("Static","NonPublic")).GetValue($null)
                $removeCache = $cache.GetType().GetMethod("Remove", ("Instance", "NonPublic"))
                $removeCache.Invoke($cache, "DataServiceMetadata|$source`$metadata")

                $setting = [NuGet.Settings]::LoadDefaultSettings($fs,  $nugetConfig, $null);
                $sourceProvider = New-Object NuGet.PackageSourceProvider $setting
                $credentialProvider = New-Object NuGet.SettingsCredentialProvider -ArgumentList `
                    ([NuGet.ICredentialProvider][NuGet.NullCredentialProvider]::Instance), ([NuGet.IPackageSourceProvider]$sourceProvider)
                [NuGet.HttpClient]::DefaultCredentialProvider = $credentialProvider

                $packages = $repo.FindPackagesById($packageId)
            }
            else {
                throw $_
            }
        }
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
