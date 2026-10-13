# Open in VS Code from the Windows context menu

These scripts add an **Open in VS Code** option to the Windows context menu:

- when right-clicking a selected folder;
- in the empty space inside an open folder.

The installation is performed only for the current Windows user and does not
require administrator privileges.

## Installation

1. Make sure Visual Studio Code is installed.
2. Right-click `install_open_in_vscode.ps1`.
3. Select **Run with PowerShell**.

When the installer starts, it asks you to select the language for the context
menu option and the installation messages. The installer supports the
following 10 languages:

1. English - English
2. French - Français
3. Spanish - Español
4. German - Deutsch
5. Italian - Italiano
6. Portuguese - Português
7. Russian - Русский
8. Arabic - العربية
9. Japanese - 日本語
10. Chinese - 中文

The selected language determines the text displayed in the Windows context
menu. If Windows blocks script execution, open PowerShell and run:

```powershell
powershell.exe -ExecutionPolicy Bypass -File ".\install_open_in_vscode.ps1"
```

The script automatically searches for VS Code in the `PATH`, the per-user
installation directory, and the known system installation directories.

## Uninstallation

Run `uninstall_open_in_vscode.ps1` in the same way. This removes only the
context menu entries added by this project.
