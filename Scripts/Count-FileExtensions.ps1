Get-Childitem c:\local -Recurse | where { -not $_.PSIsContainer } | group Extension -NoElement | sort count -desc