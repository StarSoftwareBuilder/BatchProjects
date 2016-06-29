@echo off
setlocal ENABLEDELAYEDEXPANSION
color 0a
REM �趨�汾��������Ϣ
set project=BFS_FileSearch
set version=20160629
set updateUrl=http://imfms.vicp.net

title BFS���� ^| %version% ^| F_Ms ^| Blog: f-ms.cn

REM �趨����������
set litter=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

:choosedrive
cls
for %%a in (existdrive userfilename userinput) do if defined %%a set %%a=
if not "%~1"=="" (
	call:existfolder %*
	if defined existfolder (
		set userinput=!existfolder!
		echo=#����Ŀ¼:!userinput!
		goto searchfilename
	) else (
		echo=#����:����1:"%~1":�ļ�������
		pause
		exit /b
	)
)
for %%a in (%litter%) do if exist %%a:\ (
	set existdrive=!existdrive! %%a
	for /f "tokens=4,*" %%A in ('vol %%a:') do if "%%~B"=="" (set label%%a=%%A) else set label%%a=%%A %%B
	if not defined label%%a set label%%a=[�޾��]
)
echo=-BFS�ļ�����-
echo=#����	#���
for %%a in (%existdrive::=%) do echo=  %%a	!label%%a!
if defined tips (
	call:searchresulthelp 2
	set tips=
)
set /p userinput=#������Ŀ¼��
if not defined userinput (
	set tips=Yes
	goto choosedrive
)
if defined ##userinput set ##userinput=
set ##userinput=%userinput:"=%
if "%##userinput%"=="" (
	set tips=Yes
	goto choosedrive
)
if "%##userinput:~0,1%"=="?" (
	set tips=Yes
	goto choosedrive
)
if /i "%##userinput:~0,1%"=="@" (
	call:UpdateProjectVersion %project% %version% %updateUrl% "%~0"
	if not "!errorlevel!"=="0" (
		ping -n 3 127.1>nul 2>nul
		goto choosedrive
	)
)
if "%##userinput:~0,1%"=="$" (
	reg query hkcr\folder\shell\BFS����\command /ve>nul 2>nul
	if "!errorlevel!"=="0" (
		reg delete hkcr\folder\shell\BFS���� /f>nul 2>nul
		if "!errorlevel!"=="0" (echo=	#�Ҽ������˵�ж�سɹ�) else echo=	#�Ҽ������˵�ж��ʧ�ܣ��볢���Թ���Ա��ʽ����BFS����
		ping -n 3 127.1>nul 2>nul
	) else (
		reg add hkcr\folder\shell\BFS����\command /ve /t REG_EXPAND_SZ /d "\"%~dp0\%~nx0\" \"%%1\"" /f>nul 2>nul
		if "!errorlevel!"=="0" (echo=	#�Ҽ������˵���װ�ɹ�) else echo=	#�Ҽ������˵���װʧ�ܣ��볢���Թ���Ա��ʽ����BFS����
		ping -n 3 127.1>nul 2>nul
	)
	goto choosedrive
)
if "%##userinput:~0,1%"=="," (
	echo=#���������з���
	set userinput=%existdrive%
	goto searchfilename
)
if "%##userinput:~0,1%"=="��" (
	echo=#���������з���
	set userinput=%existdrive%
	goto searchfilename
)
if "%##userinput:~0,1%"=="*" (
	echo=#���������з���
	set userinput=%existdrive%
	goto searchfilename
)
if "%##userinput:~0,2%"=="." goto end
if "%##userinput:~0,2%"=="��" goto end
call:existfolder %userinput%
if "%errorlevel%"=="2" goto choosedrive
if defined existfolder (
	if defined #existfolder (
	echo=#Ŀ¼%#existfolder%�����ڣ���ֻ����Ŀ¼%existfolder%) else echo=#������Ŀ¼: %existfolder%
	set userinput=%existfolder%
	goto searchfilename
)
set userinput=%userinput::=%
set userinput=%userinput:\=%
set userinput=%userinput: =%
set userinput=%userinput:"=%
call:DefinedNoAbString "%userinput%"
if "%errorlevel%"=="0" (
	set tips=Yes
	goto choosedrive
)
call:convert userinput
call:wipe2 userinput
call:existcheck userinput
if not defined userinput goto choosedrive
if "%userinput: =%"=="" goto choosedrive
if defined userinput if defined #userinput (echo=#δ���ַ��� %#userinput% ����ֻ�������� %userinput%) else echo=#����������: %userinput%
:searchfilename
for %%A in (userfilename #userfilename) do if defined %%A set %%A=
if defined tips (
	call:searchresulthelp 3
	set tips=
)
set /p userfilename=#�����ؼ���:
if not defined userfilename (
	set tips=Yes
	goto searchfilename
)
:searchfilename2
set #userfilename=%userfilename:"=%
if "%#userfilename:~0,1%"==":" goto choosedrive
if "%#userfilename:~0,1%"=="/" (
	if /i "%#userfilename:~1,5%"=="image" (
		set userfilename=*.jpg *.jpeg *.bmp *.png *.gif *.raw *.pcx *.psd *.tiff *.svg
		goto searchfilename3
	)
	if /i "%#userfilename:~1,5%"=="video" (
		set userfilename=*.avi *.rmvb *.mkv *.mp4 *.3gp *.rm *.flv *.f4v *.mov *.ts *.vob *.wmv *.wmp
		goto searchfilename3
	)
	if /i "%#userfilename:~1,5%"=="audio" (
		set userfilename=*.mp3 *.flac *.ogg *.m4a *.ape *.wav *.mid *.cue
		goto searchfilename3
	)
	if /i "%#userfilename:~1,3%"=="txt" (
		set userfilename=*.doc *.txt *.xls *.ppt *.chm *.docx *.xlsx *.pptx *.et *.wps *.dps *.pdf *.rtf
		goto searchfilename3
	)
	if /i "%#userfilename:~1,8%"=="compress" (
		set userfilename=*.rar *.7z *.iso *.gho *.zip *.cab *.tar *.wim *.gzip *.gz
		goto searchfilename3
	)
	goto searchfilename
)
:searchfilename3
set searchfiledijia=
cls
echo=#���������ؼ��� "%userfilename:"=%" ...
echo=
for %%a in (%userinput%) do (
	set userinputtemp=%%~a
	if "!userinputtemp:~1!"=="" (call:searchfile "%%~a:\" !userfilename!) else call:searchfile "%%~a" !userfilename!
	set userinputtemp=
)
if not defined searchfiledijia set searchfiledijia=0
echo=
echo=#�������,�����ؼ��� "%userfilename:"=%" ��������%searchfiledijia%�����
if not defined searchfiledijia (goto searchfilename) else if "!searchfiledijia!"=="0" goto searchfilename
echo=
:searchfilenameopen
for %%a in (explorer findstr userinput2 #userinput2 userinputtemp2) do set %%a=
set /p userinput2=#����������:
if defined userinput2 set #userinput2=%userinput2:"=%
if "%#userinput2%"=="" (
	call:searchresulthelp 1
	goto searchfilenameopen
) else (
	if "%#userinput2%"=="." (
		goto end
	) else (
		if "!userinput2!"==" " (
			call:searchresulthelp 1
			goto searchfilenameopen
		)
		if "!userinput2:~0,1!"=="0" goto choosedrive
		if "!userinput2:~0,1!"==":" goto choosedrive
		if "!userinput2:~0,1!"=="'" if "!#userinput2:~1!"=="" (goto searchfilename) else (
			set "userfilename=!userinput2:~1!"
			goto searchfilename2
		)
		if "!userinput2:~0,1!"==";" (
			call:echoresultlist
			goto searchfilenameopen
		)
		if "!userinput2:~-1!"==" " (
			set explorer=Yes
			set "userinput2=!userinput2:~,-1!"
		)
		if /i "!userinput2:~0,2!"=="/o" (
			call:callcommandgroup open
			if "!errorlevel!"=="4" goto end
			if "!errorlevel!"=="3" goto choosedrive
			goto searchfilenameopen
		)
		if /i "!userinput2:~0,2!"=="/w" (
			call:callcommandgroup openwait
			if "!errorlevel!"=="4" goto end
			if "!errorlevel!"=="3" goto choosedrive
			goto searchfilenameopen
		)
		if /i "!userinput2:~0,2!"=="/d" (
			call:callcommandgroup delete
			if "!errorlevel!"=="4" goto end
			goto searchfilenameopen
		)
		if /i "!userinput2:~0,2!"=="/s" (
			call:callcommandgroup save
			if "!errorlevel!"=="4" goto end
			if "!errorlevel!"=="3" goto choosedrive
			goto searchfilenameopen
		)
		if /i "!userinput2:~0,2!"=="/c" (
			call:callcommandgroup copy
			if "!errorlevel!"=="4" goto end
			if "!errorlevel!"=="3" goto choosedrive
			goto searchfilenameopen
		)
		if /i "!userinput2:~0,2!"=="/r" (
			call:callcommandgroup ren
			if "!errorlevel!"=="4" goto end
			if "!errorlevel!"=="3" goto choosedrive
			goto searchfilenameopen
		)
		if /i "!userinput2:~0,2!"=="/a" (
			call:callcommandgroup add
			if "!errorlevel!"=="4" goto end
			if "!errorlevel!"=="3" goto choosedrive
			goto searchfilenameopen
		)
		if /i "!userinput2:~0,2!"=="/m" (
			call:callcommandgroup move
			if "!errorlevel!"=="4" goto end
			if "!errorlevel!"=="3" goto choosedrive
			goto searchfilenameopen
		)
		if "!userinput2:~0,2!"=="/-" (
			set findstr= /v
			set "userinput2=//!userinput2:~2!"
		)
		if "!userinput2:~0,2!"=="//" (
			if not "!userinput2:~2!"=="" (
				if not exist "%temp%\FileSearchTMP\" md "%temp%\FileSearchTMP\"
				if defined tempname set tempname=
				set tempname=%temp%\FileSearchTMP\!random!!random!!random!.tmp
				call:createresultfile "!tempname!"
				set searchfile2xulie=0
				cls
				echo=#���������ؼ��� "!userinput2:~2!" ...
				echo=
				for /f "delims=" %%a in ('findstr !findstr! /i /c:"!userinput2:~2!" "!tempname!"') do (
					set /a searchfile2xulie+=1
					echo=[!searchfile2xulie!]"%%~a"[!searchfile2xulie!]
					set searchfiledijia!searchfile2xulie!=%%a
				)
				set /a searchfile2xulie+=1
				if defined searchfiledijia!searchfile2xulie! set searchfiledijia!searchfile2xulie!=
				set /a searchfile2xulie-=1
				echo=
				echo=#�������,�ؼ��� "!userinput2:~2!" ��������!searchfile2xulie!�����
				if not defined searchfile2xulie (
					goto searchfilename
				) else (
					if "!searchfile2xulie!"=="0" goto searchfilename
				)
			)
		) else (
			call:DefinedNoNumberString "!userinput2!"
			if "!errorlevel!"=="0" (
				call:searchresulthelp 1
				goto searchfilenameopen
			) else (
				if !userinput2!0 gtr !searchfiledijia!0 (
					echo=	#����������Ч���޴���Ŀ�����������
					goto searchfilenameopen
				)
				if defined searchfiledijia%userinput2% (
					if defined explorer (
						if exist "!searchfiledijia%userinput2: =%!" (start "" explorer /select,"!searchfiledijia%userinput2: =%!") else echo=	#ָ�������ļ�"!searchfiledijia%userinput2: =%!"�Ѳ�����,����������
					) else start "" "!searchfiledijia%userinput2%!"
				)
				if not defined searchfiledijia%userinput2% echo=	#����������Ч���޴���Ŀ�����������
			)
		)
	)
)
goto searchfilenameopen


goto end
:-------------------------------------�ӳ���-------------------------------------

REM �ļ�����
:searchfile
for %%D in (searchfiletemp searchfiletemp2) do if defined %%D set %%D=
set userfilename2=%~2
set userfilename2=%userfilename2:"=%
if "%~1"=="" goto :eof
if "%userfilename2%"=="" goto :eof
if "!userfilename2:~0,1!"=="\" (set userfilename2=!userfilename2:~1!) else if "%userfilename2:**=%"=="%userfilename2%" if "%userfilename2:?=%"=="%userfilename2%" set searchfiletemp=*
for /r "%~1" %%b in ("%searchfiletemp%%userfilename2%%searchfiletemp%") do (
	if exist "%%~b" (
		set /a searchfiledijia+=1
		echo=[!searchfiledijia!]"%%~b"[!searchfiledijia!]
		set "searchfiledijia!searchfiledijia!=%%~b"
	)
)
set /a searchfiledijia+=1
if defined searchfiledijia!searchfiledijia! set searchfiledijia!searchfiledijia!=
set /a searchfiledijia-=1
if not "%~3"=="" (
	shift /2
	goto searchfile
)
goto :eof

REM �ֱ�򿪡����ơ����桢ɾ�����ӳ���
:callcommandgroup
if defined userinputtemp2 set userinputtemp2=

if "!#userinput2:~2!"=="" (
	echo=	#δ���ֲ�������,���������
) else (
	set callcommandgroupdijia=1
	for /l %%a in (1,1,4) do set callcommandgroupdijia%%a=
	for /f "tokens=1,*" %%a in ("!userinput2:~2!") do (
		set callcommandgroupdijia1=%%a
		for %%c in (%%b) do (
			set/a callcommandgroupdijia+=1
			set callcommandgroupdijia!callcommandgroupdijia!=%%c
		)
	)
	set userinput2=/c"!callcommandgroupdijia1!"	!callcommandgroupdijia2!	!callcommandgroupdijia3!	!callcommandgroupdijia4!
	
	for /f "tokens=1,2,3,4 delims=	" %%a in ("!userinput2:~2!") do (
		if "!#userinput2:~2,1!"=="*" (
			call:checkfolderfile %1 "%%~b" "%%~c" "%%~d"
			if "!errorlevel!"=="1" goto :eof
			call:chooseresultrun %1 "1-!searchfiledijia!" "%%~b" "%%~c" "%%~d"
			goto :eof
		)
		if "!#userinput2:~2,1!"=="," (
			call:checkfolderfile %1 "%%~b" "%%~c" "%%~d"
			if "!errorlevel!"=="1" goto :eof
			call:chooseresultrun %1 "1-!searchfiledijia!" "%%~b" "%%~c" "%%~d"
			goto :eof
		)
		call:checkfolderfile %1 "%%~b" "%%~c" "%%~d"
		if "!errorlevel!"=="1" goto :eof
		call:clearcontent "%%~a"
		if defined clearcontentresult (
			echo=	#!clearcontentresult!
			goto :eof
		) else (
			call:chooseresultrun %1 "!clearcontentresult2!" "%%~b" "%%~c" "%%~d"
			goto :eof
		)
	)
)
goto :eof

REM �ӽ���������ȡ��ִ���������
:chooseresultrun
if "%~1"=="" goto :eof
if "%~2"=="" goto :eof
for %%a in (!#chooseresultrun!) do set chooseresultrun%%a=
if defined chooseresultrun set chooseresultrun=
for %%a in (%~2) do (
	set chooseresultrun=%%a
	if "!chooseresultrun!"=="!chooseresultrun:-=!" (
		if !chooseresultrun!0 gtr %searchfiledijia%0 (echo=	#����%%aδ������ֵ��������) else if defined chooseresultrun%%a (
			echo=	#����%%a�����ظ���������
		) else (
			if defined searchfiledijia%%a (
				if exist "!searchfiledijia%%a!" (
					if /i "%~1"=="open" call:chooseresultrun2 open "!searchfiledijia%%a!"
					if /i "%~1"=="openwait" call:chooseresultrun2 openwait "!searchfiledijia%%a!"
					if /i "%~1"=="delete" call:chooseresultrun2 delete "!searchfiledijia%%a!"
					if /i "%~1"=="save" call:chooseresultrun2 save "!searchfiledijia%%a!" "%~3"
					if /i "%~1"=="copy" call:chooseresultrun2 copy "!searchfiledijia%%a!" "%~3"
					if /i "%~1"=="move" call:chooseresultrun2 move "!searchfiledijia%%a!" "%~3"
					if /i "%~1"=="ren" call:chooseresultrun2 ren "%%a" "!searchfiledijia%%a!" "%~3" "%~4"
					if /i "%~1"=="add" call:chooseresultrun2 add "%%a" "!searchfiledijia%%a!" "%~3" "%~4"
					set chooseresultrun%%a=Yes
					set #chooseresultrun=!#chooseresultrun! %%a
				) else echo=	#�ļ�"!searchfiledijia%%a!"�Ѳ�����,������
			) else (
				echo=	#����%%aδ������ֵ��������
			)
		)
	) else (
		for /f "tokens=1,2 delims=-" %%i in ("%%a") do (
			for /l %%A in (%%i,1,%%j) do (
				if %%A0 gtr %searchfiledijia%0 (echo=	#����������[%%a]������%%Aδ������ֵ��������) else if defined chooseresultrun%%A (
					echo=	#����������[%%a]������%%A�����ظ���������
				) else (
					if defined searchfiledijia%%A (
						if exist "!searchfiledijia%%A!" (
							if /i "%~1"=="open" call:chooseresultrun2 open "!searchfiledijia%%A!"
							if /i "%~1"=="openwait" call:chooseresultrun2 openwait "!searchfiledijia%%A!"
							if /i "%~1"=="delete" call:chooseresultrun2 delete "!searchfiledijia%%A!"
							if /i "%~1"=="save" call:chooseresultrun2 save "!searchfiledijia%%A!" "%~3"
							if /i "%~1"=="copy" call:chooseresultrun2 copy "!searchfiledijia%%A!" "%~3"
							if /i "%~1"=="move" call:chooseresultrun2 move "!searchfiledijia%%A!" "%~3"
							if /i "%~1"=="ren" call:chooseresultrun2 ren "%%A" "!searchfiledijia%%A!" "%~3" "%~4"
							if /i "%~1"=="add" call:chooseresultrun2 add "%%A" "!searchfiledijia%%A!" "%~3" "%~4"
							set chooseresultrun%%A=Yes
							set #chooseresultrun=!#chooseresultrun! %%A
						) else echo=	#�ļ�"!searchfiledijia%%A!"�Ѳ�����,������
					)
				)
			)
		)
	)
)
goto :eof
:chooseresultrun2
if defined filenametemp set filenametemp=
REM ��
if /i "%~1"=="open" (
	start "" "%~2"
	echo=	#�Ѵ��ļ�"%~2"
	goto :eof
)
REM �ȴ���
if /i "%~1"=="openwait" (
	echo=	#�Ѵ��ļ�"%~2"
	start /wait "" "%~2"
	goto :eof
)
REM ����
if /i "%~1"=="save" call:chooseresultrun2save "%~2" "%~3"&goto :eof
REM ����
if /i "%~1"=="copy" (
	if /i "%~dp2"=="%~3\" (
		echo=	#�ļ�"%~nx2"�����ļ�����Ŀ���ļ�����ͬ��������
		goto :eof
	)
	if /i "%~dp2"=="%~3" (
		echo=	#�ļ�"%~nx2"�����ļ�����Ŀ���ļ�����ͬ��������
		goto :eof
	)
	if exist "%~3\%~nx2" (
		call:chooseresultrun2random "%~3\%~nx2"
		call:chooseresultrun2copy "%~2" "!filenametemp!"
	) else (
		call:chooseresultrun2copy "%~2" "%~3"
	)
	if defined filenametemp (
		if exist "!filenametemp!" (echo=	#����Ŀ���ļ�������"%~nx2",�ļ�"%~2"�ѳɹ����Ƶ�"!filenametemp!") else 	#�ļ�"%~2"����ʧ�ܣ�Ȩ�޲�����ļ���ռ��
	) else (
		if exist "%~3\%~nx2" (echo=	#�ļ�"%~2"�ѳɹ����Ƶ�"%~3\%~nx2") else 	#�ļ�"%~2"����ʧ�ܣ�Ȩ�޲�����ļ���ռ��
	)
	goto :eof
)
REM �ƶ�
if /i "%~1"=="move" (
	if /i "%~dp2"=="%~3\" (
		echo=	#�ļ�"%~nx2"�����ļ�����Ŀ���ļ�����ͬ��������
		goto :eof
	)
	if /i "%~dp2"=="%~3" (
		echo=	#�ļ�"%~nx2"�����ļ�����Ŀ���ļ�����ͬ��������
		goto :eof
	)
	if exist "%~3\%~nx2" (
		call:chooseresultrun2random "%~3\%~nx2"
		call:chooseresultrun2move "%~2" "!filenametemp!"
	) else (
		call:chooseresultrun2move "%~2" "%~3"
	)
	if defined filenametemp (
		if exist "!filenametemp!" (echo=	#����Ŀ���ļ�������"%~nx2",�ļ�"%~2"�ѳɹ��ƶ���"!filenametemp!") else 	#�ļ�"%~2"�ƶ�ʧ�ܣ�Ȩ�޲�����ļ���ռ��
	) else (
		if exist "%~3\%~nx2" (echo=	#�ļ�"%~2"�ѳɹ��ƶ���"%~3\%~nx2") else 	#�ļ�"%~2"�ƶ�ʧ�ܣ�Ȩ�޲�����ļ���ռ��
	)
	goto :eof
)
REM ɾ��
if /i "%~1"=="delete" (
	del /f /q "%~2"
	if exist "%~2" (
		echo=	#ɾ��"%~2"ʧ��,Ȩ�޲�����ļ���ռ��
	) else (
		echo=	#�ļ�"%~2"ɾ�����
	)
	goto :eof
)
REM �����滻
if /i "%~1"=="ren" (
	set "strrpcNameTemp=%~nx3"
	set "strrpcNameTemp=!strrpcNameTemp:%~4=%~5!"
	if exist "%~dp3\!strrpcNameTemp!" (echo=	#�ļ�"!strrpcNameTemp!"�Ѵ���,�����������滻) else (
		ren "%~3" "!strrpcNameTemp!"
		set "searchfiledijia%~2=%~dp3!strrpcNameTemp!"
		echo=	#�ļ�"%~3"��������Ϊ"!strrpcNameTemp!"
	)
)

REM �������
if /i "%~1"=="add" (
	set "strrpcNameTemp=%~4%~n3%~5%~x3"
	if exist "%~dp3\!strrpcNameTemp!" (echo=	#�ļ�"!strrpcNameTemp!"�Ѵ���,�������������) else (
		ren "%~3" "!strrpcNameTemp!"
		set "searchfiledijia%~2=%~dp3!strrpcNameTemp!"
		echo=	#�ļ�"%~3"��������Ϊ"!strrpcNameTemp!"
	)
)
goto :eof


REM �����������ȡ����
:clearcontent
if "%~1"=="" goto :eof
for %%a in (clearcontent clearcontentresult clearcontentresult2 clearcontentresult3) do if defined %%a set %%a=
set clearcontent=%~1
set clearcontent=%clearcontent:-=%
call:DefinedNoNumberString "!clearcontent:,=!"
if "!errorlevel!"=="0" (
	set clearcontentresult=����Υ�����Ч�ַ������������
	goto :eof
)
for %%a in (%~1) do (
	set clearcontent=%%a
	if "!clearcontent!"=="!clearcontent:-=!" (
		set clearcontentresult2=!clearcontentresult2!,%%a
	) else (
		for /f "tokens=1,2,* delims=-" %%A in ("%%a") do (
			if "%%~A"=="" (
				set clearcontentresult=�����"-"������ֵΪ�գ����������
				goto :eof
			)
			if "%%~B"=="" (
				set clearcontentresult=�����"-"������ֵΪ�գ����������
				goto :eof
			)
			if not "%%~C"=="" (
				set clearcontentresult="%%~A-%%~B-%%~C"����һ�������ڶ�������"-"�����������
				goto :eof
			)
			if "%%~A"=="%%~B" (
				set clearcontentresult2=!clearcontentresult2!,%%~A
				set clearcontentresult3=Yes
			)
			if "%%~A"=="0" (
				set clearcontentresult2=!clearcontentresult2!,1-%%~B
				set clearcontentresult3=Yes
			)
			if %%~A gtr %%~B (
				if "%%~B"=="0" (
					set clearcontentresult2=!clearcontentresult2!,1-%%~A
				) else (
					set clearcontentresult2=!clearcontentresult2!,%%~B-%%~A
				)
				set clearcontentresult3=Yes
			)
			if not defined clearcontentresult3 set clearcontentresult2=!clearcontentresult2!,%%~A-%%~B
		)
	)
)
goto :eof
REM ����
:chooseresultrun2save
echo="%~1">>"%~2"
echo=	#"%~1"��Ŀ��д��"%~2"
goto :eof
REM ����
:chooseresultrun2copy
copy "%~1" "%~2">nul 2>nul
goto :eof
REM �ƶ�
:chooseresultrun2move
move "%~1" "%~2">nul 2>nul
goto :eof
REM ����ļ���
:chooseresultrun2random
set filenametemp=%~dpn1�ظ��ļ�����!random!!random!%~x1
goto :eof


REM Ŀ¼�ж��Ƿ����
:existfolder
if "%~1"=="" goto :eof
for %%a in (existfolder #existfolder) do if defined %%a set %%a=
:existfolder2
set existfolder2=%~1
if not "%existfolder2:~1,2%"==":\" goto :eof
if not "%existfolder2:~-1%"=="\" set existfolder2=%existfolder2%\
dir "%existfolder2%">nul 2>nul
if exist "%existfolder2%" (set existfolder=!existfolder! "!existfolder2!") else set #existfolder=!#existfolder! "!existfolder2!"
if not "%~2"=="" (
	shift /1
	goto existfolder2
)
goto :eof

REM ָ���ļ���Ŀ¼�Ϲ��ж�
:checkfolderfile
if "%~1"=="" exit /b 1
for %%A in (copy move) do (
	if /i "%%A"=="%~1" (
		if "%%~b"=="" (
			echo=	#δָ������·��,������
			exit/b 1
		) else (
			if not exist "%~2" (
				echo=	#ָ������·��"%~2"������,���������
				exit /b 1
			) else (
				dir "%~2">nul 2>nul||(
					echo=	#ָ���Ĳ���·��"%~2"���ļ���,���������
					exit /b 1
				)
			)
		)
	)
)
for %%A in (save) do (
	if /i "%%A"=="%~1" (
		if "%~2"=="" (
			echo=	#δָ������·��,���������
			exit/b 1
		)
		if exist "%~dp2\" (
			if exist "%~2" (
				echo=	#ָ���ļ�"%~2"�Ѵ���,���������
				exit /b 1
			)
		) else (
			echo=	#ָ���ļ�·��"%~dp2"������,���������
			exit /b 1
		)
	)
)
for %%A in (ren) do (
	if /i "%%A"=="%~1" if "%~2"=="" if "%~3"=="" (
		echo=	#δָ���滻����,���������
		exit/b 1
	)
)
exit /b 0

REM Сдת��Ϊ��д
:convert
if "%~1"=="" (goto :eof) else if not defined %~1 goto :eof
for %%a in ("a=A","b=B","c=C","d=D","e=E","f=F","g=G","h=H","i=I","j=J","k=K","l=L","m=M","n=N","o=O","p=P","q=Q","r=R","s=S","t=T","u=U","v=V","w=W","x=X","y=Y","z=Z") do set %~1=!%~1:%%~a!
goto :eof

REM ȥ���ظ�
:wipe2
if "%~1"=="" (goto :eof) else if defined %~1 (set %~1=!%~1: =!) else goto :eof
if defined wipe2result set wipe2result=
for %%a in (%litter%) do if not "!%~1:%%a=!"=="!%~1!" set wipe2result=!wipe2result! %%a
set %~1=%wipe2result:~1%
goto :eof

REM �жϱ������Ƿ��з������ַ� call:DefinedNoNumberString ���ж��ַ�
REM					����ֵ0�����з������ַ�������ֵ1�����޷������ַ�
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

REM �жϱ������Ƿ��з�a-z,A-Z�ַ� call:DefinedNoAbString ���ж��ַ�
REM					����ֵ0������a-z,A-Z�ַ�������ֵ1������a-z,A-Z�ַ�
:DefinedNoAbString
REM �ж��ӳ�������������
if "%~1"=="" exit/b 2

REM ��ʼ���ӳ����������
for %%B in (DefinedNoAbString) do set %%B=
set DefinedNoAbString=%~1

REM �ӳ���ʼ����
for %%B in (a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
	set DefinedNoAbString=!DefinedNoAbString:%%B=!
	if not defined DefinedNoAbString exit/b 1
)
exit/b 0

REM ���ڼ��
:existcheck
if "%~1"=="" (goto :eof) else if not defined %~1 goto :eof
for %%a in (existcheck1 #%~1) do set %%a=
for %%a in (!%~1!) do if exist %%a:\ (set existcheck1=!existcheck1! %%a) else set #%~1=!#%~1! %%a
set %~1=%existcheck1%
goto :eof

REM �����д���ļ�
:createresultfile
if "%~1"=="" goto :eof
if not defined searchfiledijia1 goto :eof
set createresultfile=0
if not exist "%~d1\" goto :eof
if not exist "%~dp1" md "%~dp1"
echo=>"%~1"
:createresultfile2
set /a createresultfile+=1
if defined searchfiledijia!createresultfile! (
	echo=!searchfiledijia%createresultfile%!>>"%~1"
	set searchfiledijia!createresultfile!=
	goto createresultfile2
) else goto :eof
goto :eof

REM ������ʾ�б�
:echoresultlist
if not defined searchfiledijia1 goto :eof
set echoresultlist=0
cls
echo=#����б�
echo=
:echoresultlist2
set /a echoresultlist+=1
if defined searchfiledijia%echoresultlist% (
	set echoresultlist2=!searchfiledijia%echoresultlist%:"=!
	if exist "!echoresultlist2!" echo=[!echoresultlist!]"!searchfiledijia%echoresultlist%!"[!echoresultlist!]
	goto echoresultlist2
) else (
	echo=
	goto :eof
)

REM call:UpdateProjectVersion ��Ŀ���� ��ǰ�汾 ���µ�ַ ��ĿԴ�ļ�����·��("%~0")
:������Ŀ�汾 20151106
:UpdateProjectVersion

REM ����ӳ���ʹ�û���������ȷ���
if "%~4"=="" (
	echo=	#[���� %0:����4]��ĿԴ�ļ�����·��Ϊ��
	exit/b 1
) else if "%~3"=="" (
	echo=	#[���� %0:����3]���µ�ַΪ��
	exit/b 1
) else if "%~2"=="" (
	echo=	#[���� %0:����2]��ǰ�汾Ϊ��
	exit/b 1
) else if "%~1"=="" (
	echo=	#[���� %0:����1]��Ŀ����Ϊ��
	exit/b 1
)

REM ��ʼ���ӳ����������
for %%I in (updateVersionName updateVersionPath updateNewVersion updateNewVersionName updateVersionOldVersionPath) do if defined %%I set %%I=
set updateVersionName=%~1.Version
set updateVersionPath=%temp%\%updateVersionName%%random%%ranom%%random%

REM �ӳ���ʼ����
echo=#���ڼ�������Ŀ: %~1	��ǰ�汾: %~2
call:DownloadNetFile %~3/%updateVersionName% "%updateVersionPath%"
if not "%errorlevel%"=="0" (
	echo=	#����ʧ��,�޷����ӵ�������,���������
	exit/b
)
for /f "usebackq tokens=1,2 delims= " %%I in ("%updateVersionPath%") do (
	if %~2 lss %%I (
		echo=#��⵽��Ŀ�°汾 %%I ���ڳ��Ը�����Ŀ...
		set updateNewVersion=%%I
		set updateNewVersionName=%%~J
		call:DownloadNetFile %~3/%%~J "%~dp0\%%~J"
		if "!errorlevel!"=="0" (
			set updateNewVersionPath=%~dp0%%~J
			echo=#��Ŀ %~1 �°汾 %%I ���سɹ�
			goto  UpdateProjectVersion2
		) else (
			if exist "%updateVersionPath%" del /f /q "%updateVersionPath%"
			echo=	#����ʧ��,�޷��ӷ��������ظ����ļ�,���Ժ�����
			exit/b 1
		)
	) else (
		if exist "%updateVersionPath%" del /f /q "%updateVersionPath%"
		echo=#�������°汾,��л���Ĺ�ע
		exit/b 1
	)
)
:UpdateProjectVersion2
if exist "%updateVersionPath%" del /f /q "%updateVersionPath%"

REM �˴�Ϊ�°汾���سɹ���Ҫ���Ķ���
REM 	%1	��Ŀ����
REM 	%2	�ɰ汾
REM 	"%~4"	��Ŀ�ɰ汾Դ�ļ�����·��
REM 	%updateNewVersion%	���º��ļ��汾
REM 	%updateNewVersionPath%	���º�汾�ļ�·��


REM ɾ���ɰ汾�����°汾
echo=	#�������°汾��Ŀ %1 %updateNewVersion%
ping -n 3 127.1>nul 2>nul
set updateVersionOldVersionPath=%~4
if /i "%updateVersionOldVersionPath:~-4%"==".exe" taskkill /f /im "%~nx4">nul 2>nul
(
	copy "%~4" "%~4_updatebak">nul 2>nul
	del /f /q "%~4"
	copy "%updateNewVersionPath%" "%~4">nul 2>nul
	if "!errorlevel!"=="0" (
		start "" "%~4"
		del /f /q "%~4_updatebak"
		del /f /q "%updateNewVersionPath%"
		exit
	) else (
		copy "%~4_updatebak" "%~4">nul 2>nul
		echo=#���°汾ʧ�ܣ������ֶ����°汾��Ŀ %updateNewVersionPath%
		del /f /q "%~4_updatebak"
		pause
		explorer /select,"%updateNewVersionPath%"
		exit
	)
)
exit/b 0

REM call:DownloadNetFile ��ַ ·�����ļ���
:���������ļ� 20151105
:DownloadNetFile
REM ����ӳ���ʹ�ù�����ȷ���
if "%~2"=="" (
	echo=	#[Error %0:����2]�ļ�·��Ϊ��
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
echo=Set xPost = CreateObject("Microsoft.XMLHTTP") >"%downloadNetFileTempPath%"
echo=xPost.Open "GET",%downloadNetFileUrl%,0 >>"%downloadNetFileTempPath%"
echo=xPost.Send() >>"%downloadNetFileTempPath%"
echo=Set sGet = CreateObject("ADODB.Stream") >>"%downloadNetFileTempPath%"
echo=sGet.Mode = 3 >>"%downloadNetFileTempPath%"
echo=sGet.Type = 1 >>"%downloadNetFileTempPath%"
echo=sGet.Open() >>"%downloadNetFileTempPath%"
echo=sGet.Write(xPost.responseBody) >>"%downloadNetFileTempPath%"
echo=sGet.SaveToFile "%downloadNetFileFilePath%",2 >>"%downloadNetFileTempPath%"

REM ɾ��IE�����������ݵĻ���
for /f "tokens=3,* skip=2" %%- in ('reg query "hkcu\software\microsoft\windows\currentversion\explorer\shell folders" /v cache') do if "%%~."=="" (set downloadNetFileCachePath=%%-) else set downloadNetFileCachePath=%%- %%.
for /r "%downloadNetFileCachePath%" %%- in ("%~n1*") do if exist "%%~-" del /f /q "%%~-"

REM ���нű�
cscript //b "%downloadNetFileTempPath%"

REM ɾ����ʱ�ļ�
if exist "%downloadNetFIleTempPath%" del /f /q "%downloadNetFIleTempPath%"

REM �жϽű����н��
if exist "%downloadNetFileFilePath%" (exit/b 0) else exit/b 1

REM �������������
:searchresulthelp
if "%~1"=="1" (
	echo=
	echo=#����
	echo=	1.����";"�����������²鿴�������
	echo=	2.�����������ǰ���"[]"�е��ļ���ſɴ򿪸��ļ�
	echo=	  ���ļ���ź��һ���ո����ʹ��Windows��Դ���������ļ�����·��
	echo=	3.����"//"���ں�����ַ��ɴӽ����ɸѡ����"//"���ַ��Ľ��^(��������Ҫfindstr^)
	echo=		��:�ӽ����ɸѡ����windows�Ľ�� : //windows
	echo=	4.����"/-"���ں�����ַ��ɴӽ����ɸѡ������"/-"���ַ��Ľ��^(��������Ҫfindstr^)
	echo=		��:�ӽ����ɸѡ������windows�Ľ�� : /-windows
	echo=	5.����"'"���ں�����ؼ����ڵ�ǰָ������Ŀ¼��������������"'"����ؼ��ֵ��ļ�
	echo=	  Ҳ��ֻ����"'"�������ʾ����
	echo=		��:�ӵ�ǰָ������Ŀ¼��������������bfs���ļ� : 'bfs
	echo=	6.���� /o /w /d �ֱ���� "��" "½����" "ɾ��"
	echo=	  ʹ�÷���Ϊ���� /o /w /d ����ļ���ż���ʵ�ֶ��ļ��Ĳ���
	echo=	  ���ļ���ŵ�ָ����ʹ�÷��� "-" "," ����� "*" ���� "-" ��������ָ��� "," ��������ֵ�ָ��� "*" ��������
	echo=		��:������������ļ�ɾ��: /d*
	echo=		��:����������Ϊ1,2,3,4,5,9,11,12,13��������ļ�ɾ��: /d1-5,9,11-13
	echo=		��:����������Ϊ1,2,3,4,5,9,11,12,13��������ļ���: /o1-5,9,11-13
	echo=		��:����������Ϊ1,2,3,4,5,9,11,12,13��������ļ�½����: /w1-5,9,11-13
	echo=	7.���� /c /m /s �ֱ���� "���Ƶ�ָ���ļ���" "�ƶ���ָ���ļ���" "������Ŀ��ָ���ı��ĵ�"
	echo=	  ʹ�÷���Ϊ���� /c /m /s ����ļ����+�ո�+����·������ʵ�ֶ��ļ��Ĳ���
	echo=	  ���ļ���ŵ�ָ����ʹ�÷��� "-" "," ����� "*" ���� "-" ��������ָ��� "," ��������ֵ�ָ��� "*" ��������
	echo=		��:������������ļ����Ƶ�"d:\temp\" : /c* d:\temp\
	echo=		��:����������Ϊ1,2,3,4,5,9,11,12,13��������ļ����Ƶ�"d:\temp\" : /c1-5,9,11-13 d:\temp\
	echo=		��:����������Ϊ1,2,3,4,5,9,11,12,13��������ļ��ƶ���"d:\temp\" : /m1-5,9,11-13 d:\temp\
	echo=		��:����������Ϊ1,2,3,4,5,9,11,12,13��������ļ���Ŀ���浽"d:\temp\list.txt" : /s1-5,9,11-13 d:\temp\list.txt
	echo=	8.���� /r /a �ֱ�����滻�ļ������ļ������
	echo=	  ʹ�÷���Ϊ���� /r ����ļ����+�ո�+���滻�ַ�+�ո�+�滻���ַ� ����ʵ�ֶ��ļ��Ĳ���
	echo=	  ʹ�÷���Ϊ���� /a ����ļ����+�ո�+�ļ���ǰ����ַ�+�ո�+�ļ���������ַ� ����ʵ�ֶ��ļ��Ĳ���
	echo=	  ���ļ���ŵ�ָ����ʹ�÷��� "-" "," ����� "*" ���� "-" ��������ָ��� "," ��������ֵ�ָ��� "*" ��������
	echo=		��:������������ļ�������temp�������滻Ϊnotemp : /r* temp notemp
	echo=		��:����������Ϊ1,2,3,4,5,9,11,12,13��������ļ��ļ����а���temp�������滻Ϊnotemp : /r1-5,9,11-13 temp notemp
	echo=	9.����"0"��":"�ɷ������˵�
	echo=	10.����"."���˳�
	echo=
)
if "%~1"=="2" (
	echo=
	echo=#����
	echo=	1.ȫ������������","��"*"
	echo=	2.�˳�������"."
	echo=	3.�˴������뵥�����������̷���ָ��������Χ
	echo=	4.�˴���������Ŀ¼��ָ��������Χ
	echo=	  ���Ŀ¼֮���ÿո�ֿ������Ŀ¼�к��пո��������߼�Ӣ��˫����
	echo=		��:ָ��C: D: E: Ϊ������Χ�ڴ˴�����"cde"����
	echo=		��:ָ��Ŀ¼c:\windows��d:\program filesΪ������Χ
	echo=		   �ڴ˴����� c:\windows "d:\program files" ����
	echo=
	reg query hkcr\folder\shell\BFS����\command /ve >nul 2>nul
	if "!errorlevel!"=="0" (echo=	5.ж���ļ����Ҽ������˵������� "$" ^(��ǰ�Ѱ�װ^)) else echo=	5.��װ�ļ����Ҽ������˵������� "$" ^(��ǰδ��װ^)
	echo=		ע��:ж�ػ�װ�Ҽ��˵���Ҫ����ԱȨ��
	echo=
	echo=	6.���� "@" �ɼ�����BFS����^(���ܻᱻɱ��������������μ���^)
	echo=
)
if "%~1"=="3" (
	echo=
	echo=#����
	echo=	1.��Ҫ�������ļ��к���ĳ���ؼ���ֱ��������Ҫ�����Ĺؼ��ּ���^(�����ִ�Сд^)
	echo=	  ��ͬʱ�������ؼ���,����ؼ���֮���ÿո����
	echo=	  ��ؼ������пո�����Ӣ��˫������ס
	echo=		��:�����ļ����к���bfs����"g d"���ļ�����:bfs "g d"
	echo=	2.��������ָ��׼ȷ�ļ��������ļ���ǰ��"\"
	echo=		��:�����ļ���Ϊbfs.bat���ļ�: \bfs.bat
	echo=	3.����֧��ͨ���"*","?"
	echo=		������������������������,��ʱ�޷�ͨ���ؼ��������ļ������з��� "&" "^" ���ļ�
	echo=		���� ";" ���ļ�����ؼ��ּ���˫����
	echo=			^(ͨ�������ؼ����������Ľ�����з��� "&" ";" ����������Ӱ��^)
	echo=	4.���� ":" �ɷ������˵�
	echo=
	echo=	5.�������
	echo=	  /image		����ͼƬ����
	echo=	  /video		������Ƶ����
	echo=	  /audio		������Ƶ����
	echo=	  /txt		�����ĵ�����
	echo=	  /compress	����ѹ���ļ�����
	echo=		��:����������Ƶ�����ļ�����:/video
	echo=
)
if "%~1"=="4" (
	echo=#����
	echo=	1.����ָ�����������������"*"����
	echo=	2.����ָ������������������кż���
	echo=	3.����ָ��ĳ�������������ɽ���ʼ���к���������к���"-"���ӣ����磺5-19
	echo=	4.����ָ�����������������п���","���зָ���磺5,7,9,13
	echo=	  ���� "-" �� "," �������ʹ�� ��:1,2,5-19,30
	echo=	5.����"0"��":"�ɷ������˵�
	echo=	6.����"."���˳�
	echo=
)
if "%~1"=="5" (
	echo=#����
	echo=	1.ֱ���ڴ˴�����Ŀ��·������
	echo=	2.����"0"��":"�ɷ������˵�
	echo=	3.����"."���˳�
	echo=
)
goto :eof


:-----------------------------------�ӳ������-----------------------------------
:end
exit /b