#---------------------------------------------------------------------------------------
# a2-Variables.ps1 - work with Variables
# https://docs.microsoft.com/en-us/azure/automation/shared-resources/variables
#---------------------------------------------------------------------------------------
Write-Output "Hello, $name at $(Get-Date)"

# not encrypted
$name1 = Get-AutomationVariable -Name "SomeText1"
Write-Output "The value of 'SomeText1' is '$($name1)'."

# encrypted
$name2 = Get-AutomationVariable -Name "SomeText2"
Write-Output "The value of 'SomeText2' is '$($name2)'."
