@echo off
title Uninstalling Auto-Downloads Organizer
powershell -ExecutionPolicy Bypass -Command "$targetDir = Join-Path $env:USERPROFILE '.auto-organizer'; if (Test-Path $targetDir) { Remove-Item -Path $targetDir -Recurse -Force }; $vbs = Join-Path ([System.Environment]::GetFolderPath('Startup')) 'AutoOrganizador.vbs'; if (Test-Path $vbs) { Remove-Item -Path $vbs -Force }"
echo Auto-Downloads Organizer uninstalled successfully.
echo.
pause
