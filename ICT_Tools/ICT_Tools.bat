@echo off&setlocal ENABLEDELAYEDEXPANSION&title ICT������&color 0a
cd /d "%~dp0"
set askopenict=
tasklist /fo csv /nh /fi "windowtitle eq TR-518FE" 2>nul|find """" >nul
if not "%errorlevel%"=="0" call:openict
:mainmenu
cls&set date=&set mainmenu=
echo=&echo=_______________________ICT������_______________________&echo=
if defined result echo ��ʾ��&echo      %result%&set result=&echo=
echo=		1.������Ʒ��¼���ѯ
echo=		2.�Ѳ��Ʒ������ѯ[���ڸ�ʽ:2XXXXXXXX]
echo=		3.������ļ�����
echo=		4.��ӡ�Զ�������
echo=		5.ICT����Ӣ�����

echo=
echo=		a.����ICT������
echo=______________________________________________________
echo=                                        ����Q�˳�
echo=
set /p mainmenu=������������ţ�
if not exist %date:~0,10%\barcode md %date:~0,10%\BarCode
if not exist %date:~0,10%\Log\In md %date:~0,10%\Log\In
if not exist %date:~0,10%\Log\All md %date:~0,10%\Log\All
if not defined mainmenu goto mainmenu
if /i "%mainmenu%"=="q" exit /b
if /i "%mainmenu%"=="a" goto about
if "%mainmenu%"=="1" goto barcode
if "%mainmenu%"=="2" goto overtestcount
if "%mainmenu:~0,1%"=="2" (
	if not "%mainmenu:~8,1%"=="" (
		if "%mainmenu:~9%"=="" (
			echo %mainmenu%|findstr [a-z]>nul&&set result=��ʽ���󣬷�����2008��5��1��-220080501&&goto mainmenu
			set date=%mainmenu:~1,4%-%mainmenu:~5,2%-%mainmenu:~7,2%
			goto overtestcount
)))
if "%mainmenu%"=="3" goto filesearch
if "%mainmenu%"=="4" goto printmenu
if "%mainmenu%"=="5" goto ictenglish
if not "%mainmenu:~12,1%"=="" if "%mainmenu:~13%"=="" set barcode=%mainmenu%&goto wrong
if defined mainmenu set result=��������������������
goto mainmenu

:barcode
cls&set date=&set barcode=&set print=
echo=&echo=__________________������Ʒ��¼���ѯ__________________&echo=
if defined result echo ��ʾ��&echo      %result%&set result=&echo=
echo=		1.δ����
echo=		2.������ǩ
echo 		3.��־ͳ�����ѯ[���ڸ�ʽ:3XXXXXXXX]
echo=______________________________________________________
echo=                                     ����Q�������˵�
set /p barcode=��ɨ����Ʒ���룺
if not defined barcode goto barcode
if "%barcode%"=="q" goto mainmenu
if "%barcode%"=="1" set err2=������&goto write2
if "%barcode%"=="2" set err2=����������ǩ&goto write2
if "%barcode%"=="3" goto Log
if "%barcode:~0,1%"=="3" (
	if not "%barcode:~8,1%"=="" (
		if "%barcode:~9%"=="" (
			echo %barcode%|findstr [a-z]>nul&&set result=��ʽ���󣬷�����2008��5��1��-320080501&&goto barcode
			set date=%barcode:~1,4%-%barcode:~5,2%-%barcode:~7,2%
			if not exist !date! set result=����!date!û����־�ļ������������&set date=&goto barcode
			goto log
)))
if "%barcode:~12,1%"=="" set result=�������&goto barcode
if not "%barcode:~13%"=="" set result=�������&goto barcode
goto wrong
:wrong
cls
echo=&echo=_____________________������Ʒ��¼_____________________&echo=
echo=����״�����룺
echo=      1-����,2-�պ�,3-��δ��,4-����,5-����,6-�������
echo=��ʽ��
echo=      ����������� ����״������(���ƺʹ����ÿո����)
echo=      ���ж������������á�.���ָ�,����ת��Ϊ���롱
echo=      ��β��P��ӡ�������ݣ��󸽿ո���ٸ���ӡ��ע
echo=������
echo=     U1������U1 1        C56��C57������C56.C57 1
echo=     R1��R2������ӡ�������ݣ�R1.R2 1p
echo=     R3��R4�պ���ӡ�������ݱ�עΪ�����桱R3.R4 2p ����
echo=______________________________________________________
echo=%barcode%:
if exist %date:~0,10%\BarCode\%barcode% (findstr /n . %date:~0,10%\BarCode\%barcode%) else echo=              �����������ظ����Լ�¼
echo=______________________________________________________
set wrong=&set err=&set err2=&set err3=
echo=                                       ����Q����
set /p wrong=�����벻����Ϣ��
if not defined wrong goto wrong
if /i "%wrong%"=="q" goto barcode
echo=%wrong%|find " ">nul
echo=%wrong%|findstr /b [a-z]
if not  "%errorlevel%"=="0" goto wrong
call:convert
:write
echo %time:~0,8% %err% %err2%>>%date:~0,10%\BarCode\%barcode%
set num=
if exist %date:~0,10%\Log\In\%err%%err2% for /f "tokens=3" %%a in (%date:~0,10%\Log\In\%err%%err2%) do set num=%%a
set /a num+=1
echo %err% %err2% %num% >%date:~0,10%\Log\In\%err%%err2%
set result=%barcode%:%err%%err2% : %num% ��¼��
:write2
set num=
if exist %date:~0,10%\log\All\%err2% for /f %%a in (%date:~0,10%\log\All\%err2%) do set num=%%a
set /a num+=1
echo %num% >%date:~0,10%\Log\All\%err2%
if "%err2%"=="������" set result=������ : %num% ��¼��
if "%err2%"=="����������ǩ" set result=����������ǩ : %num% ��¼��
set num=
if exist %date:~0,10%\log\All\All for /f %%a in (%date:~0,10%\log\All\All) do set num=%%a
set /a num+=1
echo %num% >%date:~0,10%\Log\All\All
if /i "%print%"=="Yes" echo=���ڷ��ʹ�ӡ����糤ʱͣ����ҳ�������ӡ�����û�����&call:print "----��Ʒ����״�� %date:~0,10% %time:~0,8%-----" "%barcode%��%err%%err2%" "%err3%"
goto barcode

:log
cls
echo %date:~0,10%:&echo=______________������Ʒ��¼��־ͳ�����ѯ______________&echo=
set rizhifenxiang=
for %%a in (all ���� �պ� ��δ�� ���� ���� ������ ����������ǩ �������) do set error%%a=
for %%a in (all ���� �պ� ��δ�� ���� ���� ������ ����������ǩ �������) do (
	if exist %date:~0,10%\log\all\%%a (for /f %%b in (%date:~0,10%\log\all\%%a) do set error%%a=%%b)else set error%%a=0
)
echo ���Ʋ��� %errorall%
echo ���� %error����% , �պ� %error�պ�% , ��δ�� %error��δ��% , ���� %error����% , ���� %error����%
echo ������ %error������% , ����������ǩ %error����������ǩ% , ������� %error�������%
echo=&echo=______________________________________________________
for /f "delims=" %%a in ('dir /b %date:~0,10%\Log\In') do for /f "tokens=1-3" %%i in (%date:~0,10%\Log\In\%%a) do echo %%i%%j %%k&set rizhifenxiang=%%i%%j%%k	!rizhifenxiang!
echo=                                            F_Ms
echo=______________________________________________________
echo=                                   ���� P ��ӡ��־
set user=
set /p user=������ؼ��ֽ���������
if not defined user goto barcode
if /i "%user%"=="p" call:print "----��Ʒ������־ %date:~0,10% %time:~0,8%-----" "���Ʋ���:%errorall%" "����:%error����%	�պ�:%error�պ�%	��δ��:%error��δ��%	����:%error����%	����:%error����%	�������:%error�������%	������:%error������%	����������ǩ:%error����������ǩ%" " " "���" "%rizhifenxiang%"&set result=��Ʒ������־��ӡ�����ѷ���&goto barcode
pushd %date:~0,10%\barcode
findstr /l /i "%user%" *
if not "%errorlevel%"=="0" echo ���ݹؼ���δ���ҵ����ݣ�������
popd
pause>nul
goto barcode

:overtestcount
echo=���ڲ������ݿⲢ���㣬���Ժ�... ...
for /l %%a in (1,1,4) do set overtestcount%%a=&set fordo=
echo=>firstdelete.ini
if exist datapath.ini (set fordo=for /f "delims=" %%a in ^(datapath.ini^)) else set fordo=for /r c:\ %%a in ^(%date:~0,4%%date:~5,2%%date:~8,2%.dat^)
%fordo% do if exist "%%a" (
	if exist firstdelete.ini (echo=%%~dpa>datapath.ini&del firstdelete.ini /f /q) else echo=%%~dpa>>datapath.ini
	for /f %%b in ('type "%%~dpa\%date:~0,4%%date:~5,2%%date:~8,2%.dat"^|find /c "PASS"') do set /a overtestcount1=overtestcount1+%%b
	for /f %%b in ('type "%%~dpa\%date:~0,4%%date:~5,2%%date:~8,2%.dat"^|findstr /v /b /i ", ooooooooooooo"^|find /c "PASS"') do set /a overtestcount2=overtestcount2+%%b
	for /f %%b in ('type "%%~dpa\%date:~0,4%%date:~5,2%%date:~8,2%.dat"^|findstr /v /b /i ", ooooooooooooo"^|find /c "FAIL"') do set /a overtestcount3=overtestcount3+%%b
)
for /l %%a in (1,1,3) do if not defined overtestcount%%a set overtestcount%%a=0
set /a overtestcount4=overtestcount1-overtestcount2
cls&echo %date:~0,10%:&echo=_____________________�Ѳ��Ʒ����_____________________&echo=
echo=�������⣺%overtestcount2% (����ο�����)
echo=�������⣺%overtestcount1%
echo=����������%overtestcount4%
echo=����������%overtestcount3%
echo=                                            F_Ms
echo=______________________________________________________
set user=
echo=
echo=���� P ��ӡ��������� C �򿪼�����
echo=����������ݲ�׼ȷ������ S ���������������ݿ��ļ�
set /p user=
if /i "%user%"=="p" echo=���ڷ��ʹ�ӡ����糤ʱͣ����ҳ�������ӡ�����û�����& call:print "----ICT��Ʒ���� %date:~0,10% %time:~0,8%-----" "�������⣺%overtestcount2% (����ο�����)" "�������⣺%overtestcount1%" "����������%overtestcount4%" "����������%overtestcount3%"
if /i "%user%"=="c" calc.exe
if /i "%user%"=="s" if exist datapath.ini del datapath.ini /f /q&cls&goto overtestcount
goto mainmenu

:convert
for /f "tokens=1,2,3" %%a in ("%wrong%") do set err=%%a&set err2=%%b&set err3=%%c
if /i "%err2:~-1%"=="p" set err2=%err2:~0,-1%&set print=Yes
if not "%err2%"=="1" if not "%err2%"=="2" if not "%err2%"=="3" if not "%err2%"=="4" if not "%err2%"=="5" if not "%err2%"=="6"  goto wrong
set err=%err:a=A%
set err=%err:b=B%
set err=%err:c=C%
set err=%err:d=D%
set err=%err:e=E%
set err=%err:f=F%
set err=%err:g=G%
set err=%err:h=H%
set err=%err:i=I%
set err=%err:j=J%
set err=%err:k=K%
set err=%err:l=L%
set err=%err:m=M%
set err=%err:n=N%
set err=%err:o=O%
set err=%err:p=P%
set err=%err:q=Q%
set err=%err:r=R%
set err=%err:s=S%
set err=%err:t=T%
set err=%err:u=U%
set err=%err:v=V%
set err=%err:w=W%
set err=%err:x=X%
set err=%err:y=Y%
set err=%err:z=Z%
set err=%err:.=��%
set err2=%err2:1=����%
set err2=%err2:2=�պ�%
set err2=%err2:3=��δ��%
set err2=%err2:4=����%
set err2=%err2:5=����%
set err2=%err2:6=�������%
if not "%err3%"=="" set err3=��ע:%err3%
goto :eof

:printmenu
cls&set diyprint=
echo=&echo=_______________ICT��ӡ���Զ������ݴ�ӡ________________&echo=
echo=   ������Ҫ��ӡ�����ݣ��������а����ո������д�ӡ
echo=       ��Ӣ������ " ��ס�ĺ��пո�����ݲ������
echo=   ������
echo=        a b c d - ��4��     �ֱ�Ϊa,b,c,d
echo=        a "b c" d - ��3��   �ֱ�Ϊa,b c,d
echo=        "a b" "c d" - ��2�� �ֱ�Ϊa b,c d
echo=______________________________________________________
echo=                                       ����Q����
set /p diyprint=:
if not defined diyprint goto printmenu
if /i "%diyprint:"=%"=="q" goto mainmenu
call:print /d %diyprint%
echo=���ڷ��ʹ�ӡ����糤ʱͣ����ҳ�������ӡ�����û�����
goto mainmenu

:print
set user=&set diy=
if exist "%temp%\~printer.tmp" del "%temp%\~printer.tmp" /f /q
if /i "%~1"=="/d" set diy=yes&shift /1
:printstart
if "%~1"=="" goto :eof
echo=%~1 >>"%temp%\~printer.tmp"
if not "%~2"=="" shift /1&goto printstart
if defined diy echo=_______��ӡ����Ԥ��_______&type "%temp%\~printer.tmp"&echo=_________Ԥ������_________&set /p user=ȷ�ϴ�ӡ������P��&if /i not "!user!"=="p" goto :eof
echo=                                   F_Ms>>"%temp%\~printer.tmp"
for /l %%a in (1,1,10) do echo=>>"%temp%\~printer.tmp"
print "%temp%\~printer.tmp">nul
goto :eof

:openict
echo=_______________________ICT������_______________________
echo=
echo=       ��⵽��δ��ICT���Գ���^(TRI^),�Ƿ�򿪣�
echo=               �س��򿪣���������������
echo=______________________________________________________
set /p askopenict=
tasklist /fo csv /nh /fi "windowtitle eq TR-518FE" 2>nul|find """" >nul
if not "%errorlevel%"=="0" if "%askopenict%"=="" (
	if exist ictpath.ini for /f "delims=" %%a in (ictpath.ini) do if exist "%%a" pushd "%%~dpa"&start "" "%%~nxa"&popd&goto ictopenover
	if exist "%userprofile%\����\tri.lnk" start "" "%userprofile%\����\tri.lnk" &goto ictopenover
	for /r c:\ %%a in (ew518fe.exe) do if exist "%%a" echo=%%~a>ictpath.ini&pushd "%%~dpa"&start "" "%%~nxa"&popd&goto ictopenover
	set ictpath=
	echo=����δ���Զ�������TRI������������������·����
	set /p ictpath=^(Ҳ�ɽ�����������˴���^)��
	set ictpath=!ictpath:"=!
	if exist "!ictpath!" if /i "!ictpath:~-4!"==".exe" echo "!ictpath!">ictpath.ini&start "" "!ictpath!"&goto ictopenover
	
) else goto :eof
:ictopenover
cls
echo=		      �ʻ���½
echo=
echo=		�����ߣ�TRI   (��д)
echo=		���룺  TRI   (��д)
echo=		���ţ�	120137853
echo=
echo=	20���Ӻ��Զ���ת��ICT���������˵�
ping -n 20 127.1 >nul 2>nul
goto :eof

:filesearch
cls
set drive=&set userfilename=&set userdrive=&set filesearchdijia=&set tempuserdrive=
for %%a in (A:\ B:\ C:\ D:\ E:\ F:\ G:\ H:\ I:\ J:\ K:\ L:\ M:\ N:\ O:\ P:\ Q:\ R:\ S:\ T:\ U:\ V:\ W:\ X:\ Y:\ Z:\) do if exist %%a set drive=!drive! %%a
if "%drive:~4%"=="" set userdrive=%drive%&echo=��ǰ����ֻ��һ������!userdrive!&goto filesearchfilename
echo=&echo=_______________________�ļ�����_______________________&echo=
if defined result echo ��ʾ��&echo      %result%&set result=&echo=
echo= ��ǰ��������  %drive:\=%
echo=______________________________________________________
echo=                   ����ȫ�������� ALL , ���������� QQ
set /p userdrive=������Ҫ�������̷���
if not defined userdrive goto filesearch
if /i "%userdrive%"=="qq" goto mainmenu
if /i "%userdrive%"=="all" set userdrive=%drive%&goto filesearchfilename
if not "%userdrive:~1,1%"=="" goto filesearch
echo %userdrive%|findstr [a-z]>nul
if not "%errorlevel%"=="0" (goto filesearch) else set userdrive=%userdrive%:\
if not exist %userdrive% set result=���� %userdrive% ������,���������&goto filesearch
:filesearchfilename
set /p userfilename=������Ҫ�������ļ�����
if not defined userfilename goto filesearchfilename
echo=���������ļ�"%userfilename:"=%"�����Ե�...
echo=&echo=_______________________�������_______________________
for %%a in (%userdrive%) do set tempuserdrive=%%a&call:filesearchstart
if not defined filesearchdijia set filesearchdijia=0
echo=&echo=�������,����%userfilename:"=%���ҵ�%filesearchdijia%���ļ�%&pause>nul
goto mainmenu
:filesearchstart
for /r %tempuserdrive% %%b in (%userfilename%) do if exist "%%b" echo %%b&set /a filesearchdijia+=1
goto :eof

:ictenglish
cls
echo=&echo=____________________ICT����Ӣ�����___________________&echo=
echo=      TEST  - tai_si_te    - ����  -ICT���� �ξ��װ���
echo=      ABORT - e_bao_er_te  - ֹͣ  -        �ξ��а���
echo=      DOWN  - da_wen       - �½�  -        �ξ�β����
echo=      PASS  - pa_si        - ͨ��  -          ��Ʒ��ʶ
echo=      FAIL  - fei_ou       - ʧ��  -        ����Ʒ��ʶ
echo=     SHORT  - shao_er_te   - ��С  -      ��·������ʶ
echo=      SAVE  - sei_fu       - ����
echo=     PRINT  - pu_rin_te    - ��ӡ  -      ��ӡ������ʶ
echo=     WI/SOP -                               ��ҵָ����
echo=      GO/NO-GO Sample -
echo=        - gou_no_gou_sai_mu_pou    -   ��Ʒ/����Ʒ����
echo=______________________________________________________
pause>nul&goto mainmenu

:about
cls
set space1=                          
set space2=                              
for /l %%a in (1,1,6) do echo=
echo=%space1%F_Ms
echo=
echo=%space2%ICT������
echo=%space2%2014��12��-2015��3��
echo=%space2%�ڹ���ѧChiconyPower
echo=%space2%��L18��ICT������ҵԱ
echo=%space2%Ϊ���ڲ鿴�����Ѳ���
echo=%space2%ͨ���İ�������Ӷ���
echo=%space2%��ʣ�๤��ʱ��ͼ�¼
echo=%space2%����Ʒ����ԭ��ͳ�ƺ�
echo=%space2%�������ڹ�����Ͼʱ��
echo=%space2%������BAT
pause>nul&goto mainmenu