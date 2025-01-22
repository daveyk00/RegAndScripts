<#
.SYNOPSIS
Get all or individual Intune PowerShell scripts and save them in specified folder.
 
.DESCRIPTION
The Get-DeviceManagementScripts cmdlet downloads all or individual PowerShell scripts from Intune to a specified folder.

Initial Author: Oliver Kieselbach (oliverkieselbach.com)
Modified to use mggraph and pwsh 7
The script is provided "AS IS" with no warranties.

.PARAMETER TenantID
TenantID that contains the scripts in the format nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn

.PARAMETER FolderPath
The folder where the script(s) are saved.

.PARAMETER FileName
An optional parameter to specify an explicit PowerShell script to download.

.EXAMPLE
Download all Intune PowerShell scripts to the specified folder

Get-DeviceManagementScripts -FolderPath C:\temp -TenantID nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn

.EXAMPLE
Download an individual PowerShell script to the specified folder

Get-DeviceManagementScripts -FolderPath C:\temp -FileName myScript.ps1 -TenantID nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn

#>

#Requires -Version 7
#Requires -Modules Microsoft.Graph.Intune


    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][String] $FolderPath,
        [Parameter(Mandatory=$false)][String] $FileName,
        [Parameter(Mandatory=$true)][String] $TenantID
    )
    
####################################################

Function Get-DeviceManagementScripts(){


    write-output "Connecting to graph using $TenantID..."
    connect-mggraph -TenantId $TenantID -NoWelcome

    $graphApiVersion = "Beta"
    $graphUrl = "https://graph.microsoft.com/$graphApiVersion"

    write-output "Getting list of scripts..."
    $result = Invoke-MgGraphRequest -Uri "$graphUrl/deviceManagement/deviceManagementScripts" -Method GET


    if ($FileName){
        $scriptId = $result.value | Select-Object id,fileName | Where-Object -Property fileName -eq $FileName
        $script = Invoke-MgGraphRequest -Uri "$graphUrl/deviceManagement/deviceManagementScripts/$($scriptId.id)" -Method GET
        [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($script.scriptContent))) | Out-File -Encoding ASCII -FilePath $(Join-Path $FolderPath $($script.fileName))
    }
    else{
        $scriptIds = $result.value | Select-Object id,fileName
        foreach($scriptId in $scriptIds){
            $script = Invoke-MgGraphRequest -Uri "$graphUrl/deviceManagement/deviceManagementScripts/$($scriptId.id)" -Method GET
            write-output "Saving $($scriptId.filename) to $(Join-Path $FolderPath $($script.filename))"
            [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($($script.scriptContent))) | Out-File -Encoding ASCII -FilePath $(Join-Path $FolderPath $($script.fileName))
        }
    }
}

Get-DeviceManagementScripts

