# Création de nos groupes de sécurité
$listeusers = get-aduser -filter * -Properties department,title -SearchBase "OU=_services,DC=$env:userdomain,DC=local"
($listeusers | group department,title).name | foreach-object{
    new-adgroup -GroupScope Global "GG_$($_.split(",")[0].replace('/','').trim())_$($_.split(",")[1].trim())"
}
