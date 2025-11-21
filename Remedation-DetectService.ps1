# Service Remediation

# Detect if a service is installed.
# If the service is not found, exit code 1
# If the service is found, exit code 0

$ServiceName='InsertServiceNameHere'

$ServiceStatus = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue

if ($ServiceStatus -eq $null)
{
    # Service not found
    write-debug "$ServiceName service not found"
    write-error "$ServiceName was not found"
    exit 1
}
else
{
    # service found
    write-debug "$ServiceName service was found"
    exit 0
}