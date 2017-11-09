

# Install-NugetPackage

Installs the specified NuGet package to the specified location.
## Syntax

    Install-NugetPackage -PackageId <String> -OutputLocation <String> [-Version <String>] [-ProjectPath <String>] [-RemoveFiles <Boolean>] [<CommonParameters>]

    

    Install-NugetPackage -OutputLocation <String> -Package <IPackage> [-ProjectPath <String>] [-RemoveFiles <Boolean>] [<CommonParameters>]


## Description

Downloads and extracts the specified NuGet package to a specified location.
A Nuget package can be specified by either passing the package id and the version
or by passing directly the package-object.





## Parameters

    
    -PackageId <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | true |  | false | false |


----

    
    
    -OutputLocation <String>
_The location where the content of the package will be extracted to._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | true |  | false | false |


----

    
    
    -Version <String>
_The version of the package to install.
If none is specified, the newest prerelease will be installed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false |  | false | false |


----

    
    
    -Package <IPackage>
_The package to install._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | true |  | false | false |


----

    
    
    -ProjectPath <String>
_The path to the website project containing e.g. the Bob.config._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false |  | false | false |


----

    
    
    -RemoveFiles <Boolean>
_If yes, every file contained in the package to install is removed before the
package is extracted to the filesystem._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false | False | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-NugetPackage -PackageId Unic.Bob.Keith D:\temp\Keith































