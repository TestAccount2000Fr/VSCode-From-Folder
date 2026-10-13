$ErrorActionPreference = "Stop"

$menuKeyName = "OpenInVSCode"
$classesRoot = "HKCU:\Software\Classes"
$keysToRemove = @(
    "$classesRoot\Directory\shell\$menuKeyName",
    "$classesRoot\Directory\Background\shell\$menuKeyName"
)

foreach ($key in $keysToRemove) {
    if (Test-Path -LiteralPath $key) {
        Remove-Item -LiteralPath $key -Recurse -Force
    }
}

Write-Host "L'option « Ouvrir dans VS Code » a été supprimée." -ForegroundColor Green
