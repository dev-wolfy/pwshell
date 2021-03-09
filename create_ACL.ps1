$path = "c:\_partages\users\testmoi"
mkdir $path -Force

$acl =(get-acl $path)

$aco2FSR = "DeleteSubdirectoriesAndFiles","Write","ReadAndExecute","Synchronize"
$aco2ACT   = [System.Security.AccessControl.AccessControlType]::Allow
$aco2IDref = "FRXLAB\GG_Techniciens"
$aco2IFlag = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit -bor `
[System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$aco2PFlag = [System.Security.AccessControl.PropagationFlags]::None 

$aco2 = new-object System.Security.AccessControl.FileSystemAccessRule ($aco2IDref ,$aco2FSR,$aco2IFlag,$aco2PFlag,$aco2ACT)

$acl.AddAccessRule($aco2)

$acl.SetAccessRuleProtection($true,$false)
set-acl -Path $path -AclObject $acl 

# Trouver avec $acl.access 
