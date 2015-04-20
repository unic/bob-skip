<#
.SYNOPSIS

.DESCRIPTION


.PARAMETER

.EXAMPLE

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
