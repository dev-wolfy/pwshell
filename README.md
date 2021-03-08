# pwshell
script powershell

```ps1
get-aduser -filter * -Properties whencreated | where whencreated -gt (get-date).AddMinutes(-10) | remove-aduser
```

```ps1
Get-ADUser -Filter * -Properties * | Select-Object name, lastlogondate, department | export-csv -path c:\temp\userexport.csv
```

```ps1
$adapter = get-netadapter | where {$_.status -eq "up" -and $_.mediatype -eq "802.3"}
new-netipaddress -InterfaceIndex $adapter.ifIndex -IPAddress 192.168.1.10 -PrefixLength 24 -DefaultGateway 192.168.1.1
set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses 192.168.90.55

test-connection 192.168.1.1 -Quiet -Count 1
test-connection www.google.fr -Quiet -Count 1

$mdp = read-host "votre mdp" -AsSecureString
Set-LocalUser -Name "administrateur" -Password $mdp

add-windwosfeature ad-domain-services -IncludeAllSubFeature -IncludeManagementTools
$safepass = ConvertTo-SecureString -String "Formation2019" -AsPlainText -Force

Test-

```
