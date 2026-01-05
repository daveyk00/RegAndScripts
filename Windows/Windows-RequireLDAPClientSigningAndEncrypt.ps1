# Signing

if((Test-Path -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Services\ldap") -ne $true) {  New-Item "HKLM:\SYSTEM\CurrentControlSet\Services\ldap" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Services\ldap' -Name 'LDAPClientIntegrity' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue;

# Encrypt

New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Services\ldap' -Name 'LDAPClientConfidentiality' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue;
