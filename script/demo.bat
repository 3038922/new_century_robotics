@echo off

%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
set pro=%~dp0EasyPython
set lib=%pro%\lib
set install=%pro%\install
set pydir=%pro%\python
set pyexe=%pydir%\python.exe
set pipexe=%pydir%\Scripts\pip.exe
set downloadvbs=%install%\download.vbs
set mklinkvbs=%install%\mklink.vbs
set gitdir=%pro%\git
git --version 2>NUL && set gitexe=git || set gitexe=%gitdir%\bin\git.exe
%pro:~0,2%
cd "%~dp0"

echo 请关闭所有类似360、腾讯管家等有可能拦截系统修改的安全软件，防止系统安装出错。
echo 确认关闭后，请按【回车】键继续...
pause
echo ==============================================
mkdir "%pro%" 2>NUL
mkdir "%install%" 2>NUL

python --version 2>NUL && goto IFPYVERSION || goto INSTALLPY

:IFPYVERSION
python -c "import sys;if sys.version_info.major != 3 or sys.version_info.minor < 6: print('python版本过低，将会自动安装较新版本。'); sys.exit(2)" && set pyexe=python && set pipexe=python -m pip && goto INSTALLPIP || goto INSTALLPY

:INSTALLPY
if not exist "%install%\pyinstall.exe" (
    echo 下载Python3中，请稍后...
    bitsadmin /transfer "下载Python3中，请稍后..." "https://npm.taobao.org/mirrors/python/3.6.6/python-3.6.6.exe" "%install%\pyinstall.exe"
)
echo 尝试安装Python3中，可能需要15分钟。
echo 期间窗口不会有任何变化，请勿中途关闭窗口，否则会导致安装失败！
echo 请稍后...
echo ==============================================
"%install%\pyinstall.exe" /quiet InstallAllUsers=1 PrependPath=1 Shortcuts=1 Include_pip=1 TargetDir="%pydir%"
%pipexe% --version 2>NUL && (
    echo Python3安装成功。
    echo ===============================================
) || (
    echo Python3安装失败！
    echo 请打开【控制面板】中的【程序和功能】，将所有Python卸载，并删除%pro%文件夹，然后重新安装。
    pause
    exit
)

:INSTALLPIP
echo 安装依赖模块中，请稍后...
"%pipexe%" install jupyter wget gitpython requests jupyterlab -i https://pypi.douban.com/simple --upgrade
echo ===============================================

%gitexe% --version 2>NUL && goto GITCLONE

:INSTALLGIT
(
    echo 未找到git程序，尝试安装中...
    if not exist "%install%\git-install.exe" (
        "%pyexe%" -m wget "https://npm.taobao.org/mirrors/git-for-windows/v2.23.0.windows.1/Git-2.23.0-32-bit.exe" -o "%install%\git-install.exe"
        if not exist "%install%\git-install.exe" (
            echo 下载git安装程序失败，请重试...
            pause
            exit
        )
    )
    set installDir=%gitdir%
    set installDir=%installDir:"=%
    (
        echo [Setup]
        echo Lang=default
        echo Dir=%installDir%
        echo Group=Git
        echo NoIcons=0
        echo SetupType=default
        echo Components=icons,ext\reg\shellhere,assoc,assoc_sh
        echo Tasks=
        echo PathOption=Cmd
        echo SSHOption=OpenSSH
        echo CRLFOption=CRLFAlways
        echo BashTerminalOption=ConHost
        echo PerformanceTweaksFSCache=Enabled
        echo UseCredentialManager=Enabled
        echo EnableSymlinks=Disabled
        echo EnableBuiltinDifftool=Disabled
    ) > config.inf

    "%install%\git-install.exe" /VERYSILENT /LOADINF="config.inf"
    if errorlevel 1 (
        @echo on
        if %errorLevel% == 1 ( echo Error opening %file%. File may be corrupt. )
        if %errorLevel% == 2 ( echo Error reading %file%. May require elevated privileges. Run as administrator. )
        exit /b %errorlevel%
    )
    del config.inf

    net session >nul 2>&1
    if %errorLevel% == 0 (
        :: pathman /as "%PATH%;%installDir%/cmd"
        exit 0
    ) else (
        @echo on
        echo SYSTEM PATH Environment Variable may not be set, may require elevated privileges. Run as administrator if it doesn't already exist.
        exit /b 0
    )
    if not exist %gitexe% (
        echo git安装失败，请重试！
        pause
        exit
    )
    "%gitexe%" config --global user.name learner
    "%gitexe%" config --global user.email learner@none.com
)

:GITCLONE
if not exist "%lib%\start.bat" (
    "%gitexe%" clone https://gitee.com/easypython/Easy_Python_Client.git "%lib%" 2>NUL || git clone https://gitee.com/easypython/Easy_Python_Client.git "%lib%"
) else (
    "%gitexe%" -C "%lib%" pull origin master 2>NUL || git -C "%lib%" pull origin master
)
if exist "%lib%\start.bat" (
    (
        echo set WshShell=WScript.CreateObject("WScript.Shell"^)
        echo strDesktop=WshShell.SpecialFolders("Desktop"^)
        echo set oShellLink=WshShell.CreateShortcut(strDesktop ^& "\EasyPython教程.lnk"^)
        echo oShellLink.TargetPath="%lib%\start.bat"
        echo oShellLink.WindowStyle=1
        echo oShellLink.Hotkey=""
        echo oShellLink.IconLocation="%lib%\logo.ico"
        echo oShellLink.Description="打开EasyPython开始学习"
        echo oShellLink.WorkingDirectory=strDesktop
        echo oShellLink.Save
    ) > mklink.vbs
    cscript mklink.vbs
    del mklink.vbs

    echo 安装成功！
    echo 强力推荐安装Chrome浏览器并设为默认，否则可能无法保证100%兼容，尤其IE浏览器完全无法正常运行本系统。
    echo 按下【回车】将自动安装Chrome浏览器，如不需要，点击右上角关闭本窗口后，双击桌面的【EasyPython教程】即可使用教程。
    pause
    echo 下载Chrome中，请稍后...
    if not exist "%install%\chrome-install.exe" (
        "%pyexe%" -m wget "http://www.chromeliulanqi.com/ChromeStandaloneSetup.exe" -o "%install%\chrome-install.exe"
    )
    echo 安装Chrome中，请稍后...
    "%install%\chrome-install.exe" /silent /install
    echo Chrome安装完成！
) else (
    echo 安装失败，请在【控制面板】的【程序和功能】中，卸载Python3.6.6和Git，并删除%pro%后重试！
)
pause