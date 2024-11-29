# Obtenir le répertoire dans lequel se trouve le script
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Chemin relatif vers le fichier contenant les logs
$logFilePath = Join-Path -Path $scriptDirectory -ChildPath "Logs.log"

# Chemin relatif vers le fichier contenant la liste des programmes
$programsFilePath = Join-Path -Path $scriptDirectory -ChildPath "..\liste-programmes.txt"

# Effacer le contenu du fichier de log s'il existe
if (Test-Path $logFilePath) {
    Clear-Content -Path $logFilePath
}

# Vérifier si Chocolatey est installé
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Désinstallation impossible car une erreur s'est produite au niveau du package Chocolatey." -ForegroundColor Red
    exit 1
}

# Lire la liste des programmes à désinstaller
$programsToUninstall = Get-Content -Path $programsFilePath | Where-Object { $_ -notmatch "^\s*$" } | ForEach-Object { $_.Trim() }

# Vérifier si la liste est vide
if ($programsToUninstall.Count -eq 0) {
    Write-Host "Aucun programme à désinstaller. Vérifiez le fichier liste-programmes." -ForegroundColor Yellow
    exit 1
}


Write-Host ""
Write-Host ""
Write-Host "Désinstallation de toutes les applications en cours d'exécution..." -ForegroundColor green

 Write-Host "|" -ForegroundColor red
 Write-Host "| Programme en activité, veuillez patienter..." -ForegroundColor red 
 Write-Host "|" -ForegroundColor red
 Write-Host ""

# Désinstaller les programmes spécifiés dans la liste
foreach ($program in $programsToUninstall) {
    Write-Host "Tentative de désinstallation de $program ..." -ForegroundColor Yellow
    choco uninstall $program -y --force >> $logFilePath 2>&1

    
            if ($LASTEXITCODE -eq 0) {
                # Désinstallation réussie, affichage de la barre verte
                Write-Host "              Réussite              " -BackgroundColor Green
                Write-Host ""  
            } else {
                # Désinstallation échouée, affichage de la barre rouge
                Write-Host "               Échec               " -BackgroundColor Red
                Write-Host "Erreur : Le programme est mal orthographié ou n'est pas disponible. Consultez le guide d'utilisation pour plus d'informations." -ForegroundColor Red

                Write-Host "" 
                Write-Host ""
            }

}

Write-Host "Suppression des répertoires..." -ForegroundColor red 
Remove-Item -Path "C:\ProgramData\chocolatey" -Recurse -Force
Write-Host ""
Write-Host "Désinstallation terminée !" -ForegroundColor Green
