# Ouvrir dans VS Code depuis le clic droit

Ces scripts ajoutent **Ouvrir dans VS Code** au menu contextuel de Windows :

- sur un dossier sélectionné ;
- dans l'espace vide d'un dossier ouvert.

L'installation est faite uniquement pour l'utilisateur Windows courant et ne
demande pas de droits administrateur.

## Installation

1. Vérifiez que Visual Studio Code est installé.
2. Faites un clic droit sur `install_open_in_vscode.ps1`.
3. Choisissez **Exécuter avec PowerShell**.

Si Windows bloque l'exécution des scripts, ouvrez PowerShell puis lancez :

```powershell
powershell.exe -ExecutionPolicy Bypass -File ".\install_open_in_vscode.ps1"
```

Le script détecte automatiquement VS Code dans le `PATH`, dans l'installation
utilisateur et dans les installations système connues.

## Désinstallation

Lancez `uninstall_open_in_vscode.ps1` de la même manière. Cette opération
supprime uniquement les entrées ajoutées par ce projet.
