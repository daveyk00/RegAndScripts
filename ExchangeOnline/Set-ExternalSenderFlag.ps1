$OutputFile="$ENV:temp\ExternalSenderFlag.txt"

try
{
    write-output "Connect to Exchange Online"
    Connect-Exchangeonline -showbanner:$false
}
catch
{
    write-error "Connect-ExchangeOnline failed to connect"
    write-error $_
    exit
}

try
{
    write-output "Get ExternalInOutlook status"
    $ExternalFlag=Get-ExternalInOutlook
}
catch
{
    write-error "Unable to get External Sender flag status"
    write-error $_
    exit
}

try
{
    write-output $ExternalFlag | Out-File $OutputFile
}
catch
{
    write-error "Failed to save $OutputFile"
    write-error $_
    write-error "ExternalInOutlook status is $ExternalFlag"
    exit
}

write-output "Status is:"
write-output $ExternalFlag.Enabled
write-output "Saved in $OutputFile"

if ($ExternalFlag.Enabled -ne $True)
{
    write-output "ExternalInOutlook not True - setting to true"
    try
    {
        Set-ExternalInOutlook -enabled $True
    }
    catch
    {
        write-error "Set ExternalInOutlook to True failed"
        write-error $_
        exit
    }
}