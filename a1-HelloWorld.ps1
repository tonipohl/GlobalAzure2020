# a1-HelloWorld.ps1
Write-Output "Hello world at $(Get-Date)."

<#
# use parameters
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$name = $requestBody.name
Write-Output "Hello $name, at $(Get-Date)"
#>