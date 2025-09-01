# Client

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client' -Name 'AllowBasic' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;

# Server

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service' -Name 'AllowBasic' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
