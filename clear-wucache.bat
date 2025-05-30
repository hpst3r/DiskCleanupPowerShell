@echo off
REM This script clears the Windows Update cache by stopping services and nuking the directory.
REM You will want to run this as an administrator.

net stop BITS
net stop wuauserv
net stop appidsvc
net stop cryptsvc

REM a direct deletion will not work for odd permissions reasons
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old

REM nuke all the files in the directory
REM /S recursively, /F forces delete of read-only files, /Q quiet mode (no prompt)
del /S /F /Q C:\Windows\SoftwareDistribution.old

REM delete the old directory itself
REM /S recursively, /Q quiet mode (no prompt)
rmdir /S /Q C:\Windows\SoftwareDistribution.old

net start BITS
net start wuauserv
net start appidsvc
net start cryptsvc