<#
.SYNOPSIS
Gets all NuGet packages with the specified id.

.DESCRIPTION
Gets all NuGet packages with the specified id.

.PARAMETER PackageId
The id of the NuGet package to get.

.PARAMETER ProjectPath
The path to the website project containing e.g. the Bob.config.

.EXAMPLE
Get-NugetPackage Unic.Bob.Skip

#>
function Get-NugetPackage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $PackageId,
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

        return $packages
    }
}
