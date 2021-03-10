function MakeMyACLUser{
    param($user,$rootpath = "c:\_partages\users\")
    $IFlagOICI   = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit -bor `
                   [System.Security.AccessControl.InheritanceFlags]::ObjectInherit   
    $PflagNONE   = [System.Security.AccessControl.PropagationFlags]::None 
    $ACTAllow    = [System.Security.AccessControl.AccessControlType]::Allow
    $FSRFullCTRL = "FullControl"
    $FSRSpéUSR   = "DeleteSubdirectoriesAndFiles","Write","ReadAndExecute","Synchronize"
    $path        = join-path $rootpath $user
    mkdir $path -Force

    $acl =(get-acl $path)
    $acl.AddAccessRule((new-object System.Security.AccessControl.FileSystemAccessRule ("AUTORITE NT\Système"     ,$FSRFullCTRL,$IFlagOICI,$PflagNONE,$ACTAllow)))
    $acl.AddAccessRule((new-object System.Security.AccessControl.FileSystemAccessRule ("BUILTIN\Administrateurs" ,$FSRFullCTRL,$IFlagOICI,$PflagNONE,$ACTAllow)))
    $acl.AddAccessRule((new-object System.Security.AccessControl.FileSystemAccessRule ("$env:USERDOMAIN\$user"   ,$FSRSpéUSR  ,$IFlagOICI,$PflagNONE,$ACTAllow)))

    $acl.SetAccessRuleProtection($true,$false)
    set-acl -Path $path -AclObject $acl 
}

$csvlist = import-csv -Delimiter ";" -path C:\_Scripts\Users.csv -Encoding oem
$csvlist.idrh | foreach-object{
    MakeMyACLUser -user $_
}
