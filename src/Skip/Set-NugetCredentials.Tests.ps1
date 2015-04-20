$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module "$here\Skip.psm1"

Describe "When Set-NugetCredentials" {
    Context "is called with new credentials" {
        $env:NuGetConfig = "$TestDrive\NuGet.config"
        $source = "https://teamcity.unic.com/httAuth/nuget/feed"
        Set-NugetCredentials -SourceName Test -UserName bob.thebuilder -Password W3ndy -Source $source

        $nugetConfig = [xml](Get-Content TestDrive:\NuGet.config -Raw)

        It "Should add the source" {
            ($nugetConfig.configuration.packageSources.add | ? {$_.Key -eq "Test"}).Value  | Should Be $source
        }
        It "Should add the credentials" {
            ($nugetConfig.configuration.packageSourceCredentials.Test.add | ? {$_.Key -eq "Username"}).Value | Should Be "bob.thebuilder"
        }
    }

    Context "is called to update credentials" {
        $env:NuGetConfig = "$TestDrive\NuGet.config"
        $source = "https://teamcity.unic.com/httAuth/nuget/feed"
        Set-NugetCredentials -SourceName Test -UserName bob.thebuilder -Password W3ndy -Source $source
        $nugetConfig = [xml](Get-Content TestDrive:\NuGet.config -Raw)
        $oldEncryptedPassword = ($nugetConfig.configuration.packageSourceCredentials.Test.add | ? {$_.Key -eq "Password"}).Value

        Set-NugetCredentials -SourceName Test -UserName bob.thebuilder -Password W3ndy2 -Source $source
        $nugetConfig = [xml](Get-Content TestDrive:\NuGet.config -Raw)

        It "Should update the password" {
            ($nugetConfig.configuration.packageSourceCredentials.Test.add | ? {$_.Key -eq "Password"}).Value | Should Not BeNullOrEmpty
            ($nugetConfig.configuration.packageSourceCredentials.Test.add | ? {$_.Key -eq "Password"}).Value  | Should Not Be $oldEncryptedPassword
        }
    }

    Context "is called to update credentials with another source name" {
        $env:NuGetConfig = "$TestDrive\NuGet.config"
        $source = "https://teamcity.unic.com/httAuth/nuget/feed"
        Set-NugetCredentials -SourceName Test -UserName bob.thebuilder -Password W3ndy -Source $source
        $nugetConfig = [xml](Get-Content TestDrive:\NuGet.config -Raw)
        $oldEncryptedPassword = ($nugetConfig.configuration.packageSourceCredentials.Test.add | ? {$_.Key -eq "Password"}).Value

        Set-NugetCredentials -SourceName Test2 -UserName bob.thebuilder -Password W3ndy2 -Source $source
        $nugetConfig = [xml](Get-Content TestDrive:\NuGet.config -Raw)

        It "Should update the password" {
            ($nugetConfig.configuration.packageSourceCredentials.Test2.add | ? {$_.Key -eq "Password"}).Value | Should Not BeNullOrEmpty
            ($nugetConfig.configuration.packageSourceCredentials.Test2.add | ? {$_.Key -eq "Password"}).Value  | Should Not Be $oldEncryptedPassword
        }

        It "Should have deleted the old source "{
            ($nugetConfig.configuration.packageSources.add | ? {$_.Key -eq "Test"}).Value  | Should Be $null
        }
    }
}
