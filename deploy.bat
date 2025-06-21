@echo off
REM ===========================
REM CONFIGURATION DES VARIABLES
REM ===========================
set APP_NAME=Piciculture
set SRC_DIR=src\main\java
set BUILD_DIR=build
set LIB_DIR=lib
set WEB_DIR=src\main\webapp
set TOMCAT_WEBAPPS=D:\tomcat-10.1.28-windows-x64\apache-tomcat-10.1.28\webapps
set SERVLET_API_JAR=%LIB_DIR%\jakarta.servlet-api-6.0.0.jar
set MYSQL_JAR=%LIB_DIR%\mysql-connector-j-9.2.0.jar
set WAR_NAME=%APP_NAME%.war

REM ========================================
REM Étape 0 : Nettoyage de l'ancien dossier build
REM ========================================
if exist "%BUILD_DIR%" (
    echo Nettoyage de l'ancien dossier build...
    rmdir /s /q "%BUILD_DIR%"
)
mkdir "%BUILD_DIR%\WEB-INF\classes"

REM ========================================
REM Étape 1 : Compilation des fichiers Java
REM ========================================
if not exist "%SRC_DIR%" (
    echo Erreur : Les fichiers source Java sont introuvables.
    pause
    exit /b 1
)

REM Vérifier l'existence des JAR requis
if not exist "%SERVLET_API_JAR%" (
    echo Erreur : Le fichier %SERVLET_API_JAR% est introuvable.
    pause
    exit /b 1
)

if not exist "%MYSQL_JAR%" (
    echo Erreur : Le fichier %MYSQL_JAR% est introuvable.
    pause
    exit /b 1
)

REM Compilation
dir /b /s "%SRC_DIR%\*.java" > sources.txt
javac -cp "%SERVLET_API_JAR%;%MYSQL_JAR%" -d "%BUILD_DIR%\WEB-INF\classes" @sources.txt

if errorlevel 1 (
    echo Erreur : Échec de la compilation. Vérifiez vos fichiers Java.
    del sources.txt
    pause
    exit /b 1
)
del sources.txt

REM =========================================
REM Étape 2 : Copie des fichiers webapp dans build
REM =========================================
if not exist "%WEB_DIR%" (
    echo Erreur : Les fichiers webapp sont introuvables.
    pause
    exit /b 1
)

xcopy "%WEB_DIR%\*" "%BUILD_DIR%\" /e /i /q >nul
if errorlevel 1 (
    echo Erreur : Échec de la copie des fichiers webapp.
    pause
    exit /b 1
)

REM =========================================
REM Étape 2.5 : Copier le fichier MySQL JDBC dans WEB-INF\lib
REM =========================================
mkdir "%BUILD_DIR%\WEB-INF\lib"
copy "%MYSQL_JAR%" "%BUILD_DIR%\WEB-INF\lib\" >nul
if errorlevel 1 (
    echo Erreur : Impossible de copier le connecteur MySQL dans WEB-INF\lib.
    pause
    exit /b 1
)


REM =========================================
REM Étape 3 : Création du fichier WAR
REM =========================================
pushd "%BUILD_DIR%"
jar -cvf "../%WAR_NAME%" * >nul
if errorlevel 1 (
    echo Erreur : Échec de la création du fichier .war.
    popd
    pause
    exit /b 1
)
popd

REM =========================================
REM Étape 4 : Déploiement vers Tomcat
REM =========================================
if not exist "%TOMCAT_WEBAPPS%" (
    echo Erreur : Le dossier webapps de Tomcat est introuvable.
    pause
    exit /b 1
)

copy "%WAR_NAME%" "%TOMCAT_WEBAPPS%\" >nul
if errorlevel 1 (
    echo Erreur : Impossible de copier le fichier .war vers Tomcat.
    pause
    exit /b 1
)

REM =========================================
REM Fin
REM =========================================
echo Déploiement terminé avec succès !
echo Le fichier .war a été copié dans %TOMCAT_WEBAPPS%.
pause
