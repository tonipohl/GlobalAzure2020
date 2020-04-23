#---------------------------------------------------------------------------------------
# a4-StartOrStopVM.ps1
#---------------------------------------------------------------------------------------
Write-Output "Stop VM..."

$rgname = "MITT-M365"
$vmname = "MITT-VM1"

$connectionName = "AzureRunAsConnection"

$servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         
"Logging in to Azure..."
Add-AzureRmAccount `
    -ServicePrincipal `
    -TenantId $servicePrincipalConnection.TenantId `
    -ApplicationId $servicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 

# Start VM
$jobid = Start-AzureRmVm -ResourceGroupName $rgname -Name $vmname -AsJob
$jobid
Write-Output "Started VM $vmname."

# Stop a VM
#Stop-AzureRmVm -ResourceGroupName $rgname -Name $vmname -Force
#Write-Output "Stopped VM $vmname."
