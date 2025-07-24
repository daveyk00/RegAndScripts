# Define the username
$username = 'example-localadmin'
 
# Check if the account already exists
$existingAccount = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
 
if ($existingAccount -eq $null) {
    # Generate a random password      	
	$password = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 14 | ForEach-Object {[char]$_})
 
    # Convert the password to a secure string
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
 
    # Create the local user account
    $account = New-LocalUser -Name $username -Password $securePassword -PasswordNeverExpires:$true
 
    # Get the local Administrators group
    $adminGroup = Get-LocalGroup -Name 'Administrators'
 
    # Add the newly created user to the Administrators group
    Add-LocalGroupMember -Group $adminGroup -Member $username
}
