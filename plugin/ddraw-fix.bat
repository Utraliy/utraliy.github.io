@echo off

reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs" /v ddraw>nul 2>nul&&goto A
echo �����������ϵͳ��Ч��
goto exitcmd

:A
for /f "tokens=3" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v ExcludeFromKnownDlls') do (
set kValue=%%i
)
if "%kValue%" == "" (
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v ExcludeFromKnownDlls /t REG_MULTI_SZ /d "ddraw.dll" /f > nul&& goto success || goto fail
) else (
echo %kValue%|findstr "ddraw.dll">nul && (
echo ������ʹ�ù�!
goto exitcmd
) || (
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v ExcludeFromKnownDlls /t REG_MULTI_SZ /d %kValue%\0"ddraw.dll" /f >nul && goto success || goto fail
)
)
:success
echo ����Ӧ�óɹ���������������ò�����Ч��
goto exitcmd

:fail
echo ���ź�������Ӧ��ʧ�ܣ�

:exitcmd
pause