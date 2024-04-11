$o365Cred = Import-Clixml "C:\temp\o365Cred.xml"
$o365PSSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Authentication Basic -AllowRedirection -Credential $o365cred
Import-PSSession $o365PSSession

$Devices = Get-MobileDevice -Mailbox cory.coles -Filter {DeviceAccessState -eq "Blocked"} | Select-Object -ExpandProperty DeviceId

if ($null -ne $Devices) {
  foreach ($Device in $Devices) {
    Set-CASMailbox cory.coles -ActiveSyncAllowedDeviceIDs $Device
  }
}

Remove-PSSession $o365PSSession
test