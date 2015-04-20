<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

#>
function Get-NugetConfig
{
    [CmdletBinding()]
    Param(
    )
    Process
    {
        $nugetConfig = [System.Environment]::GetFolderPath("ApplicationData") + "\NuGet\NuGet.config"
        if($env:NuGetConfig) {
            $nugetConfig = $env:NuGetConfig
        }

        if(-not (Test-Path $nugetConfig)) {
            $template = @"
<?xml version="1.0" encoding="utf-8"?>
<configuration>
    <packageSources />
    <disabledPackageSources />
</configuration>
"@
            $template | Out-File $nugetConfig -Encoding UTF8
        }

        $nugetConfig
    }
}
