@echo off
cd /d "%~dp0"
color 0a
setlocal ENABLEDELAYEDEXPANSION
REM �趨�汾��������Ϣ
set project=VNC_BookLink
set version=20160114
set workViewerAppUrl=http://imfms.vicp.net/VNC_BookLink-UltraVNC_Viewer.exe
set workWindowManageAppUrl=http://imfms.vicp.net/cmdow.exe
set workResolutionGetAppUrl=http://imfms.vicp.net/scrnres.exe

REM ���ñ���
title VNC_BookLink VNCͨѶ¼���ӹ��� - F_Ms_%version%

REM �趨ȫ�ֻ�������
set workDir=#VNC_BookLink
set workBook=%workDir%\%workDir%_Book.ini
set workConnectConfig=%workDir%\%workDir%.ini
set workViewerApp=%workDir%\UltraVNC_Viewer.exe
set workWindowManageApp=%workDir%\cmdow.exe
set workResolutionGetApp=%workDir%\scrnres.exe
set workConfig=%workDir%\%workDir%_ConncetConfig.ini

REM ��鹤��Ŀ¼�������ļ�
for %%a in (userInput) do set %%a=
if not exist "%workDir%\" md "%workDir%\"
if not exist "%workBook%" (if a==b echo=�������ļ�)>"%workBook%"
set userInput=
if not exist "%workViewerApp%" (
	set /p userInput=#���ӳ���UltraVNC_Viewer.exe�����ڣ����� Y ���أ�����������������
	if defined userInput (
		if /i "!userInput!"=="y" (
			echo=#��������:
			echo=	���ط����ǵ���VBS�ű������ܻᱻ����,���μ���
			echo=	����Ϊ��UltraVNC�������ص�1.2.0.9_x86�汾
			echo=	�˰汾�ᱻ����,����ԭ����,����ʹ��δ�����쳣
			echo=	�粻���Ŀɵ�UltraVNC�����������ش˰汾
			call:DownloadNetFile "%workViewerAppUrl%" "%workViewerApp%"
			if "!errorlevel!"=="0" (
				set tips=�������������سɹ�
			) else (
				echo=#����ʧ��,��������
				ping -n 3 127.1>nul 2>nul
				set tips=��������������ʧ��,��������
			)
		)
	)
)
if not exist "%workConfig%" (
	echo=;���ڴ�����VNC_Viewer���Ӳ���
	echo=;����Ҫ����ʱȫ��ֱ������һ����� /fullscreen ����
	echo=;�������ò����ɲ鿴������VNC_Viewer��������
	echo=;ע��:���������������������
	echo=;ֻ�з�;��ͷ��һ��������Ч,�뽫���в���ֱ��д�뵽��һ��
)>"%workConfig%"
for /f "usebackq" %%a in ("%workConfig%") do (
	set workVNC_Config=%%a
	goto DefinedClient
)
set workVNC_Config=
REM �������˵�
:DefinedClient
cls
echo=
if defined tips (
	echo=#VNC�ͻ���ͨѶ¼ ^| ��ʾ��%tips%
	set tips=
) else echo=#VNC�ͻ���ͨѶ¼

REM ����Ƿ����пͻ���
for /f "usebackq" %%a in ("%workBook%") do goto DefinedClient2
echo=
echo=	��⵽ͨѶ¼�ͻ���Ϊ�գ��������һ����
call:AddClient2Book
goto DefinedClient

:DefinedClient2
REM ��ʾͨѶ¼�ͻ���
for %%a in (definedClientEchoDijia definedClientInput) do set %%a=
echo=____________________________^|UVNC-Viewer,cmdow,scrnres
echo=
echo=#����	����		��ַ			��ע
for /f "usebackq tokens=1-3,5 delims=	" %%a in ("%workBook%") do (
	set /a definedClientEchoDijia+=1
	echo=  !definedClientEchoDijia!	%%a	%%b:%%c	%%d
)
echo=______________________________________________________
echo=  ���ߣ�F_Ms ^| ���䣺imf_ms@yeah.net ^| ���ͣ�f-ms.cn

REM ����
if defined help (
	echo=
	echo=#����������ͻ������к� = ����ͻ�������
	echo=       ����ͻ������к�+�ո� = ֱ�����ӿͻ���
	echo=       ���� A = ����µĿͻ��˵�ͨѶ¼
	echo=       ���� C = ����UltraVNC-Viewer���Ӳ���
	echo=       ���� W = ��Ļǽ����
	echo=               ^(�ù���ʹ����Ritchie Lawrence��cmdow���ڿ��������й���
	echo=                ��Frank P. Westlake��scrnres��Ļ�ֱ��ʻ�ȡ����^)
	echo=           ��Ļǽָ���ͻ��˿�ʹ�õ����ָ��� , �� �������ָ��� -
	echo=               ����:������1,2,3,5,7,8,9����Ŀͻ��˼��뵽��Ļǽ����ʾ
	echo=                   1-3,5,7-9 
	set help=
) else echo=

REM ��ʾ�û���������
set /p definedClientInput=#����������:
if not defined definedClientInput (
	set help=yes
	goto DefinedClient
)
	REM ��ӿͻ���
if /i "%definedClientInput: =%"=="A" (
	call:AddClient2Book
	goto DefinedClient
)
	REM ����UltraVNC-Viewer���Ӳ���
if /i "%definedClientInput: =%"=="C" (
	start "" "%workViewerApp%" /?
	start /wait "" notepad "%workConfig%"
	for /f "usebackq" %%a in ("%workConfig%") do (
		set workVNC_Config=%%a
		goto DefinedClient
	)
	set workVNC_Config=
)
	REM ��Ļǽ����
if /i "%definedClientInput:~0,1%"=="W" (
		REM ��Ļǽ���ó�������
	if not exist "%workWindowManageApp%" (
		set userInput=
		set /p userInput=#��Ļǽ��������cmdow.exe������,���� Y ���أ�����������ȡ����
		if defined userInput (
			if /i "!userInput!"=="y" (
				echo=#��������:
				echo=	���ط����ǵ���VBS�ű������ܻᱻ����,���μ���
				call:DownloadNetFile "%workWindowManageAppUrl%" "%workWindowManageApp%"
				if "!errorlevel!"=="0" (
					set tips=cmdow.exe���سɹ�
					echo=	#cmdow.exe���سɹ�
					echo=
				) else (
					echo=#����ʧ��,��������
					ping -n 3 127.1>nul 2>nul
					set tips=cmdow.exe����ʧ��,��������
					goto DefinedClient
				)
			) else goto DefinedClient
		) else goto DefinedClient
	)
	if not exist "%workResolutionGetApp%" (
		set userInput=
		set /p userInput=#��Ļǽ��������scrnres.exe������,���� Y ���أ�����������ȡ����
		if defined userInput (
			if /i "!userInput!"=="y" (
				echo=#��������:
				echo=	���ط����ǵ���VBS�ű������ܻᱻ����,���μ���
				call:DownloadNetFile "%workResolutionGetAppUrl%" "%workResolutionGetApp%"
				if "!errorlevel!"=="0" (
					set tips=scrnres.exe���سɹ�
					echo=	#scrnres.exe���سɹ�
					echo=
				) else (
					echo=#����ʧ��,��������
					ping -n 3 127.1>nul 2>nul
					set tips=scrnres.exe����ʧ��,��������
					goto DefinedClient
				)
			) else goto DefinedClient
		) else goto DefinedClient
	)
	if "%definedClientInput:~1%"=="" (
		for %%a in (screenWallClient) do set %%a=
		set /p screenWallClient=	#��ָ����ʾ����Ļǽ�Ŀͻ���:
		if not defined screenWallClient (
			set help=yes
			goto DefinedClient
		)
	) else set screenWallClient=%definedClientInput:~1%
	call:clearPecifiedParameters "!screenWallClient!"
	if not "!errorlevel!"=="0" (
		set help=yes
		goto DefinedClient
	)
	call:screenWall "!clearPecifiedParametersResult2!"
)
REM ֱ�����ӻ����ͻ��������ж�
call:DefinedNoNumberString "%definedClientInput: =%"
if "%errorlevel%"=="1" if not "%definedClientInput%"=="0" if %definedClientInput% leq %definedClientEchoDijia% (
	call:Database_Read  "%workBook%" "	" "%definedClientInput%" "1-5" "clientName clientHost clientPort clientPassword clientRemarks"
	if "%definedClientInput:~-1%"==" " if exist "%workViewerApp%" (
		start "" "!workViewerApp!" !workVNC_Config! !clientHost!:!clientPort! /password !clientPassword!
		goto DefinedClient
	) else (
		set tips=���������򲻴��ڣ��޷�����
		goto DefinedClient
	)
	goto ClientDetail
) else set tips=���� %definedClientInput: =% �����ڣ����������
goto DefinedClient

REM �ͻ�������
:ClientDetail
for %%a in (clientDetailInput clientDetailInput2) do set %%a=
cls
echo=
if defined tips (
	echo=#�ͻ��� %clientName% ���� ^| ��ʾ��%tips%
	set tips=
) else echo=#�ͻ��� %clientName% ����
echo=___________________________________^|VNCͨѶ¼����
echo=
if exist "%workViewerApp%" (echo=	      [����1���ӵ��˿ͻ���]) else echo=	  [���������򲻴��ڣ��޷�����]
echo=
echo=	���ƣ�%clientName% [����2�޸�]
echo=
echo=	��ַ��%clientHost% [����3�޸�]
echo=
echo=	�˿ڣ�%clientPort% [����4�޸�]
echo=
echo=	���룺%clientPassword% [����5�޸�]
echo=
echo=	��ע��%clientRemarks% [����6�޸�]
echo=
echo=	[D-ɾ��] [T-��Ŀ�ö�] [0-�����ϲ�]
echo=_________________________________________________

set /p clientDetailInput=#����������:
if not defined clientDetailInput goto ClientDetail
call:DefinedNoNumberString "%ClientDetail%"
if "%errorlevel%"=="0" goto ClientDetail
if "%clientDetailInput%"=="1" (
	if exist "%workViewerApp%" (start "" "%workViewerApp%" %workVNC_Config% %clientHost%:%clientPort% /password %clientPassword%) else set tips=���������򲻴��ڣ��޷�����
)
if /i "%clientDetailInput%"=="t" (
	if not "%definedClientInput%"=="1" call:Database_Sort /q "%workbook%" "%definedClientInput%" "1"
	set tips=��Ŀ %clientName% ���ö�
)
if "%clientDetailInput%"=="2" (
	set /p clientDetailInput2=#������������:
	if defined clientDetailInput2 (
		call:Database_Update /q "%workBook%" "	" "%definedClientInput%" "1" "!clientDetailInput2!"
		call:Database_Read /q "%workBook%" "	" "%definedClientInput%" "1" clientName
		set tips=�޸����Ƴɹ�
	) else set tips=�޸�����ʧ��:�û�ȡ��
)
if "%clientDetailInput%"=="3" (
	set /p clientDetailInput2=#�������µ�ַ:
	if defined clientDetailInput2 (
		call:Database_Update /q "%workBook%" "	" "%definedClientInput%" "2" "!clientDetailInput2!"
		call:Database_Read /q "%workBook%" "	" "%definedClientInput%" "2" clientHost
		set tips=�޸ĵ�ַ�ɹ�
	) else set tips=�޸ĵ�ַʧ��:�û�ȡ��
)
if "%clientDetailInput%"=="4" (
	set /p clientDetailInput2=#�������¶˿�:
	if defined clientDetailInput2 (
		call:NetPortTest !clientDetailInput2!
		if not "!errorlevel!"=="0" (
			set tips=�˿��޸�ʧ��:�������
			goto ClientDetail
		)
		call:Database_Update /q "%workBook%" "	" "%definedClientInput%" "3" "!clientDetailInput2!"
		call:Database_Read /q "%workBook%" "	" "%definedClientInput%" "3" clientPort
		set tips=�޸Ķ˿ڳɹ�
	) else set tips=�޸Ķ˿�ʧ��:�û�ȡ��
)
if "%clientDetailInput%"=="5" (
	set /p clientDetailInput2=#������������:
	if defined clientDetailInput2 (
		call:Database_Update /q "%workBook%" "	" "%definedClientInput%" "4" "!clientDetailInput2!"
		call:Database_Read /q "%workBook%" "	" "%definedClientInput%" "4" clientPassword
		set tips=�޸�����ɹ�
	) else set tips=�޸�����ʧ��:�û�ȡ��
)
if "%clientDetailInput%"=="6" (
	set /p clientDetailInput2=#�������±�ע:
	if defined clientDetailInput2 (
		call:Database_Update /q "%workBook%" "	" "%definedClientInput%" "5" "!clientDetailInput2!"
		call:Database_Read /q "%workBook%" "	" "%definedClientInput%" "5" clientRemarks
		set tips=�޸ı�ע�ɹ�
	) else set tips=�޸ı�עʧ��:�û�ȡ��
)
if /i "%clientDetailInput%"=="d" (
	call:Database_DeleteLine /q "%workBook%" %definedClientInput% 1
	set tips=ɾ�� %clientName% �ɹ�
	goto DefinedClient
)
if "%clientDetailInput%"=="0" goto DefinedClient
goto ClientDetail

goto end
:�ӳ�������ʼ:

REM ���һ���ͻ��˵�ͨѶ¼	call:AddClient2Book
:AddClient2Book
REM �ж��ӳ�������������

REM ��ʼ���ӳ����������
for %%A in (addClientName addClientHost addClientPort addClientRemarks addClientPassword addClientName_Temp) do set %%A=

REM �ӳ�������
echo=
echo=#��ӿͻ��˵�ͨѶ¼

:AddClient2Book_ClientName
if defined addClientName set addClientName=
set /p addClientName=^|	������ͻ�������:
if not defined addClientName goto AddClient2Book_ClientName
REM �ж����ݿ����Ƿ��Ѵ��ڴ�������Ŀ
call:Database_Find /q /i "%workBook%" "	" "%addClientName%" "0" "1" "addClientName_Temp"
if "%errorlevel%"=="0" (
	echo=		#ע�⣺����Ϊ %addClientName% �Ŀͻ����Ѵ���, ������һ���µ�����
	set addClientName=
	goto AddClient2Book_ClientName
)

:AddClient2Book_ClientHost
REM ���������п��������������û����벻�������ж�
if defined addClientHost set addClientHost=
set /p addClientHost=^|	������ͻ��˵�ַ:
if defined addClientHost (
	if not "%addClientHost%"=="%addClientHost: =%" goto AddClient2Book_ClientHost
) else goto AddClient2Book_ClientHost

:AddClient2Book_ClientPort
if defined addClientPort set addClientPort=
set /p addClientPort=^|	������ͻ��˷���˿�[1-65535],������Ĭ��5900):
if defined addClientPort (
	call:NetPortTest %addClientPort%
	if not "!errorlevel!"=="0" goto AddClient2Book_ClientPort
) else set addClientPort=5900

:AddClient2Book_ClientPassword
if defined addClientPassword set addClientPassword=
set /p addClientPassword=^|	������ͻ�������:
if not defined addClientPassword goto AddClient2Book_ClientPassword

:AddClient2Book_ClientRemarks
if defined addClientRemarks set addClientRemarks=
set /p addClientRemarks=^|	�����뱸ע��Ϣ(�ɺ���):
if not defined addClientRemarks set addClientRemarks=�ޱ�ע

call:Database_Insert /q "%workBook%" "	" "%addClientName%" "%addClientHost%" "%addClientPort%" "%addClientPassword%" "%addClientRemarks%"
set tips=����Ϊ %addClientName% �Ŀͻ��� ����ӵ�ͨѶ¼
exit/b 0

REM �ж϶˿��Ƿ���ϱ�׼	call:NetPortTest �˿ں�
REM 						����ֵΪ0���ǺϹ棬1Ϊ���Ϲ�,2Ϊ�޲���
:NetPortTest
if "%~1"=="" exit/b 2
call:DefinedNoNumberString "%~1"
if "%errorlevel%"=="0" exit/b 1
if %~1 geq 1 if %~1 leq 65535 exit/b 0
exit/b 1


REM �жϱ������Ƿ��з������ַ� call:DefinedNoNumberString ���ж��ַ�
REM					����ֵ0�����з������ַ�������ֵ1�����޷������ַ�
REM �汾��20151231
:DefinedNoNumberString
REM �ж��ӳ�������������
if "%~1"=="" exit/b 2

REM ��ʼ���ӳ����������
for %%B in (DefinedNoNumberString) do set %%B=
set DefinedNoNumberString=%~1

REM �ӳ���ʼ����
for /l %%B in (0,1,9) do (
	set DefinedNoNumberString=!DefinedNoNumberString:%%B=!
	if not defined DefinedNoNumberString exit/b 1
)
exit/b 0

REM call:DownloadNetFile ��ַ ·�����ļ���
REM ���������ļ� �汾��20160114
:DownloadNetFile
REM ����ӳ���ʹ�ù�����ȷ���
if "%~2"=="" (
	echo=	#[Error %0:����2]�ļ�·�����ļ���Ϊ��
	exit/b 1
) else if "%~1"=="" (
	echo=	#[Error %0:����1]��ַΪ��
	exit/b 1
)

REM ��ʼ���ӳ����������
for %%- in (downloadNetFileTempPath downloadNetFileUrl downloadNetFileCachePath) do if defined %%- set %%-=
set downloadNetFileTempPath=%temp%\downloadNetFileTempPath%random%%random%%random%.vbs
set downloadNetFileUrl="%~1"
set downloadNetFileUrl="%downloadNetFileUrl:"=%"
set downloadNetFileFilePath=%~2

REM ���ɶ����ű�
(
	echo=Set xPost = CreateObject^("Microsoft.XMLHTTP"^)
	echo=xPost.Open "GET",%downloadNetFileUrl%,0
	echo=xPost.Send^(^)
	echo=Set sGet = CreateObject^("ADODB.Stream"^)
	echo=sGet.Mode = 3
	echo=sGet.Type = 1
	echo=sGet.Open^(^)
	echo=sGet.Write^(xPost.responseBody^)
	echo=sGet.SaveToFile "%downloadNetFileFilePath%",2
)>"%downloadNetFileTempPath%"

REM ɾ��IE�����������ݵĻ���
for /f "tokens=3,* skip=2" %%- in ('reg query "hkcu\software\microsoft\windows\currentversion\explorer\shell folders" /v cache') do if "%%~."=="" (set downloadNetFileCachePath=%%-) else set downloadNetFileCachePath=%%- %%.
for /r "%downloadNetFileCachePath%" %%- in ("%~n1*") do if exist "%%~-" del /f /q "%%~-"

REM ���нű�
cscript //b "%downloadNetFileTempPath%"

REM ɾ����ʱ�ļ�
if exist "%downloadNetFIleTempPath%" del /f /q "%downloadNetFIleTempPath%"

REM �жϽű����н��
if exist "%downloadNetFileFilePath%" (exit/b 0) else exit/b 1

REM ���ָ�������Ƿ���ϱ�׼����������
:clearPecifiedParameters
if "%~1"=="" exit/b 1
for %%a in (clearPecifiedParameters clearPecifiedParametersResult2 clearPecifiedParametersresult3) do if defined %%a set %%a=
set clearPecifiedParameters=%~1
set clearPecifiedParameters=%clearPecifiedParameters:-=%
call:DefinedNoNumberString "!clearPecifiedParameters:,=!"
if "!errorlevel!"=="0" (
	set tips=����Υ�����Ч�ַ������������
	exit/b 1
)
for %%a in (%~1) do (
	set clearPecifiedParameters=%%a
	if "!clearPecifiedParameters!"=="!clearPecifiedParameters:-=!" (
		set clearPecifiedParametersResult2=!clearPecifiedParametersResult2!,%%a
	) else (
		for /f "tokens=1,2,* delims=-" %%A in ("%%a") do (
			if "%%~A"=="" (
				set tips=�����"-"������ֵΪ�գ����������
				set help=yes
				exit/b 1
			)
			if "%%~B"=="" (
				set tips=�����"-"������ֵΪ�գ����������
				set help=yes
				exit/b 1
			)
			if not "%%~C"=="" (
				set tips="%%~A-%%~B-%%~C"����һ�������ڶ�������"-"�����������
				set help=yes
				exit/b 1
			)
			if "%%~A"=="%%~B" (
				set clearPecifiedParametersResult2=!clearPecifiedParametersResult2!,%%~A
				set clearPecifiedParametersresult3=Yes
			)
			if "%%~A"=="0" (
				set clearPecifiedParametersResult2=!clearPecifiedParametersResult2!,1-%%~B
				set clearPecifiedParametersresult3=Yes
			)
			if %%~A gtr %%~B (
				if "%%~B"=="0" (
					set clearPecifiedParametersResult2=!clearPecifiedParametersResult2!,1-%%~A
				) else (
					set clearPecifiedParametersResult2=!clearPecifiedParametersResult2!,%%~B-%%~A
				)
				set clearPecifiedParametersresult3=Yes
			)
			if not defined clearPecifiedParametersresult3 set clearPecifiedParametersResult2=!clearPecifiedParametersResult2!,%%~A-%%~B
		)
	)
)
exit/b 0

REM ��ָ�������в�����ĻǽԪ��
:screenWall
REM �����û�ָ���ͻ��˷�������
if "%~1"=="" exit/b 0
for %%a in (screenWall screenWallCount screenWall5) do set %%a=
for /f "tokens=1 delims==" %%a in ('set screenWallCount 2^>nul') do set %%a=
for /f "tokens=1 delims==" %%a in ('set screenWall 2^>nul') do set %%a=
if defined screenWall set screenWall=
REM ��⵱ǰ�Ƿ��г���Ϊ vncviewer %����% viewonly
for /f "tokens=1,8,9,*" %%a in ('%workWindowManageApp% /t /b /f') do (
	if "%%~b"=="UltraVNC_Viewer" if not "%%~c"=="." %workWindowManageApp% "%%~a" /ren ". %%~c %%~d"
)
REM ����Ļǽ����������Ԫ��λ��
:screenWall5
for %%a in (%~1) do (
	set screenWall=%%a
	if "!screenWall!"=="!screenWall:-=!" (
		if !screenWall!0 leq %definedClientEchoDijia%0 (
			if defined screenWall5 (call:screenWall2 %%a) else set /a screenWallCount+=1
		)
	) else for /f "tokens=1,2 delims=-" %%i in ("%%a") do for /l %%A in (%%i,1,%%j) do if %%A0 leq %definedClientEchoDijia%0 (
		if defined screenWall5 (call:screenWall2 %%A) else set /a screenWallCount+=1
	)
)
if not defined screenWall5 (
	
	REM ��ȡ����ϸ��
	set screenNum=0
	set screenNum_Max=0
	:screenWall3
	set /a screenNum+=1
	set /a screenNum_Max=screenNum*screenNum
	if not !screenWallCount!0 leq !screenNum_Max!0 goto screenWall3

	REM ��ȡ��ǰ��Ļ�ֱ���
	for /f "tokens=1,3 delims= " %%y in ('%workResolutionGetApp%') do (
		set screenX=%%~y
		set screenY=%%~z
	)

	REM ��ĻǽԪ�ط�����Ϣ����ȡ��λ�������
	set /a basicWallX=screenX/screenNum
	set /a basicWallY=screenY/screenNum

	REM ����ǽԪ��λ��
	set localWallLine=0
	set localWallColumn=0
	
	set screenWall5=Yes
	set screenWallCount=0
	goto screenWall5
)

REM ������Ļǽ����̨
%workWindowManageApp% @ /min
start "�˴����ڻس��ر���Ļǽ" /wait cmd /c mode con cols=55 lines=1^&%workWindowManageApp% @ /top /act^&pause^>nul
for /l %%z in (1,1,%screenWallCount%) do (
	for /f "tokens=1,2 delims=," %%x in ("!screenWall%%z!") do (
		%workWindowManageApp% %%x /end
	)
)

%workWindowManageApp% @ /res /act
exit/b 0
:screenWall2
set /a screenWallCount+=1
REM ��ȡ�����������ƺ�����������
call:Database_Read /q "%workBook%" "	" "%~1" "1-4" "clientName clientHost clientPort clientPassword"
REM �������ӵ�ָ����������viewer
start "" "!workViewerApp!" /viewonly /notoolbar /nostatus /autoscaling !clientHost!:!clientPort! /password !clientPassword!
set screenWallCount_Temp=0
:screenWall2_2
for /f "tokens=1,8,9" %%I in ('%workWindowManageApp% /t /b /f') do (
	if "%%~J"=="UltraVNC_Viewer" if not "%%~K"=="." if not "%%~K"=="��Ļǽ" (
		%workWindowManageApp% "%%~I" /ren "��Ļǽ %clientName%|%screenWallCount%"
		set screenWall%screenWallCount%=%%~I,%clientName%
	)
)
if not defined screenWall%screenWallCount% (
	set /a screenWallCount_Temp+=1
	if !screenWallCount_Temp!0 gtr 30 exit/b 0
	ping -n 3 127.1>nul 2>nul
	goto screenWall2_2
)

REM ������ĻǽԪ��λ��
set /a localWallX=basicWallX*!localWallColumn!
set /a localWallY=basicWallY*!localWallLine!
for /f "tokens=1,2 delims=," %%x in ("!screenWall%screenWallCount%!") do (
	%workWindowManageApp% %%~x /siz !basicWallX! !basicWallY! /mov !localWallX! !localWallY! /top
)
set /a localWallColumn+=1
if "!localWallColumn!0"=="!screenNum!0" (
	set localWallColumn=0
	set /a localWallLine+=1
)

exit/b 0


:---------------------Database_Insert---------------------:


REM �������ݵ�ָ���ı����ݿ��ļ���
REM call:Database_Insert [/Q(����ģʽ������ʾ����)] "����Դ" [/LN [���뵽��λ��(Ĭ�ϵײ�׷��)]] "�����зָ���" "����1" "����2" "����3" "..."
REM ���ӣ�������"data1" "data2" "data3" �� "	"Ϊ�ָ������뵽�ı����ݿ��ļ�" "c:\users\a\Database.ini"
REM					call:Database_Insert "c:\users\a\Database.ini" "	" "data1" "data2" "data3"
REM ����ֵ���飺0-����������1-���޴��У�2-�����������ӳ���
REM ע�⣺����ֵ���ֻ֧�ֵ�31�У��Ƽ��ڴ������ݵ�ʱ��ʹ���Ʊ��"	"Ϊ�ָ������Է��������ݺͷָ�������,�ı����ݿ��в�Ҫ���п��кͿ�ֵ����ֹ�������ݴ���
REM �汾:20151208
:Database_Insert
REM ����ӳ������л����������
for %%A in (d_I_ErrorPrint d_I_LineNumber d_I_Value) do set %%A=
if /i "%~1"=="/q" (
	shift/1
) else set d_I_ErrorPrint=Yes

if "%~2"=="" (
	if defined d_I_ErrorPrint echo=	[����%0:����3-ָ���ָ���Ϊ��]
	exit/b 2
)
if /i "%~2"=="/LN" if "%~3"=="" (
	if defined d_I_ErrorPrint echo=	[����%0:����3-ָ�������к�Ϊ��]
	exit/b 2
) else (
	set d_I_LineNumber=%~3
	shift/2
	shift/2
)
if defined d_I_LineNumber if %d_I_LineNumber%0 lss 10 (
	if defined d_I_ErrorPrint echo=	[����%0:����3-ָ�������к�С��1]
	exit/b 2
)
if "%~3"=="" (
	if defined d_I_ErrorPrint echo=	[����%0:����3-ָ��д������Ϊ��]
	exit/b 2
)
if "%~2"=="" (
	if defined d_I_ErrorPrint echo=	[����%0:����2-ָ���ָ���Ϊ��]
	exit/b 2
)
if "%~1"=="" (
	if defined d_I_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�Ϊ��]
	exit/b 2
) else if not exist "%~1" (
	if defined d_I_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�������:%~1]
	exit/b 2
)

REM ��ʼ������
for %%_ in (d_I_Count d_I_Pass1 d_I_Temp_File) do set %%_=
for /l %%_ in (1,1,31) do set d_I_Value%%_=
if defined d_I_LineNumber (
	set d_I_Temp_File=%~1_Temp
	if exist "%d_I_Temp_File%" del /f /q "%d_I_Temp_File%"
)

REM �ӳ���ʼ����
REM ��ȡ�û�ָ��ֵ
:Database_Insert1
set /a d_I_Count+=1
set d_I_Value%d_I_Count%=%~3
if not "%~4"=="" (
	shift/3
	goto Database_Insert1
)
for /l %%_ in (1,1,%d_I_Count%) do (
	set d_I_Value=!d_I_Value!%~2!d_I_Value%%_!
)
set d_I_Value=%d_I_Value:~1%
REM δָ�������к����
if not defined d_I_LineNumber (
	echo=%d_I_Value%
	exit/b 0
)>>"%~1"
REM ָ�������к����
REM ���������Ƿ����
set /a d_I_Pass1=%d_I_LineNumber%-1
if "%d_I_Pass1%"=="0" (set d_I_Pass1=) else set d_I_Pass1=skip=%d_I_Pass1%
for /f "usebackq %d_I_Pass1% eol=^ delims=" %%? in ("%~1") do goto Database_Insert2
if defined d_I_ErrorPrint echo=	[����%0:���:���޴���:%d_I_LineNumber%]
exit/b 1
:Database_Insert2
set d_I_Count=
REM ָ����ǰ������д����ʱ�ļ�
set /a d_I_Count2=%d_I_LineNumber%-1
if "%d_I_Count2%"=="0" goto Database_Insert3
for /f "usebackq eol=^ delims=" %%? in ("%~1") do (
	set /a d_I_Count+=1
	echo=%%?
	if "!d_I_Count!"=="%d_I_Count2%" goto Database_Insert3
)>>"%d_I_Temp_File%"
:Database_Insert3
REM д��������ݵ���ʱ�ļ�
echo=%d_I_Value%>>"%d_I_Temp_File%"

REM д������к����ݵ���ʱ�ļ�
(
	for /f "usebackq %d_I_Pass1% eol=^ delims=" %%? in ("%~1") do echo=%%?
)>>"%d_I_Temp_File%"

REM ����ʱ�ı����ݿ��ļ�����Դ�ı����ݿ��ļ�
copy "%d_I_Temp_File%" "%~1">nul 2>nul
if not "%errorlevel%"=="0" (
	if defined d_I_ErrorPrint echo=	[����%0:���:���ݸ���ʧ�ܣ�����Ȩ�޲�����ļ�������]
	exit/b 1
)
if exist "%d_I_Temp_File%" del /f /q "%d_I_Temp_File%"
exit/b 0


:---------------------Database_Read---------------------:

REM ��ָ���ļ���ָ���С�ָ���ָ�����ָ���л�ȡ���ݸ�ֵ��ָ������
REM call:Database_Read [/Q(����ģʽ������ʾ����)] "����Դ�ļ�" "�����зָ���" "����������" "�Էָ���Ϊ�ָ��N������(��Ŀ������Ŀ��֮��ʹ��,�ָ�ҿ�������ָ��-)" "������������(�������֮��ʹ�ÿո��,���зָ�)"
REM ���ӣ����ļ� "c:\users\a\Database.ini" �н��� "	" Ϊ�ָ����ĵ�4�����ݵĵ�1,2,3,6�����ݷֱ�ֵ��var1,var2,var3,var4
REM					call:Database_Read "c:\users\a\Database.ini" "	" "4" "1-3,6" "var1 var2 var3 var4"
REM ����ֵ���飺0-����������1-���޴��У�2-�����������ӳ���
REM ע�⣺����ֵ���ֻ֧�ֵ�31�У��Ƽ��ڴ������ݵ�ʱ��ʹ���Ʊ��"	"Ϊ�ָ������Է��������ݺͷָ�������,�ı����ݿ��в�Ҫ���п��кͿ�ֵ����ֹ�������ݴ���
REM �汾:20151127
:Database_Read
REM ����ӳ������л����������
set d_R_ErrorPrint=
if /i "%~1"=="/q" (shift/1) else set d_R_ErrorPrint=Yes
if "%~5"=="" (
	if defined d_R_ErrorPrint echo=	[����%0:����5-ָ������ֵ������Ϊ��]
	exit/b 2
)
if "%~4"=="" (
	if defined d_R_ErrorPrint echo=	[����%0:����4-ָ����Ŀ��Ϊ��]
	exit/b 2
)
if "%~3"=="" (
	if defined d_R_ErrorPrint echo=	[����%0:����3-ָ���к�Ϊ��]
	exit/b 2
)
if %~3 lss 1 (
	if defined d_R_ErrorPrint echo=	[����%0:����3-ָ���к�С��1:%~3]
	exit/b 2
)
if "%~2"=="" (
	if defined d_R_ErrorPrint echo=	[����%0:����2-ָ���ָ���Ϊ��]
	exit/b 2
)
if "%~1"=="" (
	if defined d_R_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�Ϊ��]
	exit/b 2
) else if not exist "%~1" (
	if defined d_R_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�������:%~1]
	exit/b 2
)

REM ��ʼ������
for %%_ in (d_R_Count d_R_Pass) do set %%_=
for /l %%_ in (1,1,31) do if defined d_R_Count%%_ set d_R_Count%%_=
set /a d_R_Pass=%~3-1
if "%d_R_Pass%"=="0" (set d_R_Pass=) else set d_R_Pass=skip=%d_R_Pass%

REM �ӳ���ʼ����
for %%_ in (%~5) do (
	set /a d_R_Count+=1
	set d_R_Count!d_R_Count!=%%_
)
set d_R_Count=
for /f "usebackq eol=^ %d_R_Pass% tokens=%~4 delims=%~2" %%? in ("%~1") do (
	for %%_ in ("!d_R_Count1!=%%~?","!d_R_Count2!=%%~@","!d_R_Count3!=%%~A","!d_R_Count4!=%%~B","!d_R_Count5!=%%~C","!d_R_Count6!=%%~D","!d_R_Count7!=%%~E","!d_R_Count8!=%%~F","!d_R_Count9!=%%~G","!d_R_Count10!=%%~H","!d_R_Count11!=%%~I","!d_R_Count12!=%%~J","!d_R_Count13!=%%~K","!d_R_Count14!=%%~L","!d_R_Count15!=%%~M","!d_R_Count16!=%%~N","!d_R_Count17!=%%~O","!d_R_Count18!=%%~P","!d_R_Count19!=%%~Q","!d_R_Count20!=%%~R","!d_R_Count21!=%%~S","!d_R_Count22!=%%~T","!d_R_Count23!=%%~U","!d_R_Count24!=%%~V","!d_R_Count25!=%%~W","!d_R_Count26!=%%~X","!d_R_Count27!=%%~Y","!d_R_Count28!=%%~Z","!d_R_Count29!=%%~[","!d_R_Count30!=%%~\","!d_R_Count31!=%%~]") do (
		set /a d_R_Count+=1
		if defined d_R_Count!d_R_Count! set %%_
	)
	exit/b 0
)
if not defined d_R_Count if defined d_R_ErrorPrint echo=	[����%0:���-���޴���:%~3]
exit/b 1


:---------------------Database_Sort---------------------:

REM ����������ʹ��ת�Ƶ�ָ����
REM call:Database_Sort [/Q(����ģʽ������ʾ����)] "����Դ" "�������к�" "������к�"
REM ���ӣ����ļ� "c:\users\a\Database.ini" �е���������ԭ�ڶ��е�λ��
REM					call:Database_Sort "c:\users\a\Database.ini" "4" "2"
REM ����ֵ���飺0-����������1-���޴��У�2-�����������ӳ���3-��������ֵ��ͬ
REM �汾:20151204
:Database_Sort
REM ����ӳ������л����������
for %%A in (d_S_ErrorPrint) do set %%A=
if /i "%~1"=="/q" (
	shift/1
) else set d_S_ErrorPrint=Yes
if "%~3"=="" (
	if defined d_S_ErrorPrint echo=	[����%0:����3-ָ�������������Ϊ��]
	exit/b 2
)
if %~3 lss 0 (
	if defined d_S_ErrorPrint echo=	[����%0:����3-ָ�������������С��0:%~2]
)
if "%~2"=="" (
	if defined d_S_ErrorPrint echo=	[����%0:����2-ָ����������Ϊ��]
	exit/b 3
)
if %~2 lss 0 (
	if defined d_S_ErrorPrint echo=	[����%0:����2-ָ����������С��0:%~2]
)
if "%~2"=="%~3" (
	if defined d_S_ErrorPrint echo=	[����%0:����2;����1:�����������������������ͬ����ʵ�����壬���������:%~2:%~3]
	exit/b 1
)
if "%~1"=="" (
	if defined d_S_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�Ϊ��]
	exit/b 2
) else if not exist "%~1" (
	if defined d_S_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�������:%~1]
	exit/b 2
)

REM ��ʼ������
for %%_ in (d_S_Count d_S_Count2 d_S_Pass1 d_S_Pass2 d_S_Pass3 d_S_Temp_File) do set %%_=
set d_S_Temp_File=%~1_Temp
if exist "%d_S_Temp_File%" del /f /q "%d_S_Temp_File%"


if %~2 lss %~3 (
	REM ǰ������
	set /a d_S_Count1=%~2-1
	REM ��ʼ�к󣬽�����ǰ
	set /a d_S_Pass1=%~2
	set /a d_S_Count2=%~3-%~2
	REM ��ʼ������
	set /a d_S_Pass2=%~2-1
	set /a d_S_LineDefinedCheck1=%~2-1
	REM �����к�(����������)
	set /a d_S_Pass3=%~3
	set /a d_S_LineDefinedCheck2=%~3-1
) else (
	REM ǰ������
	set /a d_S_Count1=%~3-1
	REM ��ʼ������
	set /a d_S_Pass1=%~2-1
	set /a d_S_LineDefinedCheck1=%~2-1
	REM ������(����������)����ʼ��֮������
	set /a d_S_Pass2=%~3-1
	set /a d_S_Count2=%~2-%~3
	set /a d_S_LineDefinedCheck2=%~3-1
	REM ��ʼ�к�����
	set /a d_S_Pass3=%~2
)

for %%_ in (d_S_LineDefinedCheck1 d_S_LineDefinedCheck2 d_S_Pass1 d_S_Pass2 d_S_Pass3) do if "!%%_!"=="0" (set %%_=) else set %%_=skip=!%%_!

REM �ж��Ƿ���ָ��ɾ����
for /f "usebackq eol=^ %d_S_LineDefinedCheck1% delims=" %%? in ("%~1") do goto Database_Sort_2
if defined d_S_ErrorPrint (
	echo=	[����:%0:���:���޴���:%~2]
)
exit/b 1
:Database_Sort_2
for /f "usebackq eol=^ %d_S_LineDefinedCheck2% delims=" %%? in ("%~1") do goto Database_Sort_3
if defined d_S_ErrorPrint (
	echo=	[����:%0:���:���޴���:%~3]
)
:Database_Sort_3

REM �ӳ���ʼ����
REM �ı����ݿ�ǰ������д��
if not "%d_S_Count1%"=="0" for /f "usebackq eol=^ delims=" %%_ in ("%~1") do (
	set /a d_S_Count+=1
	echo=%%_
	if "!d_S_Count!"=="!d_S_Count1!" goto Database_Sort1
)>>"%d_S_Temp_File%"

:Database_Sort1
set d_S_Count=
(
	if %~2 lss %~3 (
		for /f "usebackq %d_S_Pass1% eol=^ delims=" %%_ in ("%~1") do (
			set /a d_S_Count+=1
			echo=%%_
			if "!d_S_Count!"=="%d_S_Count2%" goto Database_Sort2
		)
	) else (
		for /f "usebackq %d_S_Pass1% eol=^ delims=" %%_ in ("%~1") do (
			echo=%%_
			goto Database_Sort2
		)
	)
)>>"%d_S_Temp_File%"

:Database_Sort2
set d_S_Count=
(
	if %~2 lss %~3 (
		for /f "usebackq %d_S_Pass2% eol=^ delims=" %%_ in ("%~1") do (
			echo=%%_
			goto Database_Sort3
		)
	) else (
		for /f "usebackq %d_S_Pass2% eol=^ delims=" %%_ in ("%~1") do (
			set /a d_S_Count+=1
			echo=%%_
			if "!d_S_Count!"=="%d_S_Count2%" goto Database_Sort3
		)
	)
)>>"%d_S_Temp_File%"
:Database_Sort3
for /f "usebackq %d_S_Pass3% eol=^ delims=" %%_ in ("%~1") do (
	echo=%%_
)>>"%d_S_Temp_File%"

REM ����ʱ�ı����ݿ��ļ�����Դ�ı����ݿ��ļ�
copy "%d_S_Temp_File%" "%~1">nul 2>nul
if not "%errorlevel%"=="0" (
	if defined d_S_ErrorPrint echo=	[����%0:���:���ݸ���ʧ�ܣ�����Ȩ�޲�����ļ�������]
	exit/b 1
)
if exist "%d_S_Temp_File%" del /f /q "%d_S_Temp_File%"
exit/b 0

:---------------------Database_Update---------------------:


REM �޸�ָ���ļ���ָ������ָ���ָ����ָ��ָ���е�����
REM call:Database_Update [/Q(����ģʽ������ʾ����)] "����Դ" "�����зָ���" "���޸��������ڿ�ʼ�к�" "�Էָ���Ϊ�ָ��N������(�к����к�֮��ʹ��,�ָ�ҿ�������ָ��-)" "���е�һ���޸ĺ�����" "���еڶ����޸ĺ�����" ...
REM ���ӣ����ļ� "c:\users\a\Database.ini" �е�4���� "	" Ϊ�ָ�1,2,3,6�������޸�Ϊ�ֱ��޸�Ϊ string1 string2 string3 string4
REM					call:Database_Update "c:\users\a\Database.ini" "	" "4" "1-3,6" "string1" "string2" "string3" "string4"
REM ����ֵ���飺0-����������1-���޴��У�2-�����������ӳ���
REM ע�⣺����ֵ���ֻ֧�ֵ�31�У��Ƽ��ڴ������ݵ�ʱ��ʹ���Ʊ��"	"Ϊ�ָ������Է��������ݺͷָ�������,�ı����ݿ��в�Ҫ���п��кͿ�ֵ����ֹ�������ݴ���
REM �汾:20151130
:Database_Update
REM ����ӳ������л����������
for %%A in (d_U_ErrorPrint) do set %%A=
if /i "%~1"=="/q" (
	shift/1
) else set d_U_ErrorPrint=Yes
if "%~5"=="" (
	if defined d_U_ErrorPrint echo=	[����%0:����5-ָ���޸ĺ�����Ϊ��]
	exit/b 2
)
if "%~4"=="" (
	if defined d_U_ErrorPrint echo=	[����%0:����4-ָ���к�Ϊ��]
	exit/b 2
)
if "%~3"=="" (
	if defined d_U_ErrorPrint echo=	[����%0:����3-ָ���к�Ϊ��]
	exit/b 2
)
if %~3 lss 1 (
	if defined d_U_ErrorPrint echo=	[����%0:����3-ָ���к�С��1:%~3]
	exit/b 2
)
if "%~2"=="" (
	if defined d_U_ErrorPrint echo=	[����%0:����2-�����зָ���Ϊ��]
	exit/b 2
)
if "%~1"=="" (
	if defined d_U_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�Ϊ��]
	exit/b 2
) else if not exist "%~1" (
	if defined d_U_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�������:%~1]
	exit/b 2
)
REM ��ʼ������
for %%_ in (d_U_Count d_U_Pass1 d_U_Pass2 d_U_Pass3 d_U_Temp_File d_U_FinalValue d_U_Value) do set %%_=
for /l %%_ in (1,1,31) do (
	set d_U_Value%%_=
	set d_U_FinalValue%%_=
)
set d_U_Temp_File=%~1_Temp
if exist "%d_U_Temp_File%" del /f /q "%d_U_Temp_File%"
set /a d_U_Pass3=%~3
set /a d_U_Pass2=%~3-1
set /a d_U_Pass1=%~3-1

set d_U_Pass3=skip=%d_U_Pass3%
if "%d_U_Pass2%"=="0" (set d_U_Pass2=) else set d_U_Pass2=skip=%d_U_Pass2%

REM �ж��Ƿ���ָ���޸���
for /f "usebackq eol=^ %d_U_Pass2% delims=" %%? in ("%~1") do goto Database_Updata_2
if defined d_U_ErrorPrint (
	echo=	[����:%0:���:���޴���:%~3]
)
exit/b 1
:Database_Updata_2
if %d_U_Pass1% leq 0 goto Database_Updata2

REM �ӳ���ʼ����
REM �������׶ν����޸ģ����ı����ݿ�Դ�ļ���Ϊ���׶Σ��޸���ǰ������ȡд�룬�޸�����ȡ�޸Ĳ�д�룬�޸��к�������ȡ��д�� �����޸��ı����ݿ�

REM �޸���ǰ������ȡд��׶�
:Database_Updata1

(
	for /f "usebackq eol=^ delims=" %%? in ("%~1") do (
		set /a d_U_Count+=1
		echo=%%?
		if "!d_U_Count!"=="%d_U_Pass1%" goto Database_Updata2
	)
)>>"%d_U_Temp_File%"

REM �޸�����ȡ�޸Ĳ�д��׶�
:Database_Updata2
set d_U_Count=

:Database_Updata2_2
REM ���û�ָ���޸����ݸ�ֵ�����б���
set /a d_U_Count+=1
set d_U_Value%d_U_Count%=%~5
if not "%~6"=="" (
	shift/5
	goto Database_Updata2_2
)

set d_U_Count=

REM ���û�ָ���޸����ݸ�ֵ������������λ�����б���
for /f "tokens=%~4 delims=," %%? in ("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31") do set d_U_Column=%%? %%@ %%A %%B %%C %%D %%E %%F %%G %%H %%I %%J %%K %%L %%M %%N %%O %%P %%Q %%R %%S %%T %%U %%V %%W %%X %%Y %%Z %%[ %%\ %%]
for /f "delims=%%" %%a in ("%d_U_Column%") do set d_U_Column=%%a
for %%a in (%d_U_Column%) do (
	set /a d_U_Count+=1
	call:Database_Updata_Var d_U_FinalValue%%a d_U_Value!d_U_Count!
)

set d_U_Count=

REM ���ı����ݿ��޸��в����޸ĵ����ݸ�ֵ������������λ�����б���(�Ѿ�����ֵ�����б���������)
for /f "usebackq eol=^ tokens=1-31 %d_U_Pass2% delims=%~2" %%? in ("%~1") do (
	for %%_ in ("%%?" "%%@" "%%A" "%%B" "%%C" "%%D" "%%E" "%%F" "%%G" "%%H" "%%I" "%%J" "%%K" "%%L" "%%M" "%%N" "%%O" "%%P" "%%Q" "%%R" "%%S" "%%T" "%%U" "%%V" "%%W" "%%X" "%%Y" "%%Z" "%%[" "%%\" "%%]") do (
		if "%%~_"=="" goto Database_Updata2_3
		set /a d_U_Count+=1
		if not defined d_U_FinalValue!d_U_Count! set d_U_FinalValue!d_U_Count!=%%~_
	)
	goto Database_Updata2_3
)
:Database_Updata2_3
if "%d_U_FinalValue1%"=="" (
	if not defined d_U_ErrorPrint echo=	[����%0:���:���޴���]
	exit/b 1
)
REM ���޸ĺ��޸�����ʽд����ʱ�ı����ݿ��ļ�
for /l %%_ in (1,1,%d_U_Count%) do (
	set d_U_FinalValue=!d_U_FinalValue!%~2!d_U_FinalValue%%_!
)
set d_U_FinalValue=%d_U_FinalValue:~1%
(echo=%d_U_FinalValue%)>>"%d_U_Temp_File%"

REM �޸��к�������ȡ��д��׶�
:Database_Updata3
(
	for /f "usebackq %d_U_Pass3% eol=^ delims=" %%? in ("%~1") do echo=%%?
)>>"%d_U_Temp_File%"

REM ����ʱ�ı����ݿ��ļ�����Դ�ı����ݿ��ļ����޸����
copy "%d_U_Temp_File%" "%~1">nul 2>nul
if not "%errorlevel%"=="0" (
	if defined d_U_ErrorPrint echo=	[����%0:���:�޸ĺ����ݸ���ʧ�ܣ�����Ȩ�޲�����ļ�������]
	exit/b 1
)
if exist "%d_U_Temp_File%" del /f /q "%d_U_Temp_File%"
exit/b 0

REM ���ڱ������������������ӳ���
:Database_Updata_Var
set %~1=!%~2!
exit/b 0

:---------------------Database_Find---------------------:

REM ��ָ���ļ���ָ���С�ָ���ָ�����ָ���С�ָ���ַ�����������������������к�д�뵽ָ��������
REM call:Database_Find [/Q(����ģʽ������ʾ����)] [/i(�����ִ�Сд)] "����Դ" "�����зָ���"  "�����ַ���" "����������(֧�ֵ����ָ���,�����������ָ���-,0Ϊָ��ȫ����)" "����������(֧�ֵ����ָ���,�����������ָ���-)" "���ҽ���к��кŽ�����ܸ�ֵ������"
	REM ע�⣺-------------------------------------------------------------------------------------------------------------------------------
	REM 	��������������ʽΪ��"�� ��","�� ��","..."���εݼӣ�����ڶ��е����к͵����е����еĸ�ֵ���ݾ�Ϊ��"2 3","5 6"
	REM 	����ʹ�� 'for %%a in (%�������%) do for /f "tokens=1,2" %%b in ("%%~a") do echo=��%%b�У���%%c��' �ķ������н��ʹ��
	REM -------------------------------------------------------------------------------------------------------------------------------------
REM ���ӣ����ļ� "c:\users\a\Database.ini"�е�����������"	"Ϊ�ָ����ĵ�һ���в����ִ�Сд�Ĳ����ַ���data(��ȫƥ��)����������������кŸ�ֵ������result
REM					call:Database_Find /i "c:\users\a\Database.ini" "	" "data" "3-5" "1" "result"
REM ����ֵ���飺0-����ָ���ַ����ҵ�������Ѹ�ֵ������1-δ���ҵ������2-�����������ӳ���
REM ע�⣺����ֵ���ֻ֧�ֵ�31�У��Ƽ��ڴ������ݵ�ʱ��ʹ���Ʊ��"	"Ϊ�ָ������Է��������ݺͷָ�������,�ı����ݿ��в�Ҫ���п��кͿ�ֵ����ֹ�������ݴ���
REM �汾:20151202
:Database_Find
REM ����ӳ������л����������
for %%A in (d_F_ErrorPrint d_F_Insensitive) do set %%A=
if /i "%~1"=="/i" (
	set d_F_Insensitive=/i
	shift/1
) else if /i "%~1"=="/q" (shift/1) else set d_F_ErrorPrint=Yes
if /i "%~1"=="/i" (
	set d_F_Insensitive=/i
	shift/1
) else if /i "%~1"=="/q" (shift/1) else set d_F_ErrorPrint=Yes

if "%~6"=="" (
	if defined d_F_ErrorPrint echo=	[����%0:����6-ָ�����ܽ��������Ϊ��]
	exit/b 2
)
if "%~5"=="" (
	if defined d_F_ErrorPrint echo=	[����%0:����5-ָ�������к�Ϊ��]
	exit/b 2
)
if "%~4"=="" (
	if defined d_F_ErrorPrint echo=	[����%0:����4-ָ�������к�Ϊ��]
	exit/b 2
)
if "%~3"=="" (
	if defined d_F_ErrorPrint echo=	[����%0:����3-ָ�������ַ���Ϊ��]
	exit/b 2
)
if "%~2"=="" (
	if defined d_F_ErrorPrint echo=	[����%0:����2-ָ�������зָ���Ϊ��]
	exit/b 2
)
if "%~1"=="" (
	if defined d_F_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�Ϊ��]
	exit/b 2
) else if not exist "%~1" (
	if defined d_F_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�������:%~1]
	exit/b 2
)

REM ��ʼ������
for %%_ in (d_F_Count d_F_StringTest d_F_Count2 d_F_Pass %~6) do set %%_=
for /f "delims==" %%_ in ('set d_F_AlreadyLineNumber 2^>nul') do set %%_=
for /f "delims==" %%_ in ('set d_F_Column 2^>nul') do set %%_=

REM �ӳ���ʼ����
REM �ж��û������к��Ƿ���Ϲ���
set d_F_StringTest=%~4
for %%_ in (1,2,3,4,5,6,7,8,9,0,",",-) do if defined d_F_StringTest set d_F_StringTest=!d_F_StringTest:%%~_=!
if defined d_F_StringTest (
	if defined d_F_ErrorPrint echo=	[����%0:����4:ָ�������кŲ����Ϲ���:%~4]
	exit/b 2
)

REM ���кŸ�ֵ���б���
for /f "tokens=%~5" %%? in ("1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31") do for /f "delims=%%" %%_ in ("%%? %%@ %%A %%B %%C %%D %%E %%F %%G %%H %%I %%J %%K %%L %%M %%N %%O %%P %%Q %%R %%S %%T %%U %%V %%W %%X %%Y %%Z %%[ %%\ %%]") do for %%: in (%%_) do (
	set /a d_F_Count+=1
	set d_F_Column!d_F_Count!=%%:
)

set d_F_Count=
REM �����кŽ��в��ִ������
for %%_ in (%~4) do (
	set d_F_Pass=
	set d_F_Pass=%%~_
	if "!d_F_Pass!"=="!d_F_Pass:-=!" (
		if "%%~_"=="0" (
			set d_F_Count2=0
			set d_F_Count=No
			set d_F_Pass=
		) else (
			set /a d_F_Count2=%%~_-1
			set /a d_F_Pass=%%~_-1
			set d_F_Count=0
			if "!d_F_Pass!"=="0" (set d_F_Pass=) else set d_F_Pass=skip=!d_F_Pass!
		)
		call:Database_Find_Run "%~1" "%~2" "%~5" "%~3" "%~6"
	) else (
		for /f "tokens=1,2 delims=-" %%: in ("%%~_") do (
			if "%%~:"=="%%~;" (
				set /a d_F_Count2=%%~:-1
				set /a d_F_Pass=%%~:-1
				set d_F_Count=0
			) else call:Database_Find2 "%%~:" "%%~;"
			if "!d_F_Pass!"=="0" (set d_F_Pass=) else set d_F_Pass=skip=!d_F_Pass!
			call:Database_Find_Run "%~1" "%~2" "%~5" "%~3" "%~6"
		)
	)
)

if defined %~6 (set %~6=!%~6:~1!) else (
	if defined d_F_ErrorPrint echo=	[���%0:���ݹؼ���"%~3"δ�ܴ�ָ���ļ��������ҵ����]
	exit/b 1
)
exit/b 0

REM call:Database_Find_Run "�ļ�" "�ָ���" "��" "�����ַ���" "������"
:Database_Find_Run
set d_F_Count3=
for /f "usebackq %d_F_Pass% eol=^ tokens=%~3 delims=%~2" %%? in ("%~1") do (
	set /a d_F_Count3+=1
	set /a d_F_Count2+=1

	if not defined d_F_AlreadyLineNumber!d_F_Count2! (
		set d_F_AlreadyLineNumber!d_F_Count2!=Yes
		if "%%?"=="%%~?" (
			if %d_F_Insensitive% "%%?"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column1!"
		)
		if "%%@"=="%%~@" (
			if %d_F_Insensitive% "%%@"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column2!"
		)
		if "%%A"=="%%~A" (
			if %d_F_Insensitive% "%%A"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column3!"
		)
		if "%%B"=="%%~B" (
			if %d_F_Insensitive% "%%B"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column4!"
		)
		if "%%C"=="%%~C" (
			if %d_F_Insensitive% "%%C"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column5!"
		)
		if "%%D"=="%%~D" (
			if %d_F_Insensitive% "%%D"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column6!"
		)
		if "%%E"=="%%~E" (
			if %d_F_Insensitive% "%%E"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column7!"
		)
		if "%%F"=="%%~F" (
			if %d_F_Insensitive% "%%F"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column8!"
		)
		if "%%G"=="%%~G" (
			if %d_F_Insensitive% "%%G"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column9!"
		)
		if "%%H"=="%%~H" (
			if %d_F_Insensitive% "%%H"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column10!"
		)
		if "%%I"=="%%~I" (
			if %d_F_Insensitive% "%%I"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column11!"
		)
		if "%%J"=="%%~J" (
			if %d_F_Insensitive% "%%J"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column12!"
		)
		if "%%K"=="%%~K" (
			if %d_F_Insensitive% "%%K"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column13!"
		)
		if "%%L"=="%%~L" (
			if %d_F_Insensitive% "%%L"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column14!"
		)
		if "%%M"=="%%~M" (
			if %d_F_Insensitive% "%%M"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column15!"
		)
		if "%%N"=="%%~N" (
			if %d_F_Insensitive% "%%N"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column16!"
		)
		if "%%O"=="%%~O" (
			if %d_F_Insensitive% "%%O"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column17!"
		)
		if "%%P"=="%%~P" (
			if %d_F_Insensitive% "%%P"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column18!"
		)
		if "%%Q"=="%%~Q" (
			if %d_F_Insensitive% "%%Q"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column19!"
		)
		if "%%R"=="%%~R" (
			if %d_F_Insensitive% "%%R"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column20!"
		)
		if "%%S"=="%%~S" (
			if %d_F_Insensitive% "%%S"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column21!"
		)
		if "%%T"=="%%~T" (
			if %d_F_Insensitive% "%%T"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column22!"
		)
		if "%%U"=="%%~U" (
			if %d_F_Insensitive% "%%U"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column23!"
		)
		if "%%V"=="%%~V" (
			if %d_F_Insensitive% "%%V"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column24!"
		)
		if "%%W"=="%%~W" (
			if %d_F_Insensitive% "%%W"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column25!"
		)
		if "%%X"=="%%~X" (
			if %d_F_Insensitive% "%%X"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column26!"
		)
		if "%%Y"=="%%~Y" (
			if %d_F_Insensitive% "%%Y"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column27!"
		)
		if "%%Z"=="%%~Z" (
			if %d_F_Insensitive% "%%Z"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column28!"
		)
		if "%%["=="%%~[" (
			if %d_F_Insensitive% "%%["=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column29!"
		)
		if "%%\"=="%%~\" (
			if %d_F_Insensitive% "%%\"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column30!"
		)
		if "%%]"=="%%~]" (
			if %d_F_Insensitive% "%%]"=="%~4" set %~5=!%~5!,"!d_F_Count2! !d_F_Column31!"
		)
	)
	if /i not "%d_F_Count%"=="No" (
		if "%d_F_Count%"=="0" exit/b
		if "!d_F_Count3!"=="%d_F_Count%" exit/b
	)
)
exit/b

REM ��������Ƕ�����ԭ���µ����ⲻ�ò�д��һ���ӳ�������ж�
REM call:Database_Find2 ��һ��ֵ �ڶ���ֵ
:Database_Find2
if %~10 gtr %~20 (
	set /a d_F_Count2=%~2-1
	set /a d_F_Pass=%~2-1
	set /a d_F_Count=%~1-%~2+1
) else (
	set /a d_F_Count2=%~1-1
	set /a d_F_Pass=%~1-1
	set /a d_F_Count=%~2-%~1+1
)
exit/b

:---------------------Database_DeleteLine---------------------:

REM ɾ��ָ���ļ�ָ����
REM call:Database_DeleteLine [/Q(����ģʽ������ʾ����)] "����Դ" "��ɾ��������ʼ��" "����ʼ�п�ʼ��������ɾ��������(�������У����µ���β������0)"
REM ���ӣ����ļ� "c:\users\a\Database.ini" �еڶ�������ɾ��
REM					call:Database_DeleteLine "c:\users\a\Database.ini" "2" "2"
REM ����ֵ���飺0-����������1-���޴��У�2-�����������ӳ���
REM �汾:20151130
:Database_DeleteLine
REM ����ӳ������л����������
for %%A in (d_DL_ErrorPrint) do set %%A=
if /i "%~1"=="/q" (
	shift/1
) else set d_DL_ErrorPrint=Yes
if "%~3"=="" (
	if defined d_DL_ErrorPrint echo=	[����%0:����3-ָ��ƫ����Ϊ��]
	exit/b 2
)
if %~3 lss 0 (
	if defined d_DL_ErrorPrint echo=	[����%0:����3-ָ��ƫ����С��0:%~4]
)
if "%~2"=="" (
	if defined d_DL_ErrorPrint echo=	[����%0:����2-ָ����ʼ�к�Ϊ��]
	exit/b 2
)
if %~2 lss 1 (
	if defined d_DL_ErrorPrint echo=	[����%0:����2-ָ����ʼ�к�С��1:%~3]
	exit/b 2
)
if "%~1"=="" (
	if defined d_DL_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�Ϊ��]
	exit/b 2
) else if not exist "%~1" (
	if defined d_DL_ErrorPrint echo=	[����%0:����1-ָ������Դ�ļ�������:%~1]
	exit/b 2
)

REM ��ʼ������
for %%_ in (d_DL_Count d_DL_Pass1 d_DL_Pass2 d_DL_Pass3 d_DL_Temp_File) do set %%_=
set d_DL_Temp_File=%~1_Temp
if exist "%d_DL_Temp_File%" del /f /q "%d_DL_Temp_File%"
set /a d_DL_Pass3=%~2-1
set /a d_DL_Pass2=%~2+%~3-1
set /a d_DL_Pass1=%~2-1

if "%d_DL_Pass3%"=="0" (set d_DL_Pass3=) else set d_DL_Pass3=skip=%d_DL_Pass3%
if "%d_DL_Pass2%"=="0" (set d_DL_Pass2=) else set d_DL_Pass2=skip=%d_DL_Pass2%

REM �ж��Ƿ���ָ��ɾ����
for /f "usebackq eol=^ %d_DL_Pass3% delims=" %%? in ("%~1") do goto Database_Updata_2
if defined d_DL_ErrorPrint (
	echo=	[����:%0:���:���޴���:%~3]
)
exit/b 1
:Database_Updata_2
if %d_DL_Pass1% leq 0 goto Database_Updata2
REM �ӳ���ʼ����
REM ��ɾ����ǰ����д�뵽��ʱ�ı����ݿ��ļ�
:Database_Updata1
(
	for /f "usebackq eol=^ delims=" %%? in ("%~1") do (
		set /a d_DL_Count+=1
		echo=%%?
		if "!d_DL_Count!"=="%d_DL_Pass1%" goto Database_Updata2
	)
)>>"%d_DL_Temp_File%"

REM ��ɾ���к�����д�뵽��ʱ�ı����ݿ��ļ�
:Database_Updata2
if "%~3"=="0" (
	if "%~2"=="1" (if "a"=="b" echo=�˴����ɿ��ļ�)>>"%d_DL_Temp_File%"
) else (
	for /f "usebackq %d_DL_Pass2% eol=^ delims=" %%? in ("%~1") do echo=%%?
)>>"%d_DL_Temp_File%"

REM ����ʱ�ı����ݿ��ļ�����Դ�ı����ݿ��ļ�
copy "%d_DL_Temp_File%" "%~1">nul 2>nul
if not "%errorlevel%"=="0" (
	if defined d_DL_ErrorPrint echo=	[����%0:���:ɾ�������ݸ���ʧ�ܣ�����Ȩ�޲�����ļ�������]
	exit/b 1
)
if exist "%d_DL_Temp_File%" del /f /q "%d_DL_Temp_File%"
exit/b 0

:�ӳ����������:
:end