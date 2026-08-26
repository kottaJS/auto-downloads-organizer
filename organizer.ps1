# Auto-Downloads Organizer for Windows
# Automatically categorizes and organizes your Downloads folder.

$downloads = "$env:USERPROFILE\Downloads"

$categories = @{
    "Documents"        = "\.(pdf|doc|docx|txt|pptx|ppt|xlsx|xls|csv|odt)$"
    "Images"           = "\.(png|jpg|jpeg|webp|svg|gif|ico|psd|ai|bmp)$"
    "Videos"           = "\.(mp4|mkv|avi|mov|webm|flv)$"
    "Audio"            = "\.(mp3|wav|ogg|flac|m4a)$"
    "Installers"       = "\.(exe|msi|bat|ps1|msix)$"
    "Archives"         = "\.(zip|rar|7z|tar|gz|iso)$"
    "Code_and_Scripts" = "\.(js|ts|py|html|htm|css|json|sql|rbxl|ini)$"
}

$ignorePattern = "\.(crdownload|tmp|part|download)$"

foreach ($catName in ($categories.Keys + "Other")) {
    $targetPath = Join-Path $downloads $catName
    if (-not (Test-Path $targetPath)) {
        New-Item -ItemType Directory -Path $targetPath | Out-Null
    }
}

$files = Get-ChildItem -Path $downloads -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -notmatch $ignorePattern }

foreach ($file in $files) {
    $matchedCategory = "Other"
    foreach ($cat in $categories.Keys) {
        if ($file.Extension -match $categories[$cat]) {
            $matchedCategory = $cat
            break
        }
    }

    $destPath = Join-Path $downloads $matchedCategory
    Move-Item -Path $file.FullName -Destination $destPath -Force -ErrorAction SilentlyContinue
}
