

# Read-NugetCredentials

Reads the NuGet crerdentials for a source and adds them to the NuGet config.
## Syntax

    Read-NugetCredentials [-Source] <String> [<CommonParameters>]


## Description

Asks the user for the username and password for the specified source.
The credentials are then stored to the NuGet.config for further use.





## Parameters

    
    -Source <String>
_The source (feed-url) to ask credentials for._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Read-NugetCredentials "https://teamcity.unic.com/httpAuth/nuget/api/v1"































