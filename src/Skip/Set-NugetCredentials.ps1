<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

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
