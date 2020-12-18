@echo off
set "SCRIPT_DIR=%~dp0"
set "SRC_DIR=%SCRIPT_DIR%src\"

rmdir /s /q %SCRIPT_DIR%publish

for /d %%i in ("%SRC_DIR%*") do (
	pushd "%%i"
	rmdir /s /q bin
	rmdir /s /q obj
	popd
)
