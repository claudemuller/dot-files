@echo off

:: Add string entry to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor
:: AutoRun -> %USERPROFILE%\dot-files\windows-cli\alias.cmd

:: Temporary system path at cmd startup
REM set PATH=%PATH%;"C:\Program Files\Sublime Text 2\"

:: Aliases
DOSKEY v=nvim $*
