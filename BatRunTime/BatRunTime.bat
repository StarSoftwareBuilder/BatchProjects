@echo off&Setlocal enabledelayedexpansion
REM ���ܣ�������������ʱ��
REM �汾��20160107
title BatRunTime - ������������ʱ�� F_Ms ^| ���ͣ�f-ms.cn
if "%~1"=="/?" goto help
if not "%~1"=="" (
	set batruntimekz=
	call:localtime
	echo=#��ʱ��ʼ
	for /f "tokens=1,* delims= " %%a in ("%*") do set batruntimekz=%%b
)

::����������봦
:command
if defined user set user=
if "%~1"=="" (
	set /p user=#�����뱻��ʱ���
	if defined user (
		call:localtime
		start /wait "BatRunTime��ʱ��...  !user!" cmd /c !user!
	) else goto command
) else (
	start /wait "BatRunTime��ʱ��...  %~1 %batruntimekz%" cmd /c "%~1" %batruntimekz%
)
::�������������
call:localtime %localtime%
if "%localtime:~2,1%"=="" (set localtime=0.%localtime%) else set localtime=%localtime:~0,-2%.%localtime:~-2%
echo=#��ʱ���� %localtime%��
goto end


REM ����
:help
echo=	------------------------
echo=               %~n0
echo=
echo=        �����������е�ʱ�������
echo=        �ж϶��������Ч�ʱȶ�
echo=
echo=	%~n0
echo=	    ���������Command
echo=
echo=	%~n0 file
echo=	    call file %%2
echo=
echo=	%~n0 command
echo=	    cmd /c command %%2 ...
echo=
echo=	------------------------
echo=                           F_Ms
goto end

:localtime
for %%a in (localtime timeh timem times timems) do set %%a=
for /f "tokens=1,2,3,4 delims=:." %%1 in ("%time%") do set timeh=%%1&set timem=%%2&set times=%%3&set timems=%%4
set /a timeh=timeh*3600*100,timem=timem*60*100,times=times*100
set /a localtime=timeh+timem+times+timems
if not "%1"=="" set /a localtime=localtime-%1
goto :eof

:end
pause>nul 2>nul
exit /b