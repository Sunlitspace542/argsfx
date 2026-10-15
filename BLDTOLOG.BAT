cls
set path=%path%;c:\bin
set lib=;c:\lib\
set include=;c:\include\
set tmp=;c:\tmp\
cd SFX\ARGSFX
make > ..\..\build.log
cd ..\..
pause
exit
