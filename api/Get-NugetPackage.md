

# Get-NugetPackage

Gets all NuGet packages with the specified id.
## Syntax

    Get-NugetPackage [-PackageId] <String> [[-ProjectPath] <String>] [[-Source] <String>] [<CommonParameters>]


## Description

Gets all NuGet packages with the specified id.





## Parameters

    
    -PackageId <String>
_The id of the NuGet package to get._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -ProjectPath <String>
_The path to the website project containing e.g. the Bob.config._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false |  | false | false |


----

    
    
    -Source <String>
_The source to use to get the package._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-NugetPackage Unic.Bob.Skip































