<#
.SYNOPSIS
Gets the path to the current NuGet config.

.DESCRIPTION
Gets the path to the current NuGet config.
Normaly this will be %AppData%\NuGet\NuGet.config, but it can be overridden by
setting the environment variable `NuGetConfig`.

If the file does not exist yet, it will be created.

.EXAMPLE
Get-NugetConfig


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
