<#
.SYNOPSIS
Sets the specified NuGet credentials in the NuGet.config

.DESCRIPTION
Adds or update the specified credentials for the specified source in the NuGet.config
If the source doesn't exist yet in the NuGet.config it will be created.

.PARAMETER Username
The username to set.

.PARAMETER Password
The password to set.

.PARAMETER Source
The source for which the username and password should be set.

.PARAMETER SourceName
The name of the source in the NuGet.config.

.EXAMPLE
Set-NuGetCredentials -Username bob.thebuilder -Password W3ndy -Source https://teamcity.unic.com/some/endpoint

#>
function Set-NugetCredentials
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Username,
        [Parameter(Mandatory=$true)]
        [string] $Password,
        [Parameter(Mandatory=$true)]
        [string] $Source,
        [string] $SourceName = "Unic TeamCity"
    )
    Process
    {
        $nugetConfig = Get-NugetConfig

        $fs = New-Object NuGet.PhysicalFileSystem $pwd
        $setting = [NuGet.Settings]::LoadDefaultSettings($fs,  $nugetConfig, $null)
        $sourceProvider = New-Object NuGet.PackageSourceProvider $setting

        $sources = $sourceProvider.LoadPackageSources()
        $packageSource = $sources | ? {$_.Source -eq $Source}
        if($packageSource) {
            $packageSource | % {$sources.Remove($_) } | Out-Null
        }

        $packageSource = New-Object Nuget.PackageSource $Source, $SourceName
        $packageSource.UserName = $Username
        $packageSource.Password = $Password
        $sources.Add($packageSource)

        $sourceProvider.SavePackageSources($sources)
    }
}
