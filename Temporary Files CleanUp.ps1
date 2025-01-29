# Clean up temporary files
Remove-Item -Path $env:TEMP\* -Recurse -Force
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force

# Clear the Recycle Bin
Clear-RecycleBin -Force

# Optimize disk space
Optimize-Volume -DriveLetter C -ReTrim -Verbose