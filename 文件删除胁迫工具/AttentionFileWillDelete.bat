REM ����
	REM �趨����ĳ��ʱ������ɾ��ĳ���ļ�(��)�Ҳ��ɻָ�
	REM �Դ���в�Լ��𴲻�����������

REM ������
	REM ��Ҫ�����û�����ʱ���
	REM ��Ҫ�ж�ʱ����ҽ�����һ������

REM ʵ�֣�
	REM ��ʾ�û�����һ��ʱ���
		REM ����ʱ�������ж�
		REM ��ʾ�û��Ƿ�ȷ��
	REM ��ʾ�û�����һ���ļ����ļ���
		REM �ж�ʱ����ļ����Ƿ����
		REM ��ʾ�û��Ƿ�ȷ��

REM ȫ�ֳ�ʼ��
@echo off
setlocal ENABLEDELAYEDEXPANSION
color 0a
set version=20151218
title �ļ�ɾ��в�ȹ��� - F_Ms - %version% ^| imf_ms@yeah.net ^| f-ms.cn

:InputTime
for %%A in (userTime userTimeTemp userTimeCount userTimeMinute userTimeHour tomorrowRun) do set %%A=
cls

REM ��ʾ�û�����ִ��ʱ��
echo=#�ļ�ɾ��в�ȹ���
echo=#ʱ�����ӣ�
echo=	    ʱ ��
echo=	     3 5  (3��5��)
set/p userTime=#в��ʱ���:

REM �ж�ʱ���Ƿ���ϱ�׼
if not defined userTime goto InputTime
set userTimeTemp=%userTime: =%
if not defined userTimeTemp goto InputTime
call:DefinedNoNumberString "%userTime: =%"
if "%errorlevel%"=="0" goto InputTime
for %%A in (%userTime%) do set /a userTimeCount+=1
if not "%userTimeCount%"=="2" goto InputTime
for /f "tokens=1,2" %%A in ("%userTime%") do (
	set userTimeHour=%%A
	set userTimeMinute=%%B
	if not "!userTimeHour:~2,1!"=="" goto InputTime
	if not "!userTimeMinute:~2,1!"=="" goto InputTime

	if %%A0 lss 0 goto InputTime
	if %%A0 gtr 230 goto InputTime
	if %%B0 lss 0 goto InputTime
	if %%B0 gtr 600 goto InputTime

	if "!userTimeHour:~1,1!"=="" set userTimeHour=0!userTimeHour!
	if "!userTimeMinute:~1,1!"=="" set userTimeMinute=0!userTimeMinute!
	set userTime=!userTimeHour!!userTimeMinute!
)

REM �ж�ִ��ʱ��
call:CurrentTime
if %currentTime% geq %userTime% set tomorrowRun=Yes


REM ��ʾ�û����뱻ִ��ɾ���ļ�
:InputFile
cls
for %%A in (userFile) do set %%A=
set /p userFile=#�뽫в���ļ�(��)����˴��ڲ��س�ȷ��:
if not defined userFile goto InputFile
set userFile=%userFile:"=%
if not exist "%userFile%" goto InputFile

echo=#���óɹ�
ping -n 2 127.1>nul 2>nul

:DisplayMessage
cls
echo=
echo=		%userTimeHour%��%userTimeMinute%��
echo=
echo=	"%userFile%"
echo=
echo=		����ɾ��
echo=
echo=		   ��
echo=
echo=		���ɻָ�
echo=
echo=	   ����֮ǰ���������
echo=
echo=	 ���߲��Խ�����κ�����
echo=

:WaitTime
if not defined tomorrowRun goto WaitTime2
call:CurrentTime
if %userTime%0 geq %CurrentTime%0 goto WaitTime2
ping -n 11 127.1>nul 2>nul
goto WaitTime

:WaitTime2
call:CurrentTime
if %CurrentTime%0 geq %userTime%0 goto DeleteFile
ping -n 11 127.1>nul 2>nul 
goto WaitTime2

REM ��ֹ�������
exit

:DeleteFile
cls
echo=
echo=	�����Ӻ�ִ��ɾ������
echo=
echo=	     �����������
ping -n 121 127.1>nul 2>nul
del /f /q "%userFile%"
if exist "%userFile%" rd /s /q "%userFile%"
cls
echo=
echo=
echo=		��Ǹ

pause>nul
exit





goto end
:�ӳ���ʼ:

:CurrentTime
REM ��ʼ���ӳ���
for %%a in (currentTime) do set %%a=

REM ����ʱ��
for /f "tokens=1,* delims=:" %%a in ("%time%") do if %%a0 lss 100 (
	set currentTime=0%%a%%b
) else (
	set currentTime=%%a%%b
)
REM �淶ʱ��
set currentTime=%currentTime:.=%
set currentTime=%currentTime::=%
set currentTime=%currentTime: =%
set currentTime=%currentTime:~0,-4%

REM �˳�������ֵ
exit/b

REM �жϱ������Ƿ��з������ַ� call:DefinedNoNumberString ���ж��ַ�
REM					����ֵ0�����з������ַ�������ֵ1�����޷������ַ�
:DefinedNoNumberString
REM �ж��ӳ�������������
if "%~1"=="" exit/b 2

REM ��ʼ���ӳ����������
for %%B in (DefinedNoNumberString) do set %%B=
set DefinedNoNumberString=%~1

REM �ӳ���ʼ����
set DefinedNoNumberString=!DefinedNoNumberString:0=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:1=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:2=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:3=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:4=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:5=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:6=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:7=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:8=!
if not defined DefinedNoNumberString exit/b 1
set DefinedNoNumberString=!DefinedNoNumberString:9=!
if not defined DefinedNoNumberString (exit/b 1) else exit/b 0

:�ӳ������
:end