# Disable startup apps via Task Scheduler
Get-ScheduledTask | Where-Object {$_.State -eq 'Ready' -and $_.Actions.Execute -notlike 'C:\Windows*' -and $_.Principal.UserID -eq $env:USERNAME} | Disable-ScheduledTask

# Disable startup apps via Registry (HKCU)
Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' | Where-Object {$_.PSChildName -notlike 'Windows*' -and $_.PSChildName -notin ('', ' ')} | ForEach-Object {
  Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name $_.PSChildName -Value ''
}

# Disable startup apps via Registry (HKLM)
Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' | Where-Object {$_.PSChildName -notlike 'Windows*' -and $_.PSChildName -notin ('', ' ')} | ForEach-Object {
  Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name $_.PSChildName -Value ''
}

# Disable startup apps in the Startup folder
$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
Get-ChildItem -Path $startupFolder -Filter "*.lnk" | ForEach-Object {
  $shortcut = New-Object -ComObject WScript.Shell
  $targetPath = $shortcut.CreateShortcut($_.FullName).TargetPath
  if ($targetPath -notlike 'C:\Windows*') {
    Remove-Item $_.FullName -Force
  }
}