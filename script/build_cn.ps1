#[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001) #设置UTF8
function installRARZIP($name, $url, $myPath) {
    #下载
    if (Test-Path($tmpPath + $name)) {
        Write-Host  $name" 已存在无需重新下载" -ForegroundColor Yellow
    }
    else {
        Write-Host "开始下载" $name -ForegroundColor Green
        $client.DownloadFile(('https://qzrobot.top/index.php/s/' + $url + '/download/' + $name), ($tmpPath + $name))
    }
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    $iArgs = "x -ibck -y " + $tmpPath + $name + " $ncrRoboticsPath"
    Write-Host "开始解压缩" $name "参数" $iArgs -ForegroundColor Green
    Start-Process  $winrar $iArgs -Wait #解压缩zip
    #添加环境变量
    $EnvironmentPath = [environment]::GetEnvironmentVariable('Path', 'machine') # 获取环境变量
    if ($EnvironmentPath.split("; ") -Contains $myPath) {
        Write-Host "环境变量:" $myPath "已存在" -ForegroundColor yellow 
    }
    else {
        $EnvironmentPath += ($myPath + "; ")
        Write-Host "环境变量:" $myPath "已添加" -ForegroundColor green 
        [environment]::SetEnvironmentvariable("Path", $EnvironmentPath, "machine") #确认设置环境变量 user machine
    }
}


# 新世纪机器人社win10系统环境变量配置
Write-Host "此版本使用新世纪机器人学院(中国)安装源" -ForegroundColor Green
Write-Host "请关闭所有类似360、腾讯管家等有可能拦截系统修改的安全软件，防止系统安装出错" -ForegroundColor Green
Write-Host "确认关闭后，请按【回车】键继续..." -ForegroundColor Green
pause
Write-Host "安装开始" -ForegroundColor Green
$ncrRoboticsPath = "c:\ncrRobotics\"
$tmpPath = $ncrRoboticsPath + "temp\"
if (!(Test-Path -Path $ncrRoboticsPath )) {
    Write-Host "创建ncrRobotics文件夹 $ncrRoboticsPath" -ForegroundColor Green
    & mkdir $ncrRoboticsPath 
}
if (!(Test-Path -Path $tmpPath)) {
    Write-Host "创建临时文件夹 $tmpPath" -ForegroundColor Green
    & mkdir $tmpPath
}
#下载wirar
$winrar = "C:\Program Files\WinRAR\winrar.exe"
$client = new-object System.Net.WebClient #创建下载对象
if (Test-Path($winrar)) {
    Write-Host "winrar.exe 已存在无需重新下载" -ForegroundColor Green
}
else {
    Write-Host "开始下载winrar.exe" -ForegroundColor Green
    $client.DownloadFile('https://qzrobot.top/index.php/s/RtFjoSR5Z2Skrnq/download/WinRAR.exe', $tmpPath + 'winrar.exe')
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    Write-Host "开始安装winrar.exe" -ForegroundColor Green
    Invoke-Expression($tmpPath + "winrar.exe /S /v /qn") 
}
# 必备软件安装检查
$soft =
@{name = 'python.exe'; url = 'iGrYQCqotTWZn6e'; args = (' /quiet InstallAllUsers=1 PrependPath=1 Shortcuts=1 Include_pip=1') },
@{name = 'code.exe'; url = 'KBZt4TjzGGBbkeH'; args = (' /verysilent /suppressmsgboxes /ALLUSERS /mergetasks=!runcode,desktopicon,quicklaunchicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath') },
@{name = 'git.exe'; url = 'aHPm5H9622DyLRg'; args = (' /VERYSILENT /ALLUSERS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"') },
@{name = 'cmake.rar'; url = 't79cLNq6CifyfGS'; path = ($ncrRoboticsPath + "CMake\bin") },
@{name = 'ninja.rar'; url = 'Nd2P2Rnx9c6Gnmo'; path = ($ncrRoboticsPath + "ninja") },
@{name = 'LLVM.rar'; url = 'T8KFKR6xHeDy9kj'; path = ($ncrRoboticsPath + "llvm\Release\bin") },
@{name = 'ccls.rar'; url = 'KYAc4zpC6r3xZ7z'; path = ($ncrRoboticsPath + "ccls\Release") },
@{name = 'PROS.zip'; url = 'DsYXwWWa2asN5Ar'; path = ($ncrRoboticsPath + "PROS\toolchain\usr\bin") }
foreach ($it in $soft) {
    $name = $it.name.Substring(0, $it.name.IndexOf('.')) 
    $suffix = $it.name.Substring($it.name.IndexOf('.') + 1) #后缀名
    if ($suffix -eq "exe") {
        Write-Host "正在检查 $name 是否安装"  -ForegroundColor Green
        $p = Invoke-Expression($name + " --version") 2>&1
        if ([String]::IsNullOrEmpty($p)) {
            Write-Host $it.name "没有安装或者环境变量没有添加"-ForegroundColor Red
            Write-Host "开始下载" $it.name -ForegroundColor Yellow
            $client.DownloadFile(('https://qzrobot.top/index.php/s/' + $it.url + '/download/' + $it.name), ($tmpPath + $it.name))
            Start-Sleep -Milliseconds 200  # 延迟0.2秒
            Write-Host '开始安装' $it.name -ForegroundColor Green
            Start-Process ($tmpPath + $it.name ) $it.args -Wait #执行安装
        }
        else {
            Write-Host $p -ForegroundColor Green
        }
    }
    else {
        if (Test-Path ($ncrRoboticsPath + $name)) {
            if ((Read-Host ("是否更新" + $it.name + "?[Y/N]")) -eq 'y') {
                Write-Host "检测到 $name 文件夹已经存在, 正在删除" -ForegroundColor Yellow
                Remove-Item ($ncrRoboticsPath + $name) -recurse -force
                installRARZIP -name $it.name -url $it.url -myPath $it.path 
            }
        }
        else {
            installRARZIP -name $it.name -url $it.url -myPath $it.path 
        }
    }
}
# pros_toolchain设置
Write-Host "正在设置prosToolchain路径" -ForegroundColor Green
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $ncrRoboticsPath + "PROS\toolchain\usr", "machine") #设置环境变量 user machine

#安装PROS工具链
Write-Host "正在检查pros-cli是否安装"  -ForegroundColor Green
$p = & { pros --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "pros-cli没有安装或者环境变量没有添加, 开始安装" -ForegroundColor yellow
    powershell "& C:\Users\$env:UserName\AppData\Local\Programs\Python\Python38\Scripts\pip.exe install --upgrade pros-cli -i https://mirrors.aliyun.com/pypi/simple/"
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host  "正在安装vscode插件 setting sync" -ForegroundColor Green
powershell "& code --install-extension shan.code-settings-sync" 

#GIT设置
$gitName = Invoke-Expression("git config --global user.name") 2>&1
if ([String]::IsNullOrEmpty($gitName)) {
    $gitName = (Read-Host "请输入您的git用户名如:dog,pig,mouse") 
    Invoke-Expression("git config --global user.name  $gitName")
    Write-Host "已设置为:$gitName" -ForegroundColor Green
}
else {
    Write-Host "git用户名已配置为:" $(Invoke-Expression("git config --global user.name")) -ForegroundColor green
}

$gitEmail = Invoke-Expression("git config --global user.email") 2>&1
if ([String]::IsNullOrEmpty($gitEmail)) {
    $gitEmail = (Read-Host "请输入您的git Email 如:8888@qq.com") 
    Invoke-Expression("git config --global user.email  $gitEmail")
    Write-Host "已设置为:$gitEmail" -ForegroundColor Green
}
else {
    Write-Host "git email已配置为:" $(Invoke-Expression("git config --global user.email")) -ForegroundColor green
}

Write-Host "正在删除临时下载存放文件夹"  -ForegroundColor Green
# Remove-Item $tmpPath\ -recurse -force
Write-Host "恭喜安装成功"  -ForegroundColor Green













