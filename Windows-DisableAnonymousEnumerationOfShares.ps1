if((Test-Path -LiteralPath "HKLM\SYSTEM\CurrentControlSet\Control\Lsa") -ne $true) {  New-Item "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'RestrictAnonymous' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
