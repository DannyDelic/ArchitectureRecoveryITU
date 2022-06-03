function Add-Tabstops{
    param($Count)
    $tabs = ""
    for($i=0; $i -lt $Count; $i++){$tabs += "  "}
    return $tabs
}

function Output-JsonChildren{
    param($Path, $Level = 1)
    return $(Get-ChildItem -Path $Path | Where-Object{$_} | ForEach-Object{
        (Add-Tabstops $Level) +
        "{`n" + 
        (Add-Tabstops ($Level+1)) +
        "`"name`"`: `"$($_.Name)`"," + 
        "`n" +
        (Add-Tabstops ($Level+1)) + 
        "`"children`": ["+ 
        $(if($_.psiscontainer){"`n" + (Output-JsonChildren -Path $_.FullName -Level ($Level+2))+ "`n" + (Add-Tabstops ($Level+1))}) +
        "]`n" + 
        (Add-Tabstops ($Level)) +
        "}"
    }) -join ",`n"
}

$JSON = Output-JsonChildren -Path "enter your path"
"["
$JSON
"]"