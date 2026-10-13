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

Write-Host "The option « Open in VS Code » has been removed." -ForegroundColor Green
