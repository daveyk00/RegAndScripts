# Force-ChangePassword.ps1
#
# modifies Entra ID Attibute 'ForceChangePasswordNextSignIn' to True on all accounts
# can exclude some accounts if required
# requires
# connect-mggraph -scope "User.ReadWrite.All,Directory.AccessAsUser.All,Directory.ReadWrite.All"

# Define users to exclude from password reset
$excludedUsers = @("jane@example.com","john@example.com")

# Get all users
$allUsers = Get-MgUser -All -Property "Id,UserPrincipalName,DisplayName"

foreach ($user in $allUsers) {
    # Skip if user is in exclusion list
    if ($user.UserPrincipalName -in $excludedUsers) {
        Write-Host "Skipping excluded user: $($user.UserPrincipalName)" -ForegroundColor Yellow
        continue
    }

    try {
        # Force password change on next logon
        Update-MgUser -UserId $user.Id -PasswordProfile @{
            ForceChangePasswordNextSignIn = $true
        }
        Write-Host "✓ Password reset required for: $($user.UserPrincipalName)" -ForegroundColor Green

    }
    catch {
        Write-Host "✗ Failed to update $($user.UserPrincipalName): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nCompleted processing all users."