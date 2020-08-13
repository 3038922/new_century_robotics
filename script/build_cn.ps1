# 下载单个文件
function DownloadItem {
    param([string]$url, [string]$path, [string]$filename , [string]$referer)
    if ($referer.Contains("(*)")) {
        $referer = $referer -replace "\(\*\)", $url
    }
    try {
        $tmpFileName = [System.IO.Path]::GetTempFileName()
        $destFileName = [System.IO.Path]::Combine($path, $filename)
        $watch = Measure-Command {
            # 下载文件到临时文件夹
            Invoke-WebRequest -Uri $url -Method Get -Headers @{"Referer" = $referer } -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36" -TimeoutSec 120 -OutFile $tmpFileName
            # 将临时文件移动到目标文件夹
            $flag = Test-Path $path 
            if (-not $flag) { 
                & mkdir $path 
            }
            Move-Item -Path $tmpFileName -Destination $destFileName -Force
        }
        $script:succeed += 1
        $fileLength = [Math]::Ceiling((Get-Item -LiteralPath $destFileName).Length / 1024.0)
        $elapsed = [Math]::Round($watch.TotalMilliseconds)
        # 下载成功！12.jpg - 115KB/2356ms
        Write-Host "下载成功！$filename - $fileLength KB/$elapsed ms" -ForegroundColor Green
    }
    catch {
        Write-Error $PSItem.ToString()
    }
    finally {
        $script:completed += 1
    }
}

# 新世纪机器人社win10系统环境变量配置

Write-Host "此版本使用新世纪机器人社(中国)安装源" -ForegroundColor Green

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
if ($powershellVersion -ge "5.0.0.0") {
    #下载各种压缩包
    Write-Host "powershell当前版本为:$powershellVersion" -ForegroundColor Green
    if ( $(Test-Path C:\temp\ninja+ccls+llvm.zip)) {
        Write-Host "c:\temp\ninja+ccls+llvm.zip 已存在无需重新下载" -ForegroundColor Yellow
    }
    else {
        Write-Host "开始下载ninja+ccls+llvm.zip" -ForegroundColor Green
        DownloadItem -url "https://qzrobot.top/index.php/s/bTdZJ6SefSGbLzd/download" -path "c:/temp" -filename "ninja+ccls+llvm.zip"
    }
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    if ($(Test-Path C:\temp\PROS.zip)) {
        Write-Host "c:\temp\PROS.zip 已存在无需重新下载" -ForegroundColor Yellow
    }
    else {
        Write-Host "开始下载PROS.zip" -ForegroundColor Green
        DownloadItem -url "https://qzrobot.top/index.php/s/PSbyBdMJ2Ti8ZT8/download" -path "c:/temp" -filename "PROS.zip"
    }
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    if ($(Test-Path C:\temp\extern_script.zip)) {
        Write-Host "c:\temp\extern_script.zip 已存在无需重新下载" -ForegroundColor Yellow
    }
    else {
        Write-Host "开始下载extern_script.zip" -ForegroundColor Green
        DownloadItem -url "https://qzrobot.top/index.php/s/txT4NbJ4XLsBNCB/download" -path "c:/temp" -filename "extern_script.zip"
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
    Write-Host "开始解压缩ninja+ccls+llvm.zip" -ForegroundColor Green
    Expand-Archive -Path C:\temp\ninja+ccls+llvm.zip -DestinationPath  C:\

    $isPros = Test-Path 'C:\Program Files\PROS'
    if ($isPros) {
        Write-Host "检测到 C:\Program Files\PROS\ 文件夹已经存在,正在删除" -ForegroundColor Yellow
        Remove-Item -path 'C:\Program Files\PROS\' -recurse -force
    }
    Write-Host "开始解压缩PROS.zip" -ForegroundColor Green
    Expand-Archive -Path C:\temp\PROS.zip -DestinationPath 'C:\Program Files\'

    Write-Host "开始解压缩extern_script.zip" -ForegroundColor Green
    Expand-Archive -Path c:\temp\extern_script.zip -DestinationPath c:\temp\ -Force
    
    #添加全局变量
    $path = [environment]::GetEnvironmentVariable('Path', 'machine') # 获取数据
    $addPath = @('C:\ccls\Release', 'C:\llvm\Release\bin', 'C:\ninja', 'C:\Program Files\PROS\toolchain\usr\bin')
    
    foreach ($it in $addPath) { 
        if ($path.split(";") -Contains $it) {
            Write-Host "路径: $it 已存在" -ForegroundColor yellow 
        }
        else {
<<<<<<< HEAD
            $path += ($it + ";")
=======
            $path += (";" + $it)
>>>>>>> e8e6aec94d6d28db9154d31dfc65e330c6ff4a2c
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
    $p = & { prosv5 --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "pros-cli没有安装或者环境变量没有添加,开始安装" -ForegroundColor yellow
        & pip.exe install https://github.com/purduesigbots/pros-cli/releases/download/3.1.4/pros_cli_v5-3.1.4-py3-none-any.whl -i https://mirrors.aliyun.com/pypi/simple/
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }

    # 安装扩展脚本
    $targetPath = "C:\Users\$env:UserName\AppData\Local\Programs\Python\Python38\Lib\site-packages\pros\common\ui\"
    $tmpFileName = 'c:\temp\__init__.py'
    Write-Host  "正在向 $targetPath 覆盖 __init__.py" -ForegroundColor Green
    Copy-Item -Path $tmpFileName -Destination $targetPath -Force

    $targetPath = "C:\Users\$env:UserName\AppData\Roaming\PROS\templates"
    $tmpFileName = 'c:\temp\kernel@3.2.1'
    Write-Host  "正在向 $targetPath 覆盖 kernel@3.2.1" -ForegroundColor Green
    Copy-Item -Path $tmpFileName -Destination $targetPath -Recurse -Force

    $targetPath = "C:\Users\$env:UserName\AppData\Roaming\PROS\templates"
    $tmpFileName = 'c:\temp\okapilib@4.0.4'
    Write-Host  "正在向 $targetPath 覆盖 okapilib@4.0.4" -ForegroundColor Green
    Copy-Item -Path $tmpFileName -Destination $targetPath -Recurse -Force

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












