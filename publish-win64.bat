@echo off
call publish Histacom win-x64 Release
if %errorlevel% neq 0 exit /b %errorlevel%