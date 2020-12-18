@echo off
set "SCRIPT_DIR=%~dp0"
set "SRC_DIR=%SCRIPT_DIR%src\"
set "SCRIPT_NAME=%~0"
set "PUBLISH_DIR=%SCRIPT_DIR%publish\"

set "MAIN_PROJECT=%~1"
set "RID=%~2"
set "CONFIGURATION=%~3"

set "DOTNET_VERSION=net5.0"
set "MAIN_PROJECT_DIR=%SRC_DIR%%MAIN_PROJECT%\"

if "%RID%"=="" (
	call :printUsage
	goto :eof
)

if "%RID%"=="win-x64" (
	set "PLATFORM=x64"
	set "TARGETOS=Windows"
) else (
	echo Unknown Runtime Identifier, valid values are "win-x64"
	goto :eof
)

if "%CONFIGURATION%"=="Debug" (
	set "CONFIGURATION=Debug"
) else if "%CONFIGURATION%"=="Release" (
	set "CONFIGURATION=Release"
) else if "%CONFIGURATION%"=="" (
	set "CONFIGURATION=Release"
) else (
	echo Unknown configuration, valid values are "Debug" and "Release"
)

set "PUBLISH_DIR=%PUBLISH_DIR%%RID%\%CONFIGURATION%\"

pushd %MAIN_PROJECT_DIR%
dotnet publish -c %CONFIGURATION% -r %RID% -property:Platform=%Platform%;TargetOS=%TARGETOS%
popd
rmdir /s /q %PUBLISH_DIR%
mkdir %PUBLISH_DIR%
xcopy /e /q /y "%MAIN_PROJECT_DIR%bin\%PLATFORM%\%CONFIGURATION%\%DOTNET_VERSION%\%RID%\publish\*" "%PUBLISH_DIR%"
del %PUBLISH_DIR%%MAIN_PROJECT%.deps.json
del %PUBLISH_DIR%%MAIN_PROJECT%.runtimeconfig.json
del %PUBLISH_DIR%*.pdb

goto :eof

:printUsage
echo usage: %SCRIPT_NAME% project rid [config]
goto :eof
