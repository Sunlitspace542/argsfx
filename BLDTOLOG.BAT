cls
set path=%path%;c:\bin
cd SFX\ARGSFX
masm argsfx.asm > ..\..\build.log
cd ..\..
pause
exit
