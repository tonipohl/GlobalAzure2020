# https://docs.microsoft.com/en-us/azure/automation/automation-webhooks#sample-runbook
Write-Output "$(Get-Date) starting webhook"

$uri = "https://s2events.azure-automation.net/webhooks?token=BrBLEt8PAKjLYyc01WEjCZAV%2fyL%2bgBt8etk73IP0dB0%3d"

$site  = @{ title="GlobalAzure27"; quotaInGB=2; owner = "admin@M365x251516.onmicrosoft.com" }

$body = ConvertTo-Json -InputObject $site
#$header = @{ message="StartedbyContoso"}

$response = Invoke-WebRequest -Method Post -Uri $uri -Body $body # -Headers $header
$response

# if you want to get just the job id...
# $jobid = (ConvertFrom-Json ($response.Content)).jobids[0]
# $jobid

Write-Output "$(Get-Date) end calling webhook"
