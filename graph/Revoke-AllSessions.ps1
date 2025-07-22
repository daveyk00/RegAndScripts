# Revoke-AllSessions.ps1
#
# revokes all 365 sessions forcing users to sign back in.
# can exclude some accounts if required
# requires
# connect-mggraph -scope "User.ReadWrite.All"

# Define users to exclude from session revocation
$ExcludedUsers = @("jane@example.com","john@example.com")

# Get all users
Write-Host "Retrieving all users..." -ForegroundColor Yellow
$AllUsers = Get-MgUser -All -Property "Id,UserPrincipalName,DisplayName"

Write-Host "Found $($AllUsers.Count) total users" -ForegroundColor Green

# Filter out excluded users
$UsersToRevoke = $AllUsers | Where-Object { $_.UserPrincipalName -notin $ExcludedUsers }

Write-Host "Will revoke sessions for $($UsersToRevoke.Count) users (excluding $($ExcludedUsers.Count) users)" -ForegroundColor Cyan

# Confirm before proceeding
$Confirmation = Read-Host "Do you want to proceed with revoking sessions? (y/N)"
if ($Confirmation -ne 'y' -and $Confirmation -ne 'Y') {
    Write-Host "Operation cancelled" -ForegroundColor Red
    exit
}

# Loop through users and revoke sessions
$SuccessCount = 0
$ErrorCount = 0

foreach ($User in $UsersToRevoke) {
    try {
        Write-Host "Revoking sessions for: $($User.DisplayName) ($($User.UserPrincipalName))" -ForegroundColor White

        Revoke-MgUserSignInSession -UserId $User.Id

        Write-Host "Success" -ForegroundColor Green
        $SuccessCount++
    }
    catch {
        Write-Host "Failed: $($_.Exception.Message)" -ForegroundColor Red
        $ErrorCount++
    }

    # Small delay to avoid throttling
    Start-Sleep -Milliseconds 100
}

# Summary
Write-Host "`n=== Summary ===" -ForegroundColor Yellow
Write-Host "Successfully revoked: $SuccessCount users" -ForegroundColor Green
Write-Host "Failed: $ErrorCount users" -ForegroundColor Red
Write-Host "Excluded: $($ExcludedUsers.Count) users" -ForegroundColor Cyan
