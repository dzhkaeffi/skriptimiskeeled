set args = WScript.Arguments

imagePath = args(0)
destinationFolder = args(1)




' WScript.Echo getLastModified(imagePath)(2) '0 1 2 /3

set objFso = CreateObject("scripting.filesystemobject")
getsubfolders objFso.GetFolder(imagePath)

sub getsubfolders(foldername)

    for each subfolder in foldername.SubFolders
        getsubfolders(subfolder)
    Next

    for each file in foldername.Files
        'WScript.Echo file.name
        lastModified = Split(Replace(file.DateLastModified, ".", " "))
        'WScript.Echo lastModified(0)
        temp = lastModified(0)
        temp = Split(Replace(temp, "/", " "))
        'WScript.Echo temp(0)
    Next
        
    Dim years
    Set years = CreateObject("Scripting.Dictionary")
    Dim days
    Set days = CreateObject("Scripting.Dictionary")
    Dim moved
    Set moved = CreateObject("Scripting.Dictionary")

    for each file in foldername.Files
        lastModified = Split(Replace(file.DateLastModified, ".", " "))
        temp = lastModified(0)
        
        temp = Split(Replace(temp, "/", " "))
        
        if NOT years.Exists(temp(2)) Then
            years.Add temp(2), 1
        End if
        if NOT days.Exists(temp(2) + "\" + temp(0) +"-"+ temp(1)) Then
            days.Add (temp(2) + "\" + temp(0) +"-"+ temp(1)), 1
        End if
    Next
    folderCount = 0
    for each key in years
        folderCount = folderCount + 1
        If Not objFso.FolderExists(destinationfolder +  "\" + key) Then
            Set newfolder = objFso.CreateFolder(destinationfolder +  "\" + key) 
        end If
    Next
    fileCount = 0
    for each key in days
        folderCount = folderCount + 1
        If Not objFso.FolderExists(destinationfolder +  "\" + key) Then
            Set newfolder = objFso.CreateFolder(destinationfolder +  "\" + key)
        end If
    Next
    

    for each file in foldername.Files
        fileCount = fileCount + 1
        lastModified = Split(Replace(file.DateLastModified, ".", " "))
        temp = lastModified(0)
        temp = Split(Replace(temp, "/", " "))
        endpath = destinationfolder +  "\" + temp(2) + "\" + temp(0) +"-"+ temp(1) + "\" + file.name
        
        if NOT moved.Exists("\" + temp(2) + "\" + temp(0) +"-"+ temp(1) + "\") Then
            moved.Add ("\" + temp(2) + "\" + temp(0) +"-"+ temp(1) + "\"), file.name
        Else
            moved("\" + temp(2) + "\" + temp(0) +"-"+ temp(1) + "\") = moved("\" + temp(2) + "\" + temp(0) +"-"+ temp(1) + "\") + "," + file.name
        End if

        'WScript.Echo endpath
        objFso.CopyFile file, endpath
    Next
    WScript.Echo fileCount, "pictures were sorted into", folderCount, "folders"
    for Each key in moved
        WScript.Echo moved(key)
    
        WScript.Echo destinationFolder + key

        WScript.Echo "------------------------"
    Next
End sub ' getsubfolders

'getsubfolders(objfolder)