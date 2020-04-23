#---------------------------------------------------------------------------------------
# a5-CreateCommSite.ps1 
# Sample using SPO and parameters.
# Create a new SPO Communication Site with the SPO module.
# Import the SPO module before use.
# @atwork
#---------------------------------------------------------------------------------------
param
(
	[Parameter (Mandatory=$true)]
	[string] $title = "GlobalAzure10",
	[Parameter (Mandatory=$false)]
	[int] $quotaInGB = 1,
	[Parameter (Mandatory=$false)]
	[string] $owner = "admin@M365x251516.onmicrosoft.com"
)

Write-Output "$(Get-Date) Starting CreateCommSite..."
$tenant = Get-AutomationVariable -Name "tenantname"
$cred = Get-AutomationPSCredential -Name 'NestorW'

Connect-SPOService "https://$tenant-admin.sharepoint.com" -Credential $cred

$siteUrl = "https://$tenant.sharepoint.com/sites/$title"
Write-Output "$(Get-Date) Creating $siteUrl with Template STS#3"

New-SPOSite -Title $title -Template "STS#3" -Owner $owner -Url $siteUrl -StorageQuota ($quotaInGB * 1024) 

Write-Output "Enable external sharing without anonymous links"
Set-SPOSite -Identity $siteUrl `
	-Owner $owner `
	-SharingCapability ExternalUserSharingOnly `
	-NoWait

Write-Output "$(Get-Date) created $siteUrl"
