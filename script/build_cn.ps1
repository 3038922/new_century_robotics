# 新世纪机器人社win10系统环境变量配置
# Set-ExecutionPolicy Unrestricted # 将执行策略设置为Unrestricted
Write-Output "此版本使用新世纪机器人社安装源"
# pros_toolchain设置
Write-Output "正在设置prosToolchain路径"
$prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

Write-Output "正在设置Path路径"
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

Write-Output "正在安装pros-cli 工具链"
& pip.exe install https://git.qzrobot.top/NewCenturyRobotics/new_century_robotics/src/branch/master/script/pros_cli_v5-3.1.4-py3-none-any.whl

Write-Output "正在检查cmake版本"
& cmake.exe --version
Write-Output "正在检查git版本"
& git.exe --version
Write-Output "正在检查python版本"
& python.exe --version
Write-Output "正在检查ninja版本"
& ninja.exe --version
Write-Output "正在检查clang版本"
& clang.exe --version
Write-Output "正在检查ccls版本"
& ccls.exe --version
Write-Output "正在检查arm-none-eabi版本"
& arm-none-eabi-gcc.exe --version
Write-Output "正在检查prosv5版本"
& prosv5.exe --version















