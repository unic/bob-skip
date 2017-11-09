

# Get-NugetConfig

Gets the path to the current NuGet config.
## Syntax

    Get-NugetConfig [<CommonParameters>]


## Description

Gets the path to the current NuGet config.
Normaly this will be %AppData%\NuGet\NuGet.config, but it can be overridden by
setting the environment variable `NuGetConfig`.

If the file does not exist yet, it will be created.





## Parameters


## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-NugetConfig































