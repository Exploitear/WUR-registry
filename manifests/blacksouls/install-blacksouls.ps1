$installDir = "$env:USERPROFILE\Games\BlackSouls"
New-Item -ItemType Directory -Path $installDir -Force

Write-Host "Extracting BLACK.SOULS.rar..."
& "C:\Program Files\WinRAR\WinRAR.exe" x -o+ ".\BLACK.SOULS.rar" "$installDir\"

# Optional: Create desktop shortcut
$ws = New-Object -ComObject WScript.Shell
$shortcut = $ws.CreateShortcut("$env:USERPROFILE\Desktop\BlackSouls.lnk")
$shortcut.TargetPath = "$installDir\BlackSouls.exe"
$shortcut.Save()

Write-Host "Installation completed."
