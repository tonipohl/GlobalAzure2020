# https://docs.microsoft.com/en-us/azure/automation/automation-webhooks#sample-runbook
Write-Output "$(Get-Date) starting webhook"

$uri = "https://s2events.azure-automation.net/webhooks?token=<yourtoken>"

$site  = @{ title="GlobalAzure1"; quotaInGB=2; owner = "admin@<yourtenant>.onmicrosoft.com" }

$body = ConvertTo-Json -InputObject $site
#$header = @{ message="StartedbyContoso"}

$response = Invoke-WebRequest -Method Post -Uri $uri -Body $body # -Headers $header
$response

# if you want to get just the job id...
# $jobid = (ConvertFrom-Json ($response.Content)).jobids[0]
# $jobid

Write-Output "$(Get-Date) end calling webhook"
