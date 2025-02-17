if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\access") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\access" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\access\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\access\security" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\excel") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\excel" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\excel\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\excel\security" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\excel\security\trusted locations") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\excel\security\trusted locations" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\ms project") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\ms project" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\ms project\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\ms project\security" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\powerpoint") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\powerpoint" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\powerpoint\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\powerpoint\security" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\publisher") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\publisher" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\publisher\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\publisher\security" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\visio") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\visio" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\visio\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\visio\security" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\word") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\word" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\word\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\word\security" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\common") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\common" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Office\16.0\common\security") -ne $true) {  New-Item "HKCU:\SOFTWARE\Microsoft\Office\16.0\common\security" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\access\security' -Name 'vbawarnings' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\excel\security' -Name 'vbawarnings' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\ms project\security' -Name 'vbawarnings' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\powerpoint\security' -Name 'vbawarnings' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\publisher\security' -Name 'vbawarnings' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\visio\security' -Name 'vbawarnings' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\word\security' -Name 'vbawarnings' -Value 4 -PropertyType DWord -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Office\16.0\common\security' -Name 'macroruntimescanscope' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue;