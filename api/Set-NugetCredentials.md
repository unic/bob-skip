

# Set-NugetCredentials

Sets the specified NuGet credentials in the NuGet.config
## Syntax

    Set-NugetCredentials [-Username] <String> [-Password] <String> [-Source] <String> [[-SourceName] <String>] [<CommonParameters>]


## Description

Adds or updates the specified credentials for the specified source in the NuGet.config
If the source doesn't exist yet in the NuGet.config it will be created.





## Parameters

    
    -Username <String>
_The username to set._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Password <String>
_The password to set._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Source <String>
_The source for which the username and password should be set._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -SourceName <String>
_The name of the source in the NuGet.config._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false | Unic TeamCity | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Set-NuGetCredentials -Username bob.thebuilder -Password W3ndy -Source https://teamcity.unic.com/some/endpoint































