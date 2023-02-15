
set args = WScript.Arguments

set fso = CreateObject("Scripting.FileSystemObject")
set file = fso.OpenTextFile(args(0))

Function sortedOutput(dict)
    Dim convertedArray()
        For i=0 To dict.Count - 1
            keysList = dict.Keys
            itemsList = dict.Items
            Redim Preserve convertedArray(i)
            convertedArray(i) = keysList(i) + " - " + CStr(itemsList(i))
        Next 
    Dim splitArray()
    For i=LBound(convertedArray) To UBound(convertedArray)
        Redim Preserve splitArray(i)
        splitArray(i) = Split(convertedArray(i))
        
    Next
        For i=LBound(splitArray) To UBound(splitArray) - 1
            For j=LBound(splitArray) To UBound(splitArray) - 1
                if CInt(splitArray(j)(2)) < CInt(splitArray(j+1)(2)) Then
                temp = splitArray(j)
                splitArray(j) = splitArray(j+1)
                splitArray(j+1) = temp
            End If
        Next
    Next

    top = splitArray(0)(2)
    cnt = 0

    For i=LBound(splitArray) To args(1)-1
        cnt = cnt + 1
        WScript.Echo splitArray(i)(0), splitArray(i)(1), splitArray(i)(2), CInt(top / cnt)
    Next    
    tmm = args(1)-1
    i = 0
    Do Until tmm = 0
        
        if InStr(1,splitarray(i)(0),"'") > 0 Then
            WScript.Echo splitArray(i)(0), splitArray(i)(1), splitArray(i)(2)
            tmm = tmm - 1
            
        End if
        
        i = i + 1
        if i = Ubound(splitArray) Then
            tmm = 0
        End if
    Loop


End Function


set dict = CreateObject("Scripting.Dictionary")
Dim currline

Do Until file.AtEndOfStream
    currline = file.ReadAll
    currline = currline + " "
    currline = Split(currline)
    for i=LBound(currline) to UBound(currline)
        line = currline(i)
        line = LCase(line)
        line = Replace(line,".", chr(0))
        line = Replace(line,",", chr(0))
        line = Replace(line,"*", chr(0))
        line = Replace(line,"_", chr(0))
        line = Replace(line,chr(34), chr(0))
        line = Replace(line,chr(63), chr(0))
        line = Replace(line,chr(33), chr(0))
        line = Replace(line,chr(32), chr(0))
        line = Replace(line,chr(9), chr(0))
        

        if line = "his" or line = "him" Then
            line = "he"
        End If
        if line = "has" or line = "had" Then
            line = "have"
        End If
        if line = "her" or line = "hers" Then
            line = "she"
        End If

        if line = "do" or line = "Do" Then
            next_line = currline(i+1)
            next_line = Replace(next_line,".", "")
            next_line = Replace(next_line,",", "")
            next_line = Replace(next_line,chr(34), "")
            next_line = Replace(next_line,chr(63), "")
            next_line = Replace(next_line,chr(33), "")
            if next_line = "not" or next_line = "Not" Then
                line = "don't"
                i = i + 1
            End If
        End If
        if line = "can" or line = "Can" Then
            next_line = currline(i+1)
            next_line = Replace(next_line,".", "")
            next_line = Replace(next_line,",", "")
            next_line = Replace(next_line,chr(34), "")
            next_line = Replace(next_line,chr(63), "")
            next_line = Replace(next_line,chr(33), "")
            if next_line = "not" or next_line = "Not" Then
                line = "can't"
                i = i + 1
            End If
        End If
        if line = "it" or line = "It" Then
            next_line = currline(i+1)
            next_line = Replace(next_line,".", "")
            next_line = Replace(next_line,",", "")
            next_line = Replace(next_line,chr(34), "")
            next_line = Replace(next_line,chr(63), "")
            next_line = Replace(next_line,chr(33), "")
            if next_line = "is" or next_line = "Is" Then
                line = "it's"
                i = i + 1
            End If
        End If
        if NOT dict.Exists(line) Then
            dict.Add line, 1
        Else
            dict(line) = dict(line) + 1
        End if
    next

    if dict("") Then
        dict.Remove("")
    End if
    sortedOutput(dict)
Loop
