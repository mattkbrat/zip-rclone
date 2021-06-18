REM | zip.bat source_dir work_dir

REM Get The Date Tokens and Time in ISO Format:

for /f "usebackq skip=1 tokens=1-6" %%g in (`wmic Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year ^| findstr /r /v "^$"`) do (
  set day=00%%g
  set hours=00%%h
  set minutes=00%%i
  set month=00%%j
  set seconds=00%%k
  set year=%%l
  )
set month=%month:~-2%
set day=%day:~-2%
set hh=%hours:~-2%
set mm=%minutes:~-2%
set ss=%seconds:~-2%
set thedatetime=%year%%month%%day%%hh%%mm%%s%

set _Dst=%2\%thedatetime%
echo "%_Dst%"
echo "%_Src%"

REM Run 7Zip Command:
"C:\Program Files\7-Zip\7z.exe" a -bd -tZip "%_Dst%" "%1"

REM Delete original folder
DEL /S /Q %1

REM RClone backup to sftp drive
REM cd C:\Program Files\rclone
REM rclone copyto %_Dst%.zip sftp:%thedatetime%.zip


(
  EndLocal
  Exit /B
)