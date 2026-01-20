<#

=============================================================================================
Name:           Get specific EA, with owners, and last sign in dates for interactive, non
 interactive and service principal sign ins.  Limits number of sign ins to 100 (if there are
 more it will only show 100)


Used parts from:
https://o365reports.com/2024/11/26/export-all-enterprise-apps-and-their-owners-in-microsoft-entra/
https://github.com/HCRitter/PSMSGraphFunctions/blob/main/Get-MSGraphAuditLogSignInByType.ps1
https://gist.github.com/petergs/069a34fcd115dcbf149b1b66817b6863
https://www.azadvertizer.net/azresourcetypes/microsoft.security_applicationwhitelistings.html

# Requires .net 7.5

============================================================================================
#>

#Requires -Version 7.5

Param
(
    [switch]$CreateSession,
    [string]$TenantId,
    [string]$ClientId,
    [string]$CertificateThumbprint,
    [switch]$SigninEnabledAppsOnly,
    [Switch]$SigninDisabledAppsOnly,
    [Switch]$HiddenApps,
    [Switch]$VisibleToAllUsers,
    [Switch]$AccessScopeToAllUsers,
    [Switch]$RoleAssignmentRequiredApps,
    [Switch]$OwnerlessApps,
    [Switch]$HomeTenantAppsOnly,
    [Switch]$ExternalTenantAppsOnly
)




<#-----------------------------------------------------------------------------------------------------------#>

<#
This function gets the sign in logs by type
based off https://github.com/HCRitter/PSMSGraphFunctions/blob/main/Get-MSGraphAuditLogSignInByType.ps1
#>

function Get-MSGraphAuditLogSignInByType {
    [CmdletBinding()]
    param (
        
        $AppID,
        [ValidateSet('servicePrincipal', 'interactiveUser', 'nonInteractiveUser')]
        [string[]]$SignInType,
        [int]$Top = 100,
        [switch]$All    
    )
    
    begin {
        $ReturnCollection = new-object System.Collections.Generic.List[pscustomobject] # Creates a collection to store the app objects
        $OriginalTop = $Top # Stores the original value of $Top
    }
    
    process {
        
        if($All){
            $Top = 999 # Sets $Top to a high value if $All switch is used
        }
        if($Top -gt 999){
            $Top = 999 # Sets $Top to 999 if it exceeds the maximum value
        }

        $URIs = switch($SignInType){
            'servicePrincipal'{
                $Filter = "signInEventTypes/any(t:t eq 'servicePrincipal') and AppId eq '$($AppID)'"
                'https://graph.microsoft.com/beta/auditLogs/signIns?$Top={0}&$Filter={1}' -f $Top,$Filter # Constructs the URI for the API request
                
            }
            'interactiveUser'{
                $Filter = "AppId eq '$($AppID)'"
                'https://graph.microsoft.com/beta/auditLogs/signIns?$Top={0}&$Filter={1}' -f $Top,$Filter # Constructs the URI for the API request

            }
            'nonInteractiveUser'{
                $Filter = "signInEventTypes/any(t: t ne 'interactiveUser') and AppId eq '$($AppID)'"
                'https://graph.microsoft.com/beta/auditLogs/signIns?$Top={0}&$Filter={1}' -f $Top,$Filter # Constructs the URI for the API request

            }
        }
        @($URIs).ForEach({
            $Return = (Invoke-MgGraphRequest -Method GET -Uri $_ -OutputType PSObject) # Sends the API request and stores the response
            $($Return.value.ForEach({ 
                $ReturnCollection.Add($_) # Adds each app object to the collection
            }))
            while(-not([string]::IsnullorEmpty($Return.'@odata.nextlink')) -and (($ReturnCollection.Count -lt $OriginalTop) -or $All)){
                $Return = (Invoke-MgGraphRequest -Method GET -Uri $Return.'@odata.nextlink' -OutputType PSObject) # Sends additional requests to retrieve remaining apps if $All switch is used
                $($Return.value.ForEach({
                    $ReturnCollection.Add($_) # Adds each app object to the collection
                    if($ReturnCollection.Count -eq $OriginalTop -and -not $All){
                        break 
                    }
                }))
            }
        })
    }
    
    end {
        if($All){
            return $ReturnCollection # Returns all app objects
        }
        if($ReturnCollection.count -lt $OriginalTop){
            return $OriginalTop = $ReturnCollection 
        }
        return $ReturnCollection[0..$($OriginalTop-1)] # Returns the specified number of app objects
    }
}

<#-----------------------------------------------------------------------------------------------------------#>

<#
Connect to MGGraph - try to sort out the modules as best possible
#>

Function Connect_MgGraph
{
    #Check for module installation
    $Module=Get-Module -Name Microsoft.Graph -ListAvailable
    if($Module.count -eq 0) 
    { 
        Write-Host Microsoft Graph PowerShell SDK is not available  -ForegroundColor yellow  
        $Confirm= Read-Host Are you sure you want to install module? [Y] Yes [N] No 
        if($Confirm -match "[yY]") 
        { 
            Write-host "Installing Microsoft Graph PowerShell module..."
            Install-Module Microsoft.Graph -Repository PSGallery -Scope CurrentUser -AllowClobber -Force
        }
        else
        {
            Write-Host "Microsoft Graph PowerShell module is required to run this script. Please install module using Install-Module Microsoft.Graph cmdlet." 
            Exit
        }
    }
    #Disconnect Existing MgGraph session
    if($CreateSession.IsPresent)
    {
        Disconnect-MgGraph
    }

    Write-output "Connecting to Microsoft Graph..."
    if(($TenantId -ne "") -and ($ClientId -ne "") -and ($CertificateThumbprint -ne ""))  
    {  
        Connect-MgGraph  -TenantId $TenantId -AppId $ClientId -CertificateThumbprint $CertificateThumbprint -NoWelcome
    }
    else
    {
        Connect-MgGraph -Scopes "Application.Read.All"  -NoWelcome
    }
}


<#-----------------------------------------------------------------------------------------------------------#>
# MAIN

Connect_MgGraph


<#
Get a list of all the Enterprise apps

#>

$PrintedCount=0
$Count=0
$TenantGUID= (Get-MgOrganization).Id
$apps=@()

Get-MgServicePrincipal -All | foreach {
    $Count++
    $EnterpriseAppName=$_.DisplayName
    Write-Progress -Activity "`n     Processed enterprise apps: $Count - $EnterpriseAppName "
    $UserSigninStatus=$_.AccountEnabled
    $ObjectId=$_.Id
    $AppID=$_.AppID
    $Tags=$_.Tags
    if($Tags -contains "HideApp")
    {
        $UserVisibility="Hidden"
    }
    else
    {
        $UserVisibility="Visible"
    }
    $IsRoleAssignmentRequired=$_.AppRoleAssignmentRequired
    if($IsRoleAssignmentRequired -eq $true)
    {
        $AccessScope="Only assigned users can access"
    }
    else
    {
        $AccessScope="All users can access"
    }
    [DateTime]$CreationTime=($_.AdditionalProperties.createdDateTime)
    $CreationTime=$CreationTime.ToLocalTime()
    $ServicePrincipalType=$_.ServicePrincipalType
    $AppRegistrationName=$_.AppDisplayName
    $AppOwnerOrgId=$_.AppOwnerOrganizationId
    if($AppOwnerOrgId -eq $TenantGUID)
    {
        $AppOrigin="Home tenant"
    }
    else
    {
        $AppOrigin="External tenant"
    }
    $Owners=(Get-MgServicePrincipalOwner -ServicePrincipalId $ObjectId).AdditionalProperties.userPrincipalName
    $Owners=$Owners -join ","
    if($owners -eq "")
    {
        $Owners="-"
    }

    $PrintedCount++
    $apps += [PSCustomObject]@{
        EnterpriseAppName=$EnterpriseAppName
        appId=$appId
        AppOwners=$Owners
        AppCreationTime=$CreationTime
        UserSigninAllowed=$UserSigninStatus
    } 
}


<#

Filter results to exclude unwanted and get the sign in logs using functions
# modified with
# https://gist.github.com/petergs/069a34fcd115dcbf149b1b66817b6863
# https://www.azadvertizer.net/azresourcetypes/microsoft.security_applicationwhitelistings.html
# https://www.msxfaq.de/cloud/authentifizierung/appid_serviceprincipal_und_clientid.htm

#>

$Exclusions=import-csv Get-EASigninLogs-excluded-apps.csv

# Create an array to store the CSV rows
$csvExport = @()

# add counter so we know how many we are upto?
$counter=$apps.count
$i=0

foreach ($app in $apps)
{
    $i++
    # filter out the microsoft ones and specific exclusions
    write-output "Checking $i out of $counter"
    $appname=$app.EnterpriseAppName
    if ($Exclusions.appId -notcontains $app.appid)
    {
        write-output $appname
        $InteractiveSignins=Get-MSGraphAuditLogSignInByType -signinType "InteractiveUser" -appid $app.appId
        $NonInteractiveSignins=Get-MSGraphAuditLogSignInByType -signinType "nonInteractiveUser" -appid $app.appId
        $ServicePrincipalSignins=Get-MSGraphAuditLogSignInByType -signinType "servicePrincipal" -appid $app.appId
        $csvExport += [PSCustomObject]@{
            appname = $app.EnterpriseAppName
            guid = $app.appid
            owner = $app.Owners
            creationtime = $app.AppCreationTime
            signinallowed = $app.UserSigninAllowed
            interactive = $InteractiveSignins.count
            noninteractive = $nonInteractiveSignins.count
            serviceprincipals = $servicePrincipalSignins.count
        }
    }
    else
    {
        write-output "$appname is skipped"
    }
}
$csvExport | export-csv -Notype "output.csv"