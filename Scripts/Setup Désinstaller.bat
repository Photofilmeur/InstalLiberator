@echo off
setlocal

REM Récupérer le chemin complet du dossier du script batch
set "SCRIPT_DIR=%~dp0"

REM Définir le chemin du script PowerShell à exécuter
set "SCRIPT_UNINSTALL=%SCRIPT_DIR%script-programme-desinstallation-V1.ps1"



REM Exécuter le script PowerShell
powershell.exe -ExecutionPolicy Bypass -File "%SCRIPT_UNINSTALL%"

pause
exit




