<#
.SYNOPSIS
Reads the NuGet crerdentials for a source and adds them to the NuGete config.

.DESCRIPTION
Asks the user for the usernamee and password for the specified source.
The credentials are then stored to the NuGet.config for further use.

.PARAMETER Source
The source (feed-url) to ask credentials for.

.EXAMPLE
Read-NugetCredentials "https://teamcity.unic.com/httpAuth/nuget/api/v1"

#>
function Read-NugetCredentials
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Source
    )
    Process
    {
        $username = Read-Host "Username"
        $securePassword = Read-Host "Password" -AsSecure
        $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword));
        Set-NugetCredentials -Source $source -Username $username -Password $password
    }
}
