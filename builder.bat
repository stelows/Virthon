@echo off

REM Vérifier si Python est déjà installé
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python est déjà installé.
    goto install_packages
)

REM Définir la version de Python à télécharger (changez la version si nécessaire)
set "PYTHON_VERSION=3.10.0"

REM Définir le lien de téléchargement
set "PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-amd64.exe"

REM Télécharger Python
echo Téléchargement de Python...
bitsadmin /transfer "PythonDownload" "%PYTHON_URL%" "%TEMP%\python-%PYTHON_VERSION%-amd64.exe"

REM Installer Python
echo Installation de Python...
"%TEMP%\python-%PYTHON_VERSION%-amd64.exe" /quiet InstallAllUsers=1 PrependPath=1

REM Vérifier si l'installation a réussi
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo Python a été installé avec succès.
) else (
    echo Une erreur s'est produite lors de l'installation de Python.
    goto end
)

:install_packages
REM Installer les dépendances depuis le fichier requirements.txt
echo Installation des dépendances depuis requirements.txt...
python -m pip install -r requirements.txt

REM Vérifier si l'installation des dépendances a réussi
if %errorlevel% equ 0 (
    echo Dépendances installées avec succès.
) else (
    echo Une erreur s'est produite lors de l'installation des dépendances.
    goto end
)

REM Exécuter votre programme Python
echo Exécution du programme...
python builder.pyw

:end
exit