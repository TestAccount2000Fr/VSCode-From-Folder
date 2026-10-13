$ErrorActionPreference = "Stop"

$menuName = "Open in VS Code"
$menuKeyName = "OpenInVSCode"
$classesRoot = "HKCU:\Software\Classes"

$languages = [ordered]@{
    "1" = @{
        Name = "English - English"
        MenuName = "Open in VS Code"
        InstalledMessage = "The option « {0} » has been installed."
        UsedMessage = "VS Code used: {0}"
    }
    "2" = @{
        Name = "French - Français"
        MenuName = "Ouvrir dans VS Code"
        InstalledMessage = "L’option « {0} » a été installée."
        UsedMessage = "VS Code utilisé : {0}"
    }
    "3" = @{
        Name = "Spanish - Español"
        MenuName = "Abrir en VS Code"
        InstalledMessage = "La opción « {0} » se ha instalado."
        UsedMessage = "VS Code utilizado: {0}"
    }
    "4" = @{
        Name = "German - Deutsch"
        MenuName = "In VS Code öffnen"
        InstalledMessage = "Die Option « {0} » wurde installiert."
        UsedMessage = "Verwendetes VS Code: {0}"
    }
    "5" = @{
        Name = "Italian - Italiano"
        MenuName = "Apri in VS Code"
        InstalledMessage = "L’opzione « {0} » è stata installata."
        UsedMessage = "VS Code utilizzato: {0}"
    }
    "6" = @{
        Name = "Portuguese - Português"
        MenuName = "Abrir no VS Code"
        InstalledMessage = "A opção « {0} » foi instalada."
        UsedMessage = "VS Code utilizado: {0}"
    }
    "7" = @{
        Name = "Russian - Русский"
        MenuName = "Открыть в VS Code"
        InstalledMessage = "Пункт « {0} » установлен."
        UsedMessage = "Используется VS Code: {0}"
    }
    "8" = @{
        Name = "Arabic - العربية"
        MenuName = "فتح في VS Code"
        InstalledMessage = "تم تثبيت الخيار « {0} »."
        UsedMessage = "إصدار VS Code المستخدم: {0}"
    }
    "9" = @{
        Name = "Japanese - 日本語"
        MenuName = "VS Code で開く"
        InstalledMessage = "「{0}」をインストールしました。"
        UsedMessage = "使用する VS Code: {0}"
    }
    "10" = @{
        Name = "Chinese - 中文"
        MenuName = "在 VS Code 中打开"
        InstalledMessage = "已安装 « {0} » 选项。"
        UsedMessage = "使用的 VS Code：{0}"
    }
}

Write-Host "Select the language for the context-menu option:"
foreach ($language in $languages.GetEnumerator()) {
    Write-Host ("{0}. {1}" -f $language.Key, $language.Value.Name)
}

do {
    $languageChoice = Read-Host "Enter a number (1-10)"
    $selectedLanguage = $languages[$languageChoice]
    if (-not $selectedLanguage) {
        Write-Warning "Invalid selection. Please enter a number from 1 to 10."
    }
} while (-not $selectedLanguage)

$menuName = $selectedLanguage.MenuName

function Get-VSCodeExecutable {
    $candidates = @(
        (Get-Command code.exe -ErrorAction SilentlyContinue).Source,
        (Join-Path $env:LOCALAPPDATA "Programs\Microsoft VS Code\Code.exe"),
        (Join-Path $env:ProgramFiles "Microsoft VS Code\Code.exe"),
        (Join-Path ${env:ProgramFiles(x86)} "Microsoft VS Code\Code.exe")
    ) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }

    $executable = $candidates | Select-Object -First 1
    if (-not $executable) {
        throw "VS Code could not be found. Install VS Code or add code.exe to your PATH, then rerun this script."
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

# Right-click on a selected folder.
Set-MenuEntry -ParentKey "$classesRoot\Directory\shell" -TargetArgument "%1"

# Right-click in the empty space inside a folder.
Set-MenuEntry -ParentKey "$classesRoot\Directory\Background\shell" -TargetArgument "%V"

Write-Host ($selectedLanguage.InstalledMessage -f $menuName) -ForegroundColor Green
Write-Host ($selectedLanguage.UsedMessage -f $vsCodeExecutable)
