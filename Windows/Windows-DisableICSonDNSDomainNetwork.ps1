if((Test-Path -LiteralPath "HKLM:\Software\Policies\Microsoft\Windows\Network Connections\") -ne $true) {  New-Item "HKLM:\Software\Policies\Microsoft\Windows\Network Connections\" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\Software\Policies\Microsoft\Windows\Network Connections\' -Name 'NC_ShowSharedAccessUI' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
