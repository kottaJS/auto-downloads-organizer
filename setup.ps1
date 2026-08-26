$targetDir = Join-Path $env:USERPROFILE ".auto-organizer"
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

Copy-Item -Path "$PSScriptRoot\organizer.ps1" -Destination "$targetDir\organizer.ps1" -Force

$startupFolder = [System.Environment]::GetFolderPath('Startup')
$vbsPath = Join-Path $startupFolder "AutoOrganizador.vbs"

$vbsContent = @"
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ""$targetDir\organizer.ps1""", 0, False
"@

Set-Content -Path $vbsPath -Value $vbsContent -Encoding ASCII

# Run once immediately
powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "$targetDir\organizer.ps1"

Write-Host "Auto-Downloads Organizer has been installed successfully!" -ForegroundColor Green
Write-Host "It will now run silently whenever Windows starts." -ForegroundColor Cyan
