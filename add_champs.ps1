# Mettre à jour la liste des users pour ajouter le champs grade 
$csvlist = import-csv -Delimiter ";" -path C:\_Scripts\Users.csv -Encoding oem

$listeusers = get-aduser -filter * -SearchBase "OU=_services,DC=$env:userdomain,DC=local"
$listeusers | foreach-object {
    $grade = ($csvlist | where idrh -eq $_.name).grade
    set-aduser -Identity $_.distinguishedname -title $grade
}
