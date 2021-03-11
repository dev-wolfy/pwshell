dir -file -recurse c:\vla | group name,length,lastwritetime | 
  where count -gt 1
