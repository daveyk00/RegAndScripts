if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections\") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections\" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:SOFTWARE\Policies\Microsoft\Windows\Network Connections\' -Name 'NC_AllowNetBridge_NLA' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
