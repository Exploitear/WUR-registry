$installDir = "$env:USERPROFILE\Games\BlackSouls"
New-Item -ItemType Directory -Path $installDir -Force

Write-Host "Extracting Black Souls game..."
& "C:\Program Files\WinRAR\WinRAR.exe" x -o+ ".\blacksouls.rar" "$installDir\"

Write-Host "Extracting RTC..."
& "C:\Program Files\WinRAR\WinRAR.exe" x -o+ ".\rtc.rar" "$installDir\RTC\"

# Optional: Create desktop shortcut
$ws = New-Object -ComObject WScript.Shell
$shortcut = $ws.CreateShortcut("$env:USERPROFILE\Desktop\BlackSouls.lnk")
$shortcut.TargetPath = "$installDir\BlackSouls.exe"
$shortcut.Save()

Write-Host "Installation completed."
