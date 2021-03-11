dir -file -recurse c:\vla | group name,length,lastwritetime | 
  where count -gt 1 |  %{
      $_.group | %{
        get-filehash $_.fullname -Algorithm MD5
      }
  }
