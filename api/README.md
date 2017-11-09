# Skip - API

##  Get-NugetConfig
Gets the path to the current NuGet config.    
    
    Get-NugetConfig [<CommonParameters>]


 [Read more](Get-NugetConfig.md)
##  Get-NugetPackage
Gets all NuGet packages with the specified id.    
    
    Get-NugetPackage [-PackageId] <String> [[-ProjectPath] <String>] [[-Source] <String>] [<CommonParameters>]


 [Read more](Get-NugetPackage.md)
##  Install-NugetPackage
Installs the specified NuGet package to the specified location.    
    
    Install-NugetPackage -PackageId <String> -OutputLocation <String> [-Version <String>] [-ProjectPath <String>] [-RemoveFiles <Boolean>] [<CommonParameters>]

    

    Install-NugetPackage -OutputLocation <String> -Package <IPackage> [-ProjectPath <String>] [-RemoveFiles <Boolean>] [<CommonParameters>]


 [Read more](Install-NugetPackage.md)
##  Read-NugetCredentials
Reads the NuGet crerdentials for a source and adds them to the NuGet config.    
    
    Read-NugetCredentials [-Source] <String> [<CommonParameters>]


 [Read more](Read-NugetCredentials.md)
##  Set-NugetCredentials
Sets the specified NuGet credentials in the NuGet.config    
    
    Set-NugetCredentials [-Username] <String> [-Password] <String> [-Source] <String> [[-SourceName] <String>] [<CommonParameters>]


 [Read more](Set-NugetCredentials.md)

