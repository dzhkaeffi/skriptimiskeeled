@echo off
echo %1 > string.txt
for /f "delims=" %%x in (string.txt) do set string=%%x

@REM Occurances

set /A alow=0 
set /A acap=0
set /A ulow=0 
set /A ucap=0
set /A olow=0 
set /A ocap=0
set /A qlow=0 
set /A qcap=0
set /A slow=0 
set /A scap=0
set /A zlow=0 
set /A zcap=0

REM ä
for /f "tokens=2 delims=:" %%a in (
'find /c "ä" "string.txt"') do set /a alow +=%%a
REM Ä
for /f "tokens=2 delims=:" %%a in (
'find /c "Ä" "string.txt"') do set /a acap +=%%a
REM ü
for /f "tokens=2 delims=:" %%a in (
'find /c "ü" "string.txt"') do set /a ulow +=%%a
REM Ü
for /f "tokens=2 delims=:" %%a in (
'find /c "Ü" "string.txt"') do set /a ucap +=%%a
REM ö
for /f "tokens=2 delims=:" %%a in (
'find /c "ö" "string.txt"') do set /a olow +=%%a
REM Ö
for /f "tokens=2 delims=:" %%a in (
'find /c "Ö" "string.txt"') do set /a ocap +=%%a
REM ?
for /f "tokens=2 delims=:" %%a in (
'find /c "õ" "string.txt"') do set /a qlow +=%%a
REM ?
for /f "tokens=2 delims=:" %%a in (
'find /c "Õ" "string.txt"') do set /a qcap +=%%a
REM ?
for /f "tokens=2 delims=:" %%a in (
'find /c "š" "string.txt"') do set /a zlow +=%%a
REM ?
for /f "tokens=2 delims=:" %%a in (
'find /c "Ž" "string.txt"') do set /a zcap +=%%a
REM ü
for /f "tokens=2 delims=:" %%a in (
'find /c "š" "string.txt"') do set /a slow +=%%a
REM Ü
for /f "tokens=2 delims=:" %%a in (
'find /c "Š" "string.txt"') do set /a scap +=%%a

@REM format
set string=%string:ä=&auml;%
set string=%string:Ä=&Auml;%
set string=%string:ü=&uuml;%
set string=%string:Ü=&Uuml;%
set string=%string:ö=&ouml;%
set string=%string:Ö=&Ouml;%
set string=%string:õ=&otilde;%
set string=%string:Õ=&Otilde;%
set string=%string:ž=PRIVACY MESSAGE%
set string=%string:Ž=SINGLE SHIFT TWO%
set string=%string:š=SINGLE CHARACTER INTRODUCER%
set string=%string:Š=LINE TABULATION set%

echo %string%

if %alow% GTR 0 echo ä: %alow%
if %acap% GTR 0 echo Ä: %acap%
if %ulow% GTR 0 echo ü: %ulow%
if %ucap% GTR 0 echo Ü: %ucap%
if %olow% GTR 0 echo ö: %olow%
if %ocap% GTR 0 echo Ö: %ocap%
if %qlow% GTR 0 echo õ: %qlow%
if %qcap% GTR 0 echo Õ: %qcap%
if %zlow% GTR 0 echo ž: %zlow%
if %zcap% GTR 0 echo Ž: %zcap%
if %slow% GTR 0 echo š: %slow%
if %scap% GTR 0 echo Š: %scap%
set /A total=%alow%+%acap%+%ulow%+%ucap%+%olow%+%ocap%+%qlow%+%qcap%+%zlow%+%zcap%+%slow%+%scap%
if %total% LSS 1 (echo Ei leidnud ühtegi täpitähte.) else (echo Kokku: %total%)

del string.txt
pause