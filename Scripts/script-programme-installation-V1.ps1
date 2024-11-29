# Obtenir le répertoire dans lequel se trouve le script
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Chemin relatif vers le fichier contenant la liste des programmes
$programsFilePath = Join-Path -Path $scriptDirectory -ChildPath "..\liste-programmes.txt"

# Chemin relatif vers le fichier contenant les logs
$logFilePath = Join-Path -Path $scriptDirectory -ChildPath "Logs.log"

# Effacer le contenu du fichier de log s'il existe
if (Test-Path $logFilePath) {
    Clear-Content -Path $logFilePath
}

# Vérifier si le fichier des programmes existe et création de tableau 
if (Test-Path $programsFilePath) {
    $programsList = Get-Content $programsFilePath | Where-Object { $_ -match '\S' }

    # Vérifier si la liste est vide 
    if ($programsList.Count -gt 0) {
        $totalApps = $programsList.Count
        $currentApp = 0

        # Définir les étapes du processus globale
        $etapes = @(
            @{ Nom = "Téléchargement de Chocolatey"; Actions = 1 },
            @{ Nom = "Installation de Chocolatey"; Actions = 1 },
            @{ Nom = "Installation des programmes"; Actions = $programsList.Count }
        )

        # Initialisation barre de progression global
        $totalActions = $etapes | ForEach-Object { $_.Actions } | Measure-Object -Sum | Select-Object -ExpandProperty Sum
        $progress = 0

        # Afficher la barre de progression global 
        $percentComplete = [Math]::Round(($progress / $totalActions * 100), 2)  # Arrondir à deux décimales
        Write-Progress -Activity "Progression globale" -Status "En cours - $percentComplete% complété" -PercentComplete $percentComplete -Id 1 
    
        #saute 7 lignes
        1..8 | ForEach-Object { Write-Host "" }


        # Téléchargement de Chocolatey
        Write-Host "Téléchargement du programme d'installation en cours..."
        Start-Sleep -Seconds 1
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) *>&1 | Out-File -Append -FilePath $logFilePath 
        # Mise à jour la barre de progression
        $progress += $etapes[0].Actions
        $percentComplete = [Math]::Round(($progress / $totalActions * 100), 2)  # Arrondir à deux décimales
        Write-Progress -Activity "Progression globale" -Status "En cours - $percentComplete% complété" -PercentComplete $percentComplete -Id 1

        # Installation de Chocolatey 
        Write-Host "Traitement des fichiers du programme en cours..."
        Start-Sleep -Seconds 5 >> $logFilePath
        # Mise à jour la barre de progression
        $progress += $etapes[1].Actions
        $percentComplete = [Math]::Round(($progress / $totalActions * 100), 2)  # Arrondir à deux décimales
        Write-Progress -Activity "Progression globale" -Status "En cours - $percentComplete% complété" -PercentComplete $percentComplete -Id 1

        # Affichage de l'indicateur visuel pour l'installation des programmes
        Write-Host "|" -ForegroundColor red
        Write-Host "| Programme en activité, veuillez patienter..." -ForegroundColor red
        Write-Host "|" -ForegroundColor red

        $firstIteration = $true

        foreach ($App in $programsList) {    
            # Installer l'application
            Write-Host "Téléchargement et installation de $App" 
            
            $installOutput = choco install $App -y >> $logFilePath 2>&1

        
            if ($LASTEXITCODE -eq 0) {
                # Installation réussie, affichage de la barre verte
                Write-Host "              Réussite              " -BackgroundColor Green
                Write-Host ""  
            } else {
                # Installation échouée, affichage de la barre rouge
                Write-Host "               Échec               " -BackgroundColor Red
                Write-Host "Erreur : Le programme spécifié est mal orthographié ou non disponible. Pour plus d'informations, veuillez vous référer au guide d'utilisation." -ForegroundColor red
                Write-Host "" 
                Write-Host ""
            }

            # Mise à jour la barre de progression
            $currentApp++
            $progress += 1
            $percentComplete = [Math]::Round(($progress / $totalActions * 100), 2)  # Arrondir à deux décimales
            Write-Progress -Activity "Progression globale" -Status "En cours - $percentComplete% complété" -PercentComplete $percentComplete -Id 1
        }


        # Fin de l'installation
        Write-Progress -Activity "Téléchargement et installation des programmes" -Status "Terminé" -PercentComplete 100 -Completed
        Write-Host "Installation terminée !" -ForegroundColor green 
        Start-Sleep -Seconds 5
    } else {
        Write-Host "Erreur avec la liste de Programmes : La liste est vide." -ForegroundColor red 
    }
} else {
    Write-Host "Erreur avec la liste de Programmes : le fichier n'existe pas." -ForegroundColor red 
}
