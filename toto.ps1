# Création de nos groupes de sécurité
$listeusers = get-aduser -filter * -Properties department,title -SearchBase "OU=_services,DC=$env:userdomain,DC=local"
($listeusers | group department,title).name | foreach-object{
    new-adgroup -GroupScope Global "GG_$($_.split(",")[0].replace('/','').trim())_$($_.split(",")[1].trim())"
}

# Ajouter les utilisateurs dans les groupes de sécurité GG

$listeusers = get-aduser -filter * -Properties department,title -SearchBase "OU=_services,DC=$env:userdomain,DC=local"
($listeusers | group department,title) | %{
    Add-ADGroupMember -Identity "GG_$($_.name.split(",")[0].replace('/','').trim())_$($_.name.split(",")[1].trim())" `
    -members $_.group
}
