# 新世纪机器人社win10系统环境变量配置
# Set-ExecutionPolicy Unrestricted # 将执行策略设置为Unrestricted
Write-Output "This version uses GitHub source"
# pros_toolchain设置
Write-Output "Setting prosToolChain path"
$prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

Write-Output "Setting Path path"
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

Write-Output "Installing pros-cli toolchain"
& pip.exe install https://github.com/purduesigbots/pros-cli/releases/download/3.1.4/pros_cli_v5-3.1.4-py3-none-any.whl

Write-Output "Checking cmake version"
& cmake.exe --version
Write-Output "Checking git version"
& git.exe --version
Write-Output "Checking python version"
& python.exe --version
Write-Output "Checking ninja version"
& ninja.exe --version
Write-Output "Checking clang version"
& clang.exe --version
Write-Output "Checking ccls version"
& ccls.exe --version
Write-Output "Checking arm-none-eabi version"
& arm-none-eabi-gcc.exe --version
Write-Output "Checking prosv5 version"
& prosv5.exe --version















