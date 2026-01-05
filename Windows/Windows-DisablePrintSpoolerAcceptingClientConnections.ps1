if ((Test-Path -LiteralPath "HKLM:\Software\Policies\Microsoft\Windows NT\Printers") -ne $true)
{
	New-Item "HKLM:\Software\Policies\Microsoft\Windows NT\Printers" -force -ea SilentlyContinue
};

New-ItemProperty -LiteralPath 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers' -Name 'RegisterSpoolerRemoteRpcEndPoint' -Value 2 -PropertyType DWord -Force -ea SilentlyContinue;

# Disabled = 2
# Enabled = 1