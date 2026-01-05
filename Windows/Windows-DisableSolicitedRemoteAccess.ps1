if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fAllowToGetHelp' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
