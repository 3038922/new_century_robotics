# 新世纪机器人社win10系统环境变量配置

Write-Host "此版本使用新世纪机器人学院(中国)安装源" -ForegroundColor Green
# powershell版本检查
$powershellVersion = $host.Version.ToString()
$ncrRoboticsPath = "c:\ncrRobotics\"
$tmpPath = $ncrRoboticsPath + "temp\"
if (!(Test-Path -Path $ncrRoboticsPath )) {
    Write-Host "创建ncrRobotics文件夹 $path" -ForegroundColor Green
    & mkdir $ncrRoboticsPath 
}
if (!(Test-Path -Path $tmpPath)) {
    Write-Host "创建临时文件夹 $tmpPath" -ForegroundColor Green
    & mkdir $tmpPath
}
if ($powershellVersion -ge "5.0.0.0") {
    #下载wirar
    $client = new-object System.Net.WebClient #创建下载对象
    if (Test-Path("C:\Program Files\WinRAR\WinRAR.exe")) {
        Write-Host "winrar.exe 已存在无需重新下载" -ForegroundColor Green
    }
    else {
        Write-Host "开始下载winrar.exe" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/EgsQdNJzZKjrGCz/download/WinRAR.exe', $tmpPath + 'winrar.exe')
        Start-Sleep -Milliseconds 200  # 延迟0.2秒
        Write-Host "开始安装winrar.exe" -ForegroundColor Green
        Invoke-Expression($tmpPath + "winrar.exe /S /v /qn") 
    }
    # 必备软件安装检查
    $soft =
    @{name = 'cmake.msi'; url = '9PpsXD9yxAd85sd' },
    @{name = 'code.exe'; url = 'GjQZgGKfBDw2FBW' },
    @{name = 'git.exe'; url = 'afkWMfGGrZxZcaR' },
    @{name = 'python.exe'; url = 'THniMLtpTa4j3j5' }
    foreach ($it in $soft) {
        $name = $it.name.Substring(0, $it.name.IndexOf('.')) 
        Write-Host "正在检查 $name 是否安装"  -ForegroundColor Green
        $p = Invoke-Expression($name + " --version") 2>&1
        if ([String]::IsNullOrEmpty($p)) {
            Write-Host $it.name "没有安装或者环境变量没有添加"-ForegroundColor Red
            Write-Host "开始下载" $it.name -ForegroundColor Yellow
            $newUrl = 'https://qzrobot.top/index.php/s/' + $it.url + '/download/' + $it.name
            $newPath = $tmpPath + $it.name
            Write-Host  $newUrl  $newPath  -ForegroundColor Green
            $client.DownloadFile($newUrl, $newPath)
            Start-Sleep -Milliseconds 200  # 延迟0.2秒
            Write-Host '开始安装' $it.name -ForegroundColor Green
            Start-Process $newPath -Wait #执行安装
        }
        else {
            Write-Host $p -ForegroundColor Green
        }
    }
    #下载各种压缩包
    
    if (Test-Path ($ncrRoboticsPath + "ccls")) {
        Write-Host "检测到 ccls 文件夹已经存在, 正在删除" -ForegroundColor Yellow
        Remove-Item ($ncrRoboticsPath + "ccls") -recurse -force
    }
    
    if (Test-Path ($ncrRoboticsPath + "ninja")) {
        Write-Host "检测到 ninja 文件夹已经存在, 正在删除" -ForegroundColor Yellow
        Remove-Item  ($ncrRoboticsPath + "ninja") -recurse -force
    }
    if (Test-Path ($ncrRoboticsPath + "llvm")) {
        Write-Host "检测到 llvm 文件夹已经存在, 正在删除" -ForegroundColor Yellow
        Remove-Item  ($ncrRoboticsPath + "llvm") -recurse -force
    }

    $zip =
    @{name = 'ninja+ccls+llvm.zip'; url = 'bTdZJ6SefSGbLzd' },
    @{name = 'PROS.zip'; url = 'PSbyBdMJ2Ti8ZT8' }
    $cmd = "$ncrRoboticsPath\WinRAR\winrar.exe"
    foreach ($it in $zip) {
        #下载
        if (Test-Path($tmpPath + $it.name)) {
            Write-Host  $it.name" 已存在无需重新下载" -ForegroundColor Yellow
        }
        else {
            Write-Host "开始下载" $it.name -ForegroundColor Green
            $newUrl = 'https://qzrobot.top/index.php/s/' + $it.url + '/download/' + $it.name
            $newPath = $tmpPath + $it.name
            Write-Host  $newUrl  $newPath  -ForegroundColor Green
            $client.DownloadFile($newUrl, $newPath)
        }
        Start-Sleep -Milliseconds 200  # 延迟0.2秒
        $args = "x -ibck -y " + $tmpPath + $it.name + " $ncrRoboticsPath"
        Write-Host "开始解压缩" $it.name "参数" $args -ForegroundColor Green
        Start-Process  $cmd $args -Wait #解压缩zip
    }
    #添加全局变量
    $path = [environment]::GetEnvironmentVariable('Path', 'machine') # 获取数据
    $addPath = ($ncrRoboticsPath + "ccls\Release"), ( $ncrRoboticsPath + "llvm\Release\bin"), ($ncrRoboticsPath + "llvm\Release\lib"), ( $ncrRoboticsPath + "ninja"), ($ncrRoboticsPath + "PROS\toolchain\usr\bin")
    
    foreach ($it in $addPath) { 
        if ($path.split("; ") -Contains $it) {
            Write-Host "环境变量: $it 已存在" -ForegroundColor yellow 
        }
        else {
            $path += ($it + "; ")
            Write-Host "环境变量: $it 已添加" -ForegroundColor green 
        }
    }
    [environment]::SetEnvironmentvariable("Path", $path, "machine") #设置环境变量 user machine
    # pros_toolchain设置
    Write-Host "正在设置prosToolchain路径" -ForegroundColor Green
    $prosToolchainPath = "$ncrRoboticsPath\PROS\toolchain\usr"
    [environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

    #安装PROS工具链
    Write-Host "正在检查pros-cli是否安装"  -ForegroundColor Green
    $p = & { pros --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "pros-cli没有安装或者环境变量没有添加, 开始安装" -ForegroundColor yellow
        & pip.exe install --upgrade pros-cli -i https://mirrors.aliyun.com/pypi/simple/
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }
    Write-Host  "正在安装vscode插件 setting sync" -ForegroundColor Green
    & code --install-extension shan.code-settings-sync
    Write-Host "正在删除临时下载存放文件夹"  -ForegroundColor Green
    Remove-Item $tmpPath\ -recurse -force
    Write-Host "恭喜安装成功"  -ForegroundColor Green
}
else {
    Write-Host "powershell当前版本为:$powershellVersion, 请升级powershell至于5.x以上" -ForegroundColor Red
}












