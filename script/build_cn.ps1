# 新世纪机器人社win10系统环境变量配置
# Set-ExecutionPolicy Unrestricted # 将执行策略设置为Unrestricted
Write-Host "此版本使用新世纪机器人社安装源" -ForegroundColor Green
# pros_toolchain设置
Write-Host "正在设置prosToolchain路径" -ForegroundColor Green
$prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

Write-Host "正在设置Path路径" -ForegroundColor Green
# ccls路径
$cclsPath = ';C:\ccls\Release'
# llvm路径
$llvmPath = ';C:\llvm\Release\bin'
# ninja路径
$ninjaPath = ';C:\ninja'
# pros路径
$prosPath = ';C:\Program Files\PROS\toolchain\usr\bin'
# Path路径设置
$oldValue = [environment]::GetEnvironmentVariable('path', 'machine') # 获取数据
$newvalue = $oldValue + $cclsPath + $llvmPath + $ninjaPath + $prosPath #拼接字符串
[environment]::SetEnvironmentvariable("path", $newvalue, "machine") #设置环境变量 user machine

Write-Host "正在安装pros-cli 工具链"
& pip.exe install https://git.qzrobot.top/NewCenturyRobotics/new_century_robotics/src/branch/master/script/pros_cli_v5-3.1.4-py3-none-any.whl

Write-Host "正在检查cmake版本"  -ForegroundColor Green
& cmake.exe --version
Write-Host "正在检查git版本" -ForegroundColor Green
& git.exe --version
Write-Host "正在检查python版本" -ForegroundColor Green
& python.exe --version
Write-Host "正在检查ninja版本" -ForegroundColor Green
& ninja.exe --version
Write-Host "正在检查clang版本" -ForegroundColor Green
& clang.exe --version
Write-Host "正在检查ccls版本" -ForegroundColor Green
& ccls.exe --version
Write-Host "正在检查arm-none-eabi版本" -ForegroundColor Green
& arm-none-eabi-gcc.exe --version
Write-Host "正在检查prosv5版本" -ForegroundColor Green
& prosv5.exe --version


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












