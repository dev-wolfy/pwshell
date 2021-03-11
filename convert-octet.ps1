function global:FRX_Convert-Octets {
    param([uint64]$x)
    switch ($x)
    {
        {$x -ge 0                 -and $x -lt 1024               } {$calcul = "$x octets"}
        {$x -ge [math]::pow(2,10) -and $x -lt [math]::pow(2,20)  } {$calcul = "$([system.math]::round($x/[math]::pow(2,10),2)) Ko"}
        {$x -ge [math]::pow(2,20) -and $x -lt [math]::pow(2,30)  } {$calcul = "$([system.math]::round($x/[math]::pow(2,20),2)) Mo"}
        {$x -ge [math]::pow(2,30) -and $x -lt [math]::pow(2,40)  } {$calcul = "$([system.math]::round($x/[math]::pow(2,30),2)) Go"}
        {$x -ge [math]::pow(2,40) -and $x -lt [math]::pow(2,50)  } {$calcul = "$([system.math]::round($x/[math]::pow(2,40),2)) To"}
        {$x -ge [math]::pow(2,50) -and $x -lt [math]::pow(2,60)  } {$calcul = "$([system.math]::round($x/[math]::pow(2,50),2)) Po"}
        {$x -ge [math]::pow(2,60) } {$calcul = "$([system.math]::round($x/[math]::pow(2,60))) Eo"}

        Default {$calcul = $x}
    }

    Return $calcul
}
