@echo off

reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs" /v ddraw>nul 2>nul&&goto A
echo 本补丁对你的系统无效！
goto exitcmd

:A
for /f "tokens=3" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v ExcludeFromKnownDlls') do (
set kValue=%%i
)
if "%kValue%" == "" (
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v ExcludeFromKnownDlls /t REG_MULTI_SZ /d "ddraw.dll" /f > nul&& goto success || goto fail
) else (
echo %kValue%|findstr "ddraw.dll">nul && (
echo 补丁已使用过!
goto exitcmd
) || (
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v ExcludeFromKnownDlls /t REG_MULTI_SZ /d %kValue%\0"ddraw.dll" /f >nul && goto success || goto fail
)
)
:success
echo 补丁应用成功，请重启计算机让补丁生效！
goto exitcmd

:fail
echo 很遗憾，补丁应用失败！

:exitcmd
pause