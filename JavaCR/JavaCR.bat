@echo off&setlocal ENABLEDELAYEDEXPANSION
title JavaCR - ����Java�ı��������� - F_Ms ^| imf_ms@yeah.net ^| f-ms.cn ^| 20160106
REM ������л���
if "%~1"=="" (goto help) else if not exist "%~1" goto help

REM ����
:Compile
title JavaCR - ����Java�ı��������� - F_Ms ^| imf_ms@yeah.net ^| f-ms.cn ^| 20160106
cls
set runClass=
echo=#JavaCR
if /i "%~x1"==".java" (
	echo=#���ڵ�������javac����Դ�ļ� %~nx1
	pushd "%~dp1"
	javac -d . "%~1"
	popd
	if "!errorlevel!"=="9009" (
		echo=
		echo=	#����:δ����javac.exe,�����Ƿ��ѳɹ���װJDK���Ƿ��ѳɹ�����path·��
		pause>nul
		goto end
	) else if not "!errorlevel!"=="0" (
		echo=#���뷢�ִ���,���������
		pause
		cls
		goto Compile
	) else (
		echo=#����ɹ�
	)
) else (
	if /i "%~x1"==".class" (
		goto Run
	) else (
		echo=#�ļ����ʹ���,ֻ����.java��.class
		pause>nul
		goto end
	)
)

:Run
REM ����
if defined userInput set userInput=
REM ������а���java�ļ�
if defined runClass goto Run2
for /f "usebackq tokens=1,2 delims=p; " %%a in ("%~1") do if "%%a"=="ackage" (
	set runClass=%%b.%~n1
	goto Run2
)
set runClass=%~n1
:Run2
echo=#���ڵ���java������ %runclass%
pushd "%~dp1"
title ����������: %runClass%
cls
java %runClass%
popd
if "!errorlevel!"=="9009" (
		echo=
		echo=	#����:δ����java.exe,�����Ƿ��ѳɹ���װJDK���Ƿ��ѳɹ�����path·��
		pause>nul
		goto end
) else if not "%errorlevel%"=="0" (
	echo=#���д������������
	pause>nul
	goto Compile
)
set /p userInput=#�س���������,�ո�س����±�������,Alt+Space+C����˳�:
if "%userInput%"=="" (goto Run) else goto Compile

goto end
REM ����
:help
echo=
echo=#����
echo=
echo=			JavaCR - ����Java�ı���������
echo=
echo=	�����Ԥ�Ȱ�װ�ɹ�JDK,Java���л��� �������óɹ���װĿ¼ϵͳ��������
echo=
echo=	#ʹ�÷���Ϊ %~nx0 [*.javaԴ�����ļ�^|*.class�ֽ����ļ�]
echo=
echo=		  �Ƽ���ӵ�����༭�������ڲ���ӵ��ÿ�ݼ�
echo=					-
echo=		 F_Ms ^| imf_ms@yeah.net ^| f-ms.cn ^|  20151220
echo=
pause>nul
:end
exit/b