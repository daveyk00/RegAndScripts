if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Google\Chrome\") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Google\Chrome\" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Google\Chrome\' -Name 'BackgroundModeEnabled' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue;
