function FCT_Cipher-ENCODE-MORSE{
    param($texte)
    $morses = @{'A'='.-';'B'='-...';'C'='-.-.';'D'='-..';'E'='.';'F'='..-.';'G'='--.';'H'='....';'I'='..';'J'='.---';'K'='-.-';'L'='.-..';'M'='--';'N'='-.';'O'='---';'P'='.--.';'Q'='--.-';'R'='.-.';'S'='...';'T'='-';'U'='..-';'V'='...-';'W'='.--';'X'='-..-';'Y'='-.--';'Z'='--..';'1'='.----';'2'='..---';'3'='...--';'4'='....-';'5'='.....';'6'='-....';'7'='--...';'8'='---..';'9'='----.';'0'='-----'}

    foreach($letter in $texte.ToCharArray()) {
        if ($morses.ContainsKey([string]$letter)) {
            write-host -NoNewline "$letter : "
            write-host $morses[[string]$letter]
            foreach($m in $morses[[string]$letter].ToCharArray()) {
                if($m -eq '.') { [console]::beep(700,300) }
                if($m -eq '-') { [console]::beep(700,600) }
            }
        } else {
            write-host "$letter : "
        }
        Start-Sleep -s 1
    }
    return $null
}
