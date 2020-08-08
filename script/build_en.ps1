# 新世纪机器人社win10系统环境变量配置
# Set-ExecutionPolicy Unrestricted # 将执行策略设置为Unrestricted
Write-Host "This version uses GitHub source"  -ForegroundColor Green
# pros_toolchain设置
Write-Host "Setting prosToolChain path"  -ForegroundColor Green
$prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

Write-Host "Setting Path path"  -ForegroundColor Green
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

Write-Host "Installing pros-cli toolchain"  -ForegroundColor Green
& pip.exe install https://github.com/purduesigbots/pros-cli/releases/download/3.1.4/pros_cli_v5-3.1.4-py3-none-any.whl

Write-Host "Checking cmake version"  -ForegroundColor Green
& cmake.exe --version
Write-Host "Checking git version"  -ForegroundColor Green
& git.exe --version
Write-Host "Checking python version"  -ForegroundColor Green
& python.exe --version
Write-Host "Checking ninja version"  -ForegroundColor Green
& ninja.exe --version
Write-Host "Checking clang version"  -ForegroundColor Green
& clang.exe --version
Write-Host "Checking ccls version"  -ForegroundColor Green
& ccls.exe --version
Write-Host "Checking arm-none-eabi version"  -ForegroundColor Green
& arm-none-eabi-gcc.exe --version
Write-Host "Checking prosv5 version"  -ForegroundColor Green
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
            $flag = Test-Path $path 
            if (-not $flag) { 
                mkdir.exe $path 
            }
            Move-Item -Path $tmpFileName -Destination $destFileName -Force
        }
        $script:succeed += 1
        $fileLength = [Math]::Ceiling((Get-Item -LiteralPath $destFileName).Length / 1024.0)
        $elapsed = [Math]::Round($watch.TotalMilliseconds)
        # 下载成功！12.jpg - 115KB/2356ms
        Write-Host "Download successful $filename - $fileLength KB/$elapsed ms" -ForegroundColor Green
    }
    catch {
        Write-Error $PSItem.ToString()
    }
    finally {
        $script:completed += 1
    }
}













