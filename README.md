| Name | Purpose |
| --- | --- |
| chrome\chrome-disablePasswordManager.ps1 | Disable the chrome password manager (users can still get password out though) |
| ExchangeOnline\Set-ExternalSenderFlag.ps1 | get value of ExternalInOutlook, save in file and if False, set to True | 
| graph\Force-ChangePassword.ps1 | modifies Entra ID Attibute 'ForceChangePasswordNextSignIn' to True on all accounts |
| graph\Revoke-AllSessions.ps1 | revokes all 365 sessions forcing users to sign back in. |
| MSOffice\Office-EnableAutomaticUpdates.ps1 | Enables the Office automatic updates for all Office products installed by using Click-to-Run. This policy has no effect on Office products installed via Windows Installer. |
| MSOffice\Office-DisableTeachingCallouts | Disables the 'Got It' teaching callouts in Office 365 |
| MSOffice\Office-MacroTrustedLocations.ps1 | Add Trusted locations to office for macros |
| ConvertFromEpoch.py | ConvertFromEpoch.py converts an epoch timestamp from a list of times in a file |
| Get-DeviceManagementScripts.ps1 | Get all or individual Intune PowerShell scripts and save them in specified folder |
| DisableDoNotPreserveZoneInformation.ps1 | Disables the 'Do not preserve zone information in file' setting (allows Outlook to save mark of web data on attachments) |
| Windows\Windows-SendNTLMv2ReponsesOnly.ps1 | Configured challenge/response authentication protocol for network logons to be only NTLMv2 and refuse LM and NTLM |
| Windows\Windows-DisableICSonDNSDomainNetwork.ps1 | Disables Internet Connection Sharing |
| Windows\Windows-MicrosoftNetworkClient-DigitallySignCommsAlways.ps1 |
| Windows\Windows-DisableChromeRunningInBackground.ps1 | Disable Chrome running in background when closed |
| Windows\Windows-DisableInstallNetworkBridge.ps1 | Determines a user from installing and configure the Network Bridge |
| Windows\Windows-DisableLocalStorageOfPasswordsAndCredentials.ps1 | Disable local storage of passwords (cred man) |
| Windows\Windows-DisableJavascriptOnAdobeDC | Disables JavaScript in Adobe Reader DC |
| Windows\Windows-ApplyUACrestrictionstolocalaccountsonnetworklogons | Enable 'Apply UAC restrictions to local accounts on network logons' |
| Windows\Windows-UploadBitlockerKeyProtectorToEntra.ps1 | Backup bitlocker recovery key to Entra. |
| Windows\Windows-NewLocalAdmin.ps1 | Create local admin with a random password |
| Windows\Windows-RequireLDAPClientSigningAndEncrypt.ps1 | Configures LDAP client side signing and encryption |
| Windows\Windows-DisableEnumerateAdministrator.ps1 | Disable 'Enumerate administrator accounts on elevation' |
| Windows\Windows-AccountLockOutSettings.txt | the OMA URI for account lockout settings |
| Windows\Windows-DisablePrintSpoolerAcceptingClientConnections | Disables inbound printer connections even if a printer is shared |
| Windows\Windows-DisableCortanaWebSearchOnStartMenu | Disable Cortana web search on start menu |
| Windows\Windows-DisableAnonymousEnumerationOfShares.ps1 | Disable anonymous logon users (null session connections) from being allowed to list all account names and enumerate all shared resources via HKLM registry |