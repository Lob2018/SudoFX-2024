@echo off
	chcp 65001
	color 0A
	:: JPACKAGE
	title JPACKAGE CREATE THE MSI
    echo.
    echo          ▒▒▒▒▒
    echo         ▒▒▒▒▒▒▒
    echo         ▒▒▒▒▒▒▒▒
    echo         ▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒
    echo         ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    echo    ▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒    ▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓  ▓▓▓▓▓▓    ▓▓▓▓     ▓▓▓▓▓▓ ▓▓▓▓▓▓▓
    echo ▒▒▒▒▒▒▒▒▒▒▓▓▓███▓▓▓▒▒▒▒▒▒▒     ▓▓▓     ▓▓▓  ▓▓▓ ▓▓▓       ▓▓▓   ▓▓▓▓      ▓▓▓▓▓     ▓▓▓    ▓▓▓ ▓▓▓
    echo ▒▒▒▒▒▒▒▒▒▓▓▓█████▓▓▓▒▒▒▒▒      ▓▓▓▓▓▓  ▓▓    ▓▓ ▓▓▓▓▓▓    ▓▓▓   ▓▓▓▓▓▓▓ ▓▓▓ ▓▓▓     ▓▓▓▓▓▓ ▓▓▓▓▓▓
    echo  ▒▒▒▒▒▒▒▒▓▓▓█████▓▓▓▒▒▒▒▒         ▓▓▓▓ ▓▓▓  ▓▓▓ ▓▓▓       ▓▓▓   ▓▓▓ ▓▓▓ ▓▓▓▓▓▓▓▓    ▓▓▓    ▓▓▓ ▓▓▓
    echo    ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒     ▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓       ▓▓▓   ▓▓▓▓▓▓▓     ▓▓▓  ▓▓ ▓▓▓    ▓▓▓  ▓▓▓
    echo        ▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒
    echo       ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    echo       ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒
    echo       ▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒
    echo        ▒▒▒▒▒
    echo.
	echo ###################################################################################################
	echo #                                     JPACKAGE CREATE THE MSI                                     #
	echo ###################################################################################################
	echo.
	echo # WiX Toolset is installed
	echo # WiX's bin path is added to PATH environment variable
    echo.
    echo # Arguments from pom.xml :
    echo # This batch's path   :"%0"
	echo # App's name          :"%1"
	echo # Current version     :"%2"
	echo # Organization's name :"%3"
	echo # Main's path         :"%4"
	echo # JRE version         :"%5"

    echo.
	set "jarName=%1-%2.jar"
	set "year=%date:~6,4%"
	echo.
	echo # OUTPUT   : CLEAN
	rmdir /s /q output 2>nul
	cd ./target
	echo.
	echo # TARGET   : DELETE ALL BUT CURRENT JAR
	for %%I in (*.jar) do (
	    if /I not "%%~nxI"=="%jarName%" (
	        del "%%I"
	    )
	)
	echo.
	echo # OUTPUT   : CREATING THE MSI...
	cd ../
    jpackage --input ./target  --dest output --name %1 --type msi --main-jar %jarName% --main-class %4 --win-shortcut --win-menu --win-menu-group %1 --java-options "-Xmx2048m -Dapp.name=%1 -Dapp.version=%2" --vendor %3 --copyright "Copyright © %year% %3" --icon src/main/resources/fr/softsf/sudofx2024/images/icon.ico --app-version %2 --description "%1 %year%" --license-file LICENSE.txt --verbose
    echo.
    echo # TARGET   : THE BATCH FOR THE UBERJAR
	cd ./target
    (
        echo @echo off
        echo     chcp 65001
        echo     color 0A
        echo     echo.
        echo     echo           ▒▒▒▒▒
        echo     echo          ▒▒▒▒▒▒▒
        echo     echo          ▒▒▒▒▒▒▒▒
        echo     echo          ▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒
        echo     echo           ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        echo     echo     ▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒    ▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓  ▓▓▓▓▓▓    ▓▓▓▓     ▓▓▓▓▓▓ ▓▓▓▓▓▓▓
        echo     echo  ▒▒▒▒▒▒▒▒▒▒▓▓▓███▓▓▓▒▒▒▒▒▒▒     ▓▓▓     ▓▓▓  ▓▓▓ ▓▓▓       ▓▓▓   ▓▓▓▓      ▓▓▓▓▓     ▓▓▓    ▓▓▓ ▓▓▓
        echo     echo  ▒▒▒▒▒▒▒▒▒▓▓▓█████▓▓▓▒▒▒▒▒      ▓▓▓▓▓▓  ▓▓    ▓▓ ▓▓▓▓▓▓    ▓▓▓   ▓▓▓▓▓▓▓ ▓▓▓ ▓▓▓     ▓▓▓▓▓▓ ▓▓▓▓▓▓
        echo     echo   ▒▒▒▒▒▒▒▒▓▓▓█████▓▓▓▒▒▒▒▒         ▓▓▓▓ ▓▓▓  ▓▓▓ ▓▓▓       ▓▓▓   ▓▓▓ ▓▓▓ ▓▓▓▓▓▓▓▓    ▓▓▓    ▓▓▓ ▓▓▓
        echo     echo     ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒     ▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓▓       ▓▓▓   ▓▓▓▓▓▓▓     ▓▓▓  ▓▓ ▓▓▓    ▓▓▓  ▓▓▓
        echo     echo         ▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒
        echo     echo        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        echo     echo        ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒
        echo     echo        ▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒
        echo     echo         ▒▒▒▒▒
        echo     echo.
        echo     echo.
        echo     set JAVA_VERSION=0
        echo     for /f "tokens=3" %%%%g in ('java -version 2^^^>^^^&1 ^^^| findstr /i "version"'^) do (
        echo         set JAVA_VERSION=%%%%g
        echo     ^)
        echo     set JAVA_VERSION=%%JAVA_VERSION:"=%%
        echo     set /a JAVA_REQUIRED=%5
        echo     if %%JAVA_VERSION%% EQU 0 (
        echo         echo.
        echo         echo  ██ Java minimum version %%JAVA_REQUIRED%% is required to run this application.
        echo         echo  ██ Please install the latest Java JRE available at ▒▒ https://adoptium.net ▒▒.
        echo         echo.
        echo         pause
        echo         exit /b 1
        echo     ^)
        echo     if %%JAVA_VERSION%% LSS %%JAVA_REQUIRED%% (
        echo         echo.
        echo         echo  ██ A newer version of Java is required to run this application.
        echo         echo  ██ Your Java version is %%JAVA_VERSION%%, and requires version %%JAVA_REQUIRED%%.
        echo         echo  ██ Please install the latest Java JRE available at ▒▒ https://adoptium.net ▒▒.
        echo         echo.
        echo         pause
        echo         exit /b 1
        echo     ^)
        echo     start /min cmd /c "java -Dapp.name=SudokuFX -Dapp.version=1.0.1 -jar SudokuFX-1.0.1.jar & exit"
        echo exit
    ) > %1-%2.bat
    echo.
    echo # TARGET   : COPY THE BATCH AND THE UBERJAR TO OUTPUT
    copy %1-%2.bat ..\output
    copy %jarName% ..\output
    echo.
    echo # OUTPUT   : THE HASH FILE
    set "msiFile=%1-%2.msi"
	cd ../
	cd ./output
	(
		echo.
		CertUtil -hashfile %msiFile% MD5
	    echo.
	    CertUtil -hashfile %msiFile% SHA256
	    echo.
        CertUtil -hashfile %1-%2.bat MD5
        echo.
	    CertUtil -hashfile %1-%2.bat SHA256
        echo.
        CertUtil -hashfile %jarName% MD5
        echo.
        CertUtil -hashfile %jarName% SHA256
        echo.
	) > hash.txt
	echo.
    echo ###################################################################################################
	echo #                                             DONE !                                              #
	echo ###################################################################################################
	echo.

exit