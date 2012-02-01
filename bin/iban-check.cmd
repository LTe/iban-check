@echo off
rem %~dp0 returns the absolute path where the current script is. We just append 'iban-check' to it, and forward all the arguments with %*
ruby "%~dp0iban-check" %*
