function RND-Password {
    param()
    $listeASCII = 65..90+97..122+48..57 
    $pass = ""
    for ($i = 1; $i -le 8; $i++)    { 
        $pass += [char](get-random -InputObject $listeASCII)
    }
    return $pass
}

function Create-ObjUser{
    param($prenom,$nom, $domaine = $env:USERDNSDOMAIN,$idrh,$service)
    $ObjUser = new-object system.object
    $ObjUser | Add-Member -MemberType NoteProperty -name "prenom"      -value ($prenom.Substring(0,1).toupper() + $prenom.Substring(1).ToLower())
    $ObjUser | add-member -MemberType NoteProperty -name "nom"         -value ($nom.ToUpper())
    $ObjUser | add-member -MemberType NoteProperty -name "nom complet" -value ($objuser.prenom + " "+ $objuser.nom)
    $ObjUser | add-member -MemberType NoteProperty -name "pnom"        -value (($objuser.prenom.substring(0,1)+$objuser.nom).replace(" ",""))
    $ObjUser | add-member -MemberType NoteProperty -name "initiales"   -value ($objuser.prenom.substring(0,1)+$objuser.nom.Substring(0,1))
    $ObjUser | add-member -MemberType NoteProperty -name "trigramme"   -value (($objuser.prenom.substring(0,1)+$objuser.nom.Substring(0,1)+$objuser.nom[-1]).toupper())
    $ObjUser | add-member -MemberType NoteProperty -name "email"       -value (($objuser.prenom.substring(0,1)+$objuser.nom+"@"+$domaine).replace(" ","").tolower())
    $ObjUser | add-member -MemberType NoteProperty -name "password"    -value (RND-Password)
    $ObjUser | add-member -MemberType NoteProperty -name "idrh"        -value $idrh
    $ObjUser | add-member -MemberType NoteProperty -name "service"     -value $service
    return $ObjUser
}

# Col et traitement des users pour insertion dans l'ADDS
$colObjUsers = @()
$path = "C:\_Scripts\Users.csv"
$listeusers = import-csv -delimiter ";" -path $path -Encoding oem
$listeusers | ForEach-Object {
    $colObjUsers += Create-ObjUser -prenom $_.prenom -nom $_.nom -idrh $_.idrh -service $_.service
}


$colObjUsers | ForEach-Object {$cpt = 1}{
    write-progress -Activity $_.'nom complet' -PercentComplete (100*$cpt++ / $colObjUsers.Count)
    new-aduser `
      -name              $_.idrh `
      -samaccountname    $_.idrh `
      -Surname           $_.nom `
      -GivenName         $_.prenom `
      -UserPrincipalName $_.email `
      -emailaddress      $_.email `
      -Description       $_.trigramme `
      -Initials          $_.initiales `
      -Department        $_.service `
      -AccountPassword   ($_.password | ConvertTo-SecureString -AsPlainText -Force) `
      -Enabled           $true
}
