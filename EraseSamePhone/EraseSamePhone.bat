@echo off
setlocal ENABLEDELAYEDEXPANSION

title �ı��ĵ��绰ȥ���ظ����� ^| F_Ms ^| f-ms.cn ^| 20160303

REM �ж����л���
if "%~1"=="" (
	echo=#ʹ�÷�����
	echo=	��Ҫȥ�ص��ı��ļ��ϵ��������ļ�
	pause
	exit/b
) else if exist "%~1" (
	if /i not "%~x1"==".txt" if not exist "%~1\" (
		echo=#ע�⣺
		echo=	��Ǹ��ֻ֧���ı��ļ�^(��չ��Ϊ.txt���ļ�^)���ļ���
		echo=	���Ƚ��ĵ�ת��Ϊ�ı��ļ�^(���ļ���^)���ϵ��������ļ���^(�Ǳ�����^)
		pause
		exit/b
	) 
) else (
	echo=#���棺
	echo=	��Ǹ���ļ�������
	pause
	exit/b
)


set fileName=%~1
set filePath=%~dp1
if exist "%~1\" set filePath=%~1\
set fileNewName=%~dp1%~n1_ȥ���ظ���%~x1
if exist "%~1\" set fileNewName=%~1_ȥ���ظ���\
set QQCF_Count=0


if exist "%fileNewName%" (
	echo=#���棺
	if exist "%fileName%\" (
		if exist "%fileNewName%" (
			echo=	Ŀ¼ "%fileNewName%" �Ѵ���
			echo=	���������
			pause>nul
			exit/b
		)
	) else echo=	�ļ� "%~nx1" �Ѵ���
	echo=	����������ǣ��رմ�����ȡ��
	pause>nul
	(if a==b echo=a)>"%fileNewName%"
)
cls

echo=_______________________________________________
echo=
echo=#���ڲ����ظ�

if exist "%fileName%\" (
	echo=	�������ļ������ļ���ȥ��˳������ؼ����������
	echo=	��������رձ����ں����������ļ������ļ�
	echo=
	for %%I in ("%filePath%*.txt") do echo=	%%I
	pause
	md "%fileNewName%"
	for %%I in ("%filePath%*.txt") do for /f "usebackq tokens=1,* delims=	 " %%a in (`type "%%~I"`) do if "%%~b"=="" (call:One "%fileNewName%%%~nxI" %%~a %%~b) else call:Two "%fileNewName%%%~nxI" %%~a %%~b
) else for /f "usebackq tokens=1,* delims=	 " %%a in (`type "%fileName%"`) do if "%%~b"=="" (call:One "%fileNewName%" %%~a %%~b) else call:Two "%fileNewName%" %%~a %%~b
echo=
echo=_______________________________________________
echo=
echo= �����ظ���������ɸѡ�� %QQCF_Count% ���ظ�����
echo= ȥ���ظ����ݺ��ļ�(��)Ϊ��%~n1_ȥ���ظ���%~x1
echo=                                         F_Ms
echo=_______________________________________________
echo=
pause
goto end

:�ӳ���ʼ

REM ���������ж�
:One
set QCCF_-Temp=%~2
REM if "%QCCF_-Temp:~0,1%"=="-" set QCCF_-Temp=%QCCF_-Temp:~1%
if defined QCCF-%QCCF_-Temp% (
	set /a QQCF_Count+=1
	echo=	�����ظ���%QCCF_-Temp%
) else (
	echo=%QCCF_-Temp%>>"%~1"
	set QCCF-%QCCF_-Temp%=0
)
exit/b


REM ��������ж�
:Two
set tempTwoVar=
:Two2
set QCCF_-Temp=%~2
REM if "%QCCF_-Temp:~0,1%"=="-" set QCCF_-Temp=%QCCF_-Temp:~1%
if defined QCCF-%QCCF_-Temp% (
	set /a QQCF_Count+=1
	echo=	�����ظ���%QCCF_-Temp%
) else (
	set tempTwoVar=!tempTwoVar!	%QCCF_-Temp%
	set QCCF-%QCCF_-Temp%=0
)

if not "%~3"=="" (
	shift/2
	goto Two2
)
set tempTwoVar2=
if defined tempTwoVar (
	set tempTwoVar2=!tempTwoVar: =!
	set tempTwoVar2=!tempTwoVar2:	=!
)
if defined tempTwoVar2 echo=!tempTwoVar:~1!>>"%~1"
exit/b


:�ӳ������
:end