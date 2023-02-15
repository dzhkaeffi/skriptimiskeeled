$type = Read-Host "Enter log type (1 - Application, 2 - System, 3 - Security, 4 - Setup)"
$query = Read-Host "Search query"
$events = "Application", "System", "Security", "Setup"
$Logfile = "log.txt"
Get-EventLog -LogName $events[$type-1] -Message "*$query*" > $Logfile
$A = [IO.File]::ReadAllLines('log.txt')
[string[]]$A = Get-Content -Path 'log.txt'
$file = Read-Host "Please enter the file name to save it"
Write-Output "Working On It..."
$completed = @(0..2)
$counter = 0
$counter2 = 0
$counter3 = 1
$part1 = New-Object 'object[,]' 100, 2
$part2 = New-Object 'object[,]' 6000, 2 
$part3 = [System.Collections.ArrayList]@()
for($k = 2; $k -lt $A.length - 2; $k++){
    $temp = ($A[$k]) -split "  "
    if($temp[0] -eq " " -or $temp[0] -eq ""){
        if($temp[1] -eq " " -or $temp[1] -eq ""){
            if($temp[2] -eq " " -or $temp[2] -eq ""){
                if($temp[3] -eq " " -or $temp[3] -eq ""){
                    $pointer = 4
                }else{
                    $pointer = 4
                    $completed[0] = $temp[3]
                }
            }else{
                $pointer = 3
                $completed[0] = $temp[2]
            }
        }else{
            $pointer = 2
            $completed[0] = $temp[1]
        }
    }else{
        $pointer = 1
        $completed[0] = $temp[0]
    }
    $pointer3 = $pointer + 1
    $completed[1] = $temp[$pointer]
    if ($temp[$pointer] -eq "Warning") {
        $pointer3 = $pointer + 3
    }
    $completed[2] = $temp[$pointer+1]
    if($temp[$pointer3] -eq " " -or $temp[$pointer3] -eq ""){
        if($temp[$pointer3+1] -eq " " -or $temp[$pointer3+1] -eq ""){
            if($temp[$pointer3+2] -eq " " -or $temp[$pointer3+2] -eq ""){
                if($temp[$pointer3+3] -eq " " -or $temp[$pointer3+3] -eq ""){
                    if($temp[$pointer3+4] -eq " " -or $temp[$pointer3+4] -eq ""){
                        if($temp[$pointer3+5] -eq " " -or $temp[$pointer3+5] -eq ""){
                            if($temp[$pointer3+6] -eq " " -or $temp[$pointer3+6] -eq ""){
                                if($temp[$pointer3+7] -eq " " -or $temp[$pointer3+7] -eq ""){
                                    if($temp[$pointer3+8] -eq " " -or $temp[$pointer3+8] -eq ""){
                                        if($temp[$pointer3+9] -eq " " -or $temp[$pointer3+9] -eq ""){
                                            if($temp[$pointer3+10] -eq " " -or $temp[$pointer3+10] -eq ""){
                                                if($temp[$pointer3+11] -eq " " -or $temp[$pointer3+11] -eq ""){
                                                    if($temp[$pointer3+12] -eq " " -or $temp[$pointer3+12] -eq ""){
                                                        if($temp[$pointer3+13] -eq " " -or $temp[$pointer3+13] -eq ""){
                                                            if($temp[$pointer3+14] -eq " " -or $temp[$pointer3+14] -eq ""){
                                                                if($temp[$pointer3+15] -eq " " -or $temp[$pointer3+15] -eq ""){

                                                                }else{
                                                                    $completed[2] = $temp[$pointer3+15]
                                                                }
                                                            }else{
                                                                $completed[2] = $temp[$pointer3+14]
                                                            }
                                                        }else{
                                                            $completed[2] = $temp[$pointer3+13]
                                                        }
                                                    }else{
                                                        $completed[2] = $temp[$pointer3+12]
                                                    }
                                                }else{
                                                    $completed[2] = $temp[$pointer3+11]
                                                }
                                            }else{
                                                $completed[2] = $temp[$pointer3+10]
                                            }
                                        }else{
                                            $completed[2] = $temp[$pointer3+9]
                                        }
                                    }else{
                                        $completed[2] = $temp[$pointer3+8]
                                    }
                                }else{
                                    $completed[2] = $temp[$pointer3+7]
                                }
                            }else{
                                $completed[2] = $temp[$pointer3+6]
                            }
                        }else{
                            $completed[2] = $temp[$pointer3+5]
                        }
                    }else{
                        $completed[2] = $temp[$pointer3+4]
                    }
                }else{
                    $completed[2] = $temp[$pointer3+3]
                }
            }else{
                $completed[2] = $temp[$pointer3+2]
            }
        }else{
            $completed[2] = $temp[$pointer3+1]
        }
    }else{
        $completed[2] = $temp[$pointer3]
    }
    $completed3 = ""
    $completed[0] = ($completed[0].Trim()) -split " "
    $completed2 = $completed[0][1] + " " + $completed[0][2] + " " + $completed[0][3]
    $completed[1] = $completed[1].Trim()
    $completed[2] = $completed[2].Trim()
    for ($i = 0; $i -lt $completed[2].Length; $i++) {
        if ($completed[2][$i] -eq " ") {
            break
        }
        $completed3 = $completed3 + $completed[2][$i]
    }
    $completed[2] = $completed[2].Substring($i)
    $completed[2] = $completed[2].Trim()
    for ($j = 0; $j -lt $part1.Count; $j++) {
        if ($part1[$j,0] -eq $completed3) {
            $part3[$j] = $part3[$j] + 1
            break
        }
        if ($j -eq $part1.Count-1) {
            $part1[$counter2,0] = $completed3
            $part1[$counter2,1] = $completed[1]
            $counter2 = $counter2 + 1
            $part3.Add($counter3)
        }
    }
    $part2[$counter,0] = $completed3
    $part2[$counter,1] = "["+ $completed2 +"]"+"["+$completed[2] +"]"
    $counter = $counter + 1
}

for ($n = 0; $n -lt $part3.Count-1; $n++) {
    for ($m = 0; $m -lt $part3.Count-1; $m++) {
        if ($part3[$m] -lt $part3[$m+1]) {
            $sect = $part3[$m]
            $sect1 = $part1[$m,0]
            $sect2 = $part1[$m,1]
            $d = $m + 1

            $part3[$m] = $part3[$m+1]
            $part3[$m+1] = $sect

            $part1[$m,1] = $part1[$d,1]
            $part1[$m,0] = $part1[$d,0]
            $part1[$d,0] = $sect1
            $part1[$d,1] = $sect2
        }
    }
} 
for ($b = 0; $b -lt $part3.Count - 1; $b++){
    if ($part3[$b] -lt 4) {
        break
    }
    "["+$part1[$b,0]+"]"+" "+"["+$part1[$b,1]+"]">>$file
    "">>$file
    for ($c = 0; $c -lt $part2.Count; $c++) {
        if ($part1[$b,0] -eq $part2[$c,0]) {
            $part2[$c,1]>>$file
        }
    }
    "">>$file
}
Remove-Item -Path log.txt
Write-Output "Done."