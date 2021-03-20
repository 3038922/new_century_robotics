# 新世纪机器人社win10系统环境变量配置

Write-Host "此版本使用新世纪机器人学院(中国)安装源" -ForegroundColor Green
# 必备软件安装检查
Write-Host "正在检查cmake是否安装"  -ForegroundColor Green
$p = & { cmake --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "cmake没有安装或者环境变量没有添加" -ForegroundColor Red
    Write-Host "本程序即将结束,请安装后再次尝试" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "正在检查git是否安装"  -ForegroundColor Green
$p = & { git --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "git没有安装或者环境变量没有添加" -ForegroundColor Red
    Write-Host "本程序即将结束,请安装后再次尝试" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "正在检查python是否安装"  -ForegroundColor Green
$p = & { python --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "python没有安装或者环境变量没有添加" -ForegroundColor Red
    Write-Host "本程序即将结束,请安装后再次尝试" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "正在检查vscode是否安装"  -ForegroundColor Green
$p = & { code --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "vscode没有安装或者环境变量没有添加" -ForegroundColor Red
    Write-Host "本程序即将结束,请安装后再次尝试" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}

# powershell版本检查
$powershellVersion = $host.Version.ToString()
Write-Host "创建临时文件夹 c:\temp" -ForegroundColor Green
& mkdir c:/temp
if ($powershellVersion -ge "5.0.0.0") {
    #下载wirar
    #下载wirar
    $client = new-object System.Net.WebClient #创建下载对象
    if ( $(Test-Path C:\temp\winrar.exe)) {
        Write-Host "c:\temp\winrar.exe 已存在无需重新下载" -ForegroundColor Yellow
    }
    else {
        Write-Host "开始下载winrar.exe" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/EgsQdNJzZKjrGCz/download/WinRAR.exe', 'c:/temp/winrar.exe')
    }
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    & c:\temp\winrar.exe /S /v /qn #执行安装 

    #下载各种压缩包
    $client = new-object System.Net.WebClient #创建下载对象
    
    if ( $(Test-Path C:\temp\ninja+ccls+llvm.zip)) {
        Write-Host "c:\temp\ninja+ccls+llvm.zip 已存在无需重新下载" -ForegroundColor Yellow
    }
    else {
        Write-Host "开始下载ninja+ccls+llvm.zip" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/bTdZJ6SefSGbLzd/download', 'c:/temp/ninja+ccls+llvm.zip')
    }
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    if ($(Test-Path C:\temp\PROS.zip)) {
        Write-Host "c:\temp\PROS.zip 已存在无需重新下载" -ForegroundColor Yellow
    }
    else {
        Write-Host "开始下载PROS.zip" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/PSbyBdMJ2Ti8ZT8/download', 'c:/temp/PROS.zip')
    }   
    # 解压缩
    $isCcls = Test-Path C:\ccls
    if ($isCcls) {
        Write-Host "检测到 c:\ccls 文件夹已经存在,正在删除" -ForegroundColor Yellow
        Remove-Item C:\ccls\ -recurse -force
    }

    $isNinja = Test-Path C:\ninja
    if ($isNinja) {
        Write-Host "检测到 c:\ninja 文件夹已经存在,正在删除" -ForegroundColor Yellow
        Remove-Item C:\ninja\ -recurse -force
    }

    $isLlvm = Test-Path C:\llvm
    if ($isLlvm) {
        Write-Host "检测到 c:\llvm 文件夹已经存在,正在删除" -ForegroundColor Yellow
        Remove-Item C:\llvm\ -recurse -force
    }
    #单步解压
    $cmd = 'c:\Program Files\WinRAR\winrar.exe'
    $args = 'x -ibck -y c:\temp\ninja+ccls+llvm.zip c:\'
    Write-Host "开始解压缩ninja+ccls+llvm.zip" -ForegroundColor Green
    Start-Process  $cmd $args -Wait #解压缩zip

    $isPros = Test-Path 'C:\Program Files\PROS'
    if ($isPros) {
        Write-Host "检测到 C:\Program Files\PROS\ 文件夹已经存在,正在删除" -ForegroundColor Yellow
        Remove-Item -path 'C:\Program Files\PROS\' -recurse -force
    }
    $args = 'x  -ibck -y c:\temp\PROS.zip C:\Program Files\'
    Write-Host "开始解压缩pros.zip" -ForegroundColor Green
    Start-Process  $cmd $args -Wait #解压缩zip

    #添加全局变量
    $path = [environment]::GetEnvironmentVariable('Path', 'machine') # 获取数据
    $addPath = @('C:\ccls\Release', 'C:\llvm\Release\bin', 'C:\llvm\Release\lib', 'C:\ninja', 'C:\Program Files\PROS\toolchain\usr\bin')
    
    foreach ($it in $addPath) { 
        if ($path.split(";") -Contains $it) {
            Write-Host "路径: $it 已存在" -ForegroundColor yellow 
        }
        else {
            $path += ($it + ";")
            Write-Host "路径: $it 已添加" -ForegroundColor green 
        }
    }
    [environment]::SetEnvironmentvariable("Path", $path, "machine") #设置环境变量 user machine
    # pros_toolchain设置
    Write-Host "正在设置prosToolchain路径" -ForegroundColor Green
    $prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
    [environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

    #安装PROS工具链
    Write-Host "正在检查pros-cli是否安装"  -ForegroundColor Green
    $p = & { pros --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "pros-cli没有安装或者环境变量没有添加,开始安装" -ForegroundColor yellow
        & pip.exe install --upgrade pros-cli -i https://mirrors.aliyun.com/pypi/simple/
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }
    Write-Host  "正在安装vscode插件 setting sync" -ForegroundColor Green
    & code --install-extension shan.code-settings-sync

    # Write-Host "正在检查ninja是否安装"  -ForegroundColor Green
    # $p = & { ninja --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "ninja没有安装或者环境变量没有添加" -ForegroundColor Red
    #     Write-Host "请联系陈老师" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "正在检查clang是否安装"  -ForegroundColor Green
    # $p = & { clang --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "clang没有安装或者环境变量没有添加" -ForegroundColor Red
    #     Write-Host "请联系陈老师" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "正在检查ccls是否安装"  -ForegroundColor Green
    # $p = & { ccls --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "ccls没有安装或者环境变量没有添加" -ForegroundColor Red
    #     Write-Host "请联系陈老师" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "正在检查arm-none-eabi是否安装"  -ForegroundColor Green
    # $p = & { arm-none-eabi-gcc --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "arm-none-eabi没有安装或者环境变量没有添加" -ForegroundColor Red
    #     Write-Host "请联系陈老师" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "正在检查pros-cli是否安装"  -ForegroundColor Green
    # $p = & { prosv5 --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "pros-cli没有安装或者环境变量没有添加" -ForegroundColor Red
    #     Write-Host "请联系陈老师" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    Write-Host "正在删除临时下载存放文件夹"  -ForegroundColor Green
    Remove-Item C:\temp\ -recurse -force
    Write-Host "恭喜安装成功"  -ForegroundColor Green
}
else {
    Write-Host "powershell当前版本为:$powershellVersion, 请升级powershell至于5.x以上" -ForegroundColor Red
}












