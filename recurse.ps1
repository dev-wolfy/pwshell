$tabColFic = @()
dir -file -recurse c:\windows\system32 | group Extension | foreach-object{
    $objcolfic = new-object system.object 
    $objcolfic | add-member -mem noteproperty -name "Ext" -value $_.name
    $objcolfic | add-member -mem noteproperty -name "TailleStr" -value `
      (FRX_Convert-Octets ($_.group | measure-object  -sum length).sum)
    $objcolfic | add-member -mem noteproperty -name "Taille" -value `
      ($_.group | measure-object  -sum length).sum
    $tabColFic += $objcolfic
}
