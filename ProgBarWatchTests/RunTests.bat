rem Unit test launching script for the 

@echo off
setlocal

rem Replace with your tested application folder
set APP_DIR=F:\Eclipse workspace\ProgBarWatch\ProgBarWatchApplication\

set GARMIN_HOME=C:\ConnectIQ SDKs\connectiq-sdk-win-2.2.4\

rem Keep this script located in the Tests folder
set TEST_DIR=%~dp0%
set RESULT_DIR=%TEST_DIR%TestResults

echo "====Running the unit tests===="

rem Get current date and time for the result file name
rem Hatered for windows cmd shell ++...
set DATETIME=%date%_%time%
set DATETIME=%DATETIME: =_%
set DATETIME=%DATETIME::=%
set DATETIME=%DATETIME:/=_%
set DATETIME=%DATETIME:.=_%

echo "Start your horses"
call connectiq

rem This building process should be more automated...

"java" -Dfile.encoding=UTF-8 -Dapple.awt.UIElement=true -jar "%GARMIN_HOME%bin\monkeybrains.jar" -o "%TEST_DIR%bin\ProgBarWatchTests.prg" -w -y F:\Keys\Garmin.der -z "%APP_DIR%resources\drawables\drawables.xml";"%APP_DIR%resources\layouts\layout.xml";"%APP_DIR%resources\settings\properties.xml";"%APP_DIR%resources\settings\settings.xml";"%APP_DIR%resources\strings\strings.xml";"%APP_DIR%resources-ces\strings\strings.xml";"%APP_DIR%resources-deu\strings\strings.xml" -m "%TEST_DIR%manifest.xml" "%TEST_DIR%source\ProgBarWatchViewMock.mc" "%TEST_DIR%source\ProgBarWatchTestsApp.mc" "%TEST_DIR%Tests\DateTimeUtility\DateTimeUtilityTests.mc" "%TEST_DIR%Tests\ProgressBar\ProgressBarTests.mc" "%TEST_DIR%Tests\ActivityUtility\ActivityUtilityTests.mc" "%TEST_DIR%Tests\ActivityUtility\ActivityInfoMock.mc" "%APP_DIR%source\utility\SystemUtility.mc" "%APP_DIR%source\utility\DateTimeUtility.mc" "%APP_DIR%source\utility\ActivityUtility.mc" "%APP_DIR%source\ProgBarWatchView.mc" "%APP_DIR%source\drawables\ProgressBar.mc" "%APP_DIR%source\exceptions\InvalidValueException.mc" --unit-test

rem Here it should be checked if the build was successful before running the tests...

echo "Do the monkey business..."

if not exist "%RESULT_DIR%" mkdir "%RESULT_DIR%"

call monkeydo.bat ".\bin\ProgBarWatchTests.prg" /t > ".\TestResults\TestResult_%DATETIME%.txt"
echo "Tests done, see the results..."

pause
endlocal