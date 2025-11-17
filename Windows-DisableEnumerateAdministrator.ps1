if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Windows\CurrentVersion\Policies\CredUI") -ne $true) {  New-Item "HKLM:\SOFTWARE\Windows\CurrentVersion\Policies\CredUI" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Windows\CurrentVersion\Policies\CredUI' -Name 'EnumerateAdministrators' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
