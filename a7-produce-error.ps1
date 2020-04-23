Write-Output "Hello, $name at $(Get-Date)"

# use a false syntax: $name1 = Get-AutomationVariable -Name "SomeText1"
$name1 = Get-Automation -Name "SomeText1"
Write-Output "The value of name1 is: $($name1) at $(Get-Date)"
