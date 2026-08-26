' Invisible Startup Launcher for Auto-Downloads Organizer
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ""C:\Users\maxip\auto-organizer.ps1""", 0, False
