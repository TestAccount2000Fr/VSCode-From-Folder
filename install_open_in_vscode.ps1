$ErrorActionPreference = "Stop"

$menuName = "Ouvrir dans VS Code"
$menuKeyName = "OpenInVSCode"
$classesRoot = "HKCU:\Software\Classes"

function Get-VSCodeExecutable {
    $candidates = @(
        (Get-Command code.exe -ErrorAction SilentlyContinue).Source,
        (Join-Path $env:LOCALAPPDATA "Programs\Microsoft VS Code\Code.exe"),
        (Join-Path $env:ProgramFiles "Microsoft VS Code\Code.exe"),
        (Join-Path ${env:ProgramFiles(x86)} "Microsoft VS Code\Code.exe")
    ) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }

    $executable = $candidates | Select-Object -First 1
    if (-not $executable) {
        throw "VS Code est introuvable. Installez VS Code ou ajoutez code.exe au PATH, puis relancez ce script."
    }

    return (Resolve-Path -LiteralPath $executable).Path
}

function Set-MenuEntry {
    param(
        [Parameter(Mandatory)]
        [string] $ParentKey,

        [Parameter(Mandatory)]
        [string] $TargetArgument
    )

    $menuKey = Join-Path $ParentKey $menuKeyName
    $commandKey = Join-Path $menuKey "command"

    New-Item -Path $menuKey -Force | Out-Null
    Set-Item -Path $menuKey -Value $menuName
    New-ItemProperty -Path $menuKey -Name "Icon" -Value $script:vsCodeExecutable -PropertyType String -Force | Out-Null

    New-Item -Path $commandKey -Force | Out-Null
    $command = '"' + $script:vsCodeExecutable + '" "' + $TargetArgument + '"'
    Set-Item -Path $commandKey -Value $command
}

$vsCodeExecutable = Get-VSCodeExecutable

# Clic droit sur un dossier sélectionné.
Set-MenuEntry -ParentKey "$classesRoot\Directory\shell" -TargetArgument "%1"

# Clic droit dans l'espace vide à l'intérieur d'un dossier.
Set-MenuEntry -ParentKey "$classesRoot\Directory\Background\shell" -TargetArgument "%V"

Write-Host "L'option « $menuName » a été installée." -ForegroundColor Green
Write-Host "VS Code utilisé : $vsCodeExecutable"
