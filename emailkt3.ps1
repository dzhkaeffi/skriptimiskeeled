$mem = "mem.txt"
if (-not(Test-Path -Path mem.txt -PathType Leaf)) {
    "1" >> $mem
    $kaust = Read-Host "Please enter the folder path."
}
$boolean = 1
$files = Get-ChildItem $kaust -Filter *.pdf
[string[]]$array = Get-Content -Path $mem
foreach ($f in $files){
    Write-Output $f.FullName
    for ($i = 0; $i -lt $array.Count; $i++) {
        if ($array[$i] -eq $f.FullName) {
            $boolean = 0
        }
    }
    if ($boolean -eq 1) {
        $f.FullName>>$mem
        Add-Type -Path "C:\Users\dzika\Desktop\payment\itextsharp.dll"
        $pdf = New-Object iTextSharp.text.pdf.pdfreader -ArgumentList $f.FullName
        for ($page = 1; $page -le $pdf.NumberOfPages; $page++){
            $text=[iTextSharp.text.pdf.parser.PdfTextExtractor]::GetTextFromPage($pdf,$page)
            $text2 = $text -split "`n" 
        }
        $pdf.Close()
        $teema = $text2[1] + $text2[2]
        $ettevote = $text2[4]
        $kokku = $text2[$text2.Length-4] -split " "
        $ostja = $text2[3] -split " "
        $kliendikood = $text2[8] -split " "
        $arvenumber = $text2[10] -split " "
        Write-Output $teema
        Write-Output $ettevote
        Write-Output $kokku[2]
        Write-Output ($ostja[2] + " " + $ostja[3])
        Write-Output $kliendikood[2]
        Write-Output $arvenumber[2]
        $part1 = $ettevote + ", " + $kokku[2] + "`n" + "Ostja: " + ($ostja[2] + " " + $ostja[3]) + "`n" + "Ettevote: " + $ettevote + "`n" + "Kliendi kood: " + $kliendikood[2] + "`n" + "Maksmise viis: Pangaulekanne / Sularahas Arve number: " + $arvenumber[2] + "`n" + "Kokku: "+ $kokku[2] +" euro"
        Send-MailMessage -To "Kaeff <dzikajev@gmail.com>" -Subject $teema -Body $part1 -From "Kaeff <dzikajev@gmail.com>" -SmtpServer smtp.gmail.com -Credential (Get-Credential) -Port 587 -UseSsl -Attachments $f.FullName
    }
    
}

