# 新世纪机器人社win10系统环境变量配置

Write-Host "This version uses GitHub source" -ForegroundColor Green

# 必备软件安装检查
Write-Host "Checking cmake is installed"  -ForegroundColor Green
$p = & { cmake --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "cmake No installation or environment variables added" -ForegroundColor Red
    Write-Host "This program is about to end. Please try again after installation" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "Checking git is installed"  -ForegroundColor Green
$p = & { git --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "git No installation or environment variables added" -ForegroundColor Red
    Write-Host "This program is about to end. Please try again after installation" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "Checking python is installed"  -ForegroundColor Green
$p = & { python --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "python No installation or environment variables added" -ForegroundColor Red
    Write-Host "This program is about to end. Please try again after installation" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "Checking vscode is installed"  -ForegroundColor Green
$p = & { code --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "vscode No installation or environment variables added" -ForegroundColor Red
    Write-Host "This program is about to end. Please try again after installation" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}

# powershell版本检查
$powershellVersion = $host.Version.ToString()
Write-Host "Create temporary folder c:\temp" -ForegroundColor Green
& mkdir c:/temp
if ($powershellVersion -ge "5.0.0.0") {
    #下载各种压缩包
    Write-Host "powershell version:$powershellVersion" -ForegroundColor Green
    if ( $(Test-Path C:\temp\ninja+ccls+llvm.zip)) {
        Write-Host "c:\temp\ninja+ccls+llvm.zip Already exists, no need to download again" -ForegroundColor Yellow
    }
    else {
        Write-Host "Downloading ninja+ccls+llvm.zip" -ForegroundColor Green
        $client.DownloadFile('https://github.com/3038922/new_century_robotics/releases/download/v1.0/ninja+ccls+llvm.zip', 'c:/temp/ninja+ccls+llvm.zip')
    }
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    if ($(Test-Path C:\temp\PROS.zip)) {
        Write-Host "c:\temp\PROS.zip Already exists, no need to download again" -ForegroundColor Yellow
    }
    else {
        Write-Host "Downloading PROS.zip" -ForegroundColor Green
        $client.DownloadFile('https://github.com/3038922/new_century_robotics/releases/download/v1.0/PROS.zip', 'c:/temp/PROS.zip')
    }
 
    # 解压缩
    $isCcls = Test-Path C:\ccls
    if ($isCcls) {
        Write-Host "Detected c:\ccls Folder already exists, deleting" -ForegroundColor Yellow
        Remove-Item C:\ccls\ -recurse -force
    }

    $isNinja = Test-Path C:\ninja
    if ($isNinja) {
        Write-Host "Detected c:\ninja Folder already exists, deleting" -ForegroundColor Yellow
        Remove-Item C:\ninja\ -recurse -force
    }

    $isLlvm = Test-Path C:\llvm
    if ($isLlvm) {
        Write-Host "Detected c:\llvm Folder already exists, deleting" -ForegroundColor Yellow
        Remove-Item C:\llvm\ -recurse -force
    }
    Write-Host "Start decompressing ninja+ccls+llvm.zip" -ForegroundColor Green
    Expand-Archive -Path C:\temp\ninja+ccls+llvm.zip -DestinationPath  C:\

    $isPros = Test-Path 'C:\Program Files\PROS'
    if ($isPros) {
        Write-Host "Detected C:\Program Files\PROS\ Folder already exists, deleting" -ForegroundColor Yellow
        Remove-Item -path 'C:\Program Files\PROS\' -recurse -force
    }
    Write-Host "Start decompressing PROS.zip" -ForegroundColor Green
    Expand-Archive -Path C:\temp\PROS.zip -DestinationPath 'C:\Program Files\'

    
    #添加全局变量
    $path = [environment]::GetEnvironmentVariable('Path', 'machine') # 获取数据
    $addPath = @('C:\ccls\Release', 'C:\llvm\Release\bin', 'C:\llvm\Release\lib', 'C:\ninja', 'C:\Program Files\PROS\toolchain\usr\bin')
    
    foreach ($it in $addPath) { 
        if ($path.split(";") -Contains $it) {
            Write-Host "Path: $it Already exists" -ForegroundColor yellow 
        }
        else {
            $path += (";" + $it )
            Write-Host "Path: $it Added" -ForegroundColor green 
        }
    }
    [environment]::SetEnvironmentvariable("Path", $path, "machine") #设置环境变量 user machine
    # pros_toolchain设置
    Write-Host "Setting up prosToolchainPath" -ForegroundColor Green
    $prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
    [environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

    #安装PROS工具链
    Write-Host "Checking pros-cli is installed"  -ForegroundColor Green
    $p = & { prosv5 --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "pros-cli No installation or environment variables added,Installing" -ForegroundColor yellow
        & pip.exe install --upgrade pros-cli
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }

    Write-Host  "Installing vscode plug-in setting sync" -ForegroundColor Green
    & code --install-extension shan.code-settings-sync

    # Write-Host "Checking ninja is installed"  -ForegroundColor Green
    # $p = & { ninja --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "ninja No installation or environment variables added" -ForegroundColor Red
    #     Write-Host "Please release issue" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "Checking clang is installed"  -ForegroundColor Green
    # $p = & { clang --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "clang No installation or environment variables added" -ForegroundColor Red
    #     Write-Host "Please release issue" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "Checking ccls is installed"  -ForegroundColor Green
    # $p = & { ccls --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "ccls No installation or environment variables added" -ForegroundColor Red
    #     Write-Host "Please release issue" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "Checking arm-none-eabi is installed"  -ForegroundColor Green
    # $p = & { arm-none-eabi-gcc --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "arm-none-eabi No installation or environment variables added" -ForegroundColor Red
    #     Write-Host "Please release issue" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "Checking pros-cli is installed"  -ForegroundColor Green
    # $p = & { prosv5 --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "pros-cli No installation or environment variables added" -ForegroundColor Red
    #     Write-Host "Please release issue" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    Write-Host "Deleting temporary download drop folder"  -ForegroundColor Green
    Remove-Item C:\temp\ -recurse -force
    Write-Host "Congratulations on the successful installation"  -ForegroundColor Green
}
else {
    Write-Host "powershell version:$powershellVersion, Please upgrade PowerShell to 5. X and above" -ForegroundColor Red
}












