#---------------------------------------------------------------------------------------
# a3-Storage.ps1 
# Write content to an Azure Storage Blob using the new Az cmdlets.
# Import the Az modules before use: Az.Accounts, Az.Automation, Az.Storage
# MITT, @atwork
#---------------------------------------------------------------------------------------
$RG = "GlobalAzure"
$storageAccountName = "globalazure1" 

# https://docs.microsoft.com/en-us/powershell/module/az.accounts/connect-azaccount?view=azps-3.5.0
"$(Get-Date) Logging in to Azure..."
$connectionName = "AzureRunAsConnection"
$servicePrincipalConnection = Get-AutomationConnection -Name $connectionName         

Connect-AzAccount `
    -ServicePrincipal `
    -TenantId $servicePrincipalConnection.TenantId `
    -ApplicationId $servicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 

"$(Get-Date) Logfile..."
# Create a new local logfile with some content
$todaydate = Get-Date -Format yyyy-MM-dd-HH-mm-ss 
$logfile = "MyLogfile-$todaydate.txt" 
$content = "Date, message`r`n"
1..5 | % { $content += "$(Get-Date), item $_`r`n" }
# Write the logfile - as usual - to the current directory
$content | Out-File -FilePath .\$logfile -NoClobber

"$(Get-Date) Storage..."
# Get Storage Account Key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $RG -AccountName $storageAccountName).Value[0]

# create a context
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# and upload the file to an existing container
Set-AzStorageBlobContent -File $logfile `
    -Container "mylogfiles" `
    -BlobType "Block" `
    -Context $storageContext

Write-Output "$(Get-Date) Created $($logfile)."
