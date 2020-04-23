#---------------------------------------------------------------------------------------
# a8-CreateTeam.ps1 
# Create a new team with the Teams module. Requires MicrosoftTeams
# @atwork
#---------------------------------------------------------------------------------------
# https://docs.microsoft.com/en-us/powershell/module/teams/new-team?view=teams-ps
Write-Output "$(Get-Date) Create Team..."

$cred = Get-AutomationPSCredential -Name '<adminaccount>'
$teamname = "GlobalAzureTeam1"

Connect-MicrosoftTeams -Credential $cred
Write-Output "$(Get-Date) connect."

$group = New-Team -MailNickname $teamname -displayname $teamname -Visibility "private"
Write-Output "$(Get-Date) new team $teamname."

Add-TeamUser -GroupId $group.GroupId -User "AlexW@<tenantname>.OnMicrosoft.com"
Add-TeamUser -GroupId $group.GroupId -User "ChristieC@<tenantname>.OnMicrosoft.com"
Add-TeamUser -GroupId $group.GroupId -User "MiriamG@<tenantname>.OnMicrosoft.com"
Write-Output "$(Get-Date) team $($teamname) members added."

New-TeamChannel -GroupId $group.GroupId -DisplayName "Global Azure planning"
New-TeamChannel -GroupId $group.GroupId -DisplayName "Contracts"
Write-Output "$(Get-Date) $($teamname) channels added."

