if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\' -Name 'bDisableJavaScript' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
