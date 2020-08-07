# 新世纪机器人社win10系统环境变量配置
# pros_toolchain设置
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

# Path路径设置
$oldValue = [environment]::GetEnvironmentVariable('path', 'machine') # 获取数据
$newvalue = $oldValue + $cclsPath + $llvmPath + $ninjaPath + $prosPath #拼接字符串
[environment]::SetEnvironmentvariable("path", $newvalue, "machine") #设置环境变量 user machine