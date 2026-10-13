# Open in VS Code from the Windows context menu

These PowerShell scripts add an **Open in VS Code** option to the Windows
context menu:

- when right-clicking a selected folder;
- in the empty space inside an open folder.

The installation is performed only for the current Windows user and does not
require administrator privileges.

## Requirements

- Windows 10 or Windows 11;
- PowerShell 5.1 or PowerShell 7;
- Visual Studio Code installed on the computer.

## Project structure

```text
.
├── LICENSE
├── README.md
└── scripts
    ├── install_open_in_vscode.ps1
    └── uninstall_open_in_vscode.ps1
```

## Installation

1. Make sure the requirements are met.
2. Open the `scripts` folder.
3. Right-click `install_open_in_vscode.scripts`.
4. Select **Run with PowerShell**.

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
menu. If Windows blocks script execution, open PowerShell from the repository
root and run:

```powershell
powershell.exe -ExecutionPolicy Bypass -File ".\scripts\install_open_in_vscode.scripts"
```

The script automatically searches for VS Code in the `PATH`, the per-user
installation directory, and the known system installation directories.

## Uninstallation

Run `uninstall_open_in_vscode.scripts` from the `scripts` folder, or run the following
command from the repository root:

```powershell
powershell.exe -ExecutionPolicy Bypass -File ".\scripts\uninstall_open_in_vscode.scripts"
```

This removes only the context menu entries added by this project.

## Registry changes and security

The installer adds entries only under the current user's registry hive:

```text
HKCU\Software\Classes\Directory\shell
HKCU\Software\Classes\Directory\Background\shell
```

It does not modify system-wide registry settings and does not require
administrator privileges. As with any PowerShell script downloaded from the
internet, review the source before running it and only execute it if you trust
the repository and its contents.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE)
file for details.
