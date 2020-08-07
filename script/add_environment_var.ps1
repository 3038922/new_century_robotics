# 新世纪机器人社win10系统环境变量配置
# pros_toolchain设置

# echo "正在设置prosToolchain路径"

$prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #设置环境变量 user machine

# ccls路径
$cclsPath = ';C:\ccls\Release'
# llvm路径
$llvmPath = ';C:\llvm\Release\bin'
# ninja路径
$ninjaPath = ';C:\ninja'
# pros路径
$prosPath = ';c:\Program Files\PROS\toolchain\usr\bin'

# echo '正在设置Path路径'
# Path路径设置
$oldValue = [environment]::GetEnvironmentVariable('path', 'machine') # 获取数据
$newvalue = $oldValue + $cclsPath + $llvmPath + $ninjaPath + $prosPath #拼接字符串
[environment]::SetEnvironmentvariable("path", $newvalue, "machine") #设置环境变量 user machine

start
"pip install https://git.qzrobot.top/NewCenturyRobotics/new_century_robotics/src/branch/master/script/pros_cli_v5-3.1.4-py3-none-any.whl"
















