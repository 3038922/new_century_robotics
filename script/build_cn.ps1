# �����ͻ�������win10ϵͳ������������
# Set-ExecutionPolicy Unrestricted # ��ִ�в�������ΪUnrestricted
Write-Output "�˰汾ʹ�������ͻ������簲װԴ"
# pros_toolchain����
Write-Output "��������prosToolchain·��"
$prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #���û������� user machine

Write-Output "��������Path·��"
# ccls·��
$cclsPath = ';C:\ccls\Release'
# llvm·��
$llvmPath = ';C:\llvm\Release\bin'
# ninja·��
$ninjaPath = ';C:\ninja'
# pros·��
$prosPath = ';C:\Program Files\PROS\toolchain\usr\bin'
# Path·������
$oldValue = [environment]::GetEnvironmentVariable('path', 'machine') # ��ȡ����
$newvalue = $oldValue + $cclsPath + $llvmPath + $ninjaPath + $prosPath #ƴ���ַ���
[environment]::SetEnvironmentvariable("path", $newvalue, "machine") #���û������� user machine

Write-Output "���ڰ�װpros-cli ������"
& pip.exe install https://git.qzrobot.top/NewCenturyRobotics/new_century_robotics/src/branch/master/script/pros_cli_v5-3.1.4-py3-none-any.whl

Write-Output "���ڼ��cmake�汾"
& cmake.exe --version
Write-Output "���ڼ��git�汾"
& git.exe --version
Write-Output "���ڼ��python�汾"
& python.exe --version
Write-Output "���ڼ��ninja�汾"
& ninja.exe --version
Write-Output "���ڼ��clang�汾"
& clang.exe --version
Write-Output "���ڼ��ccls�汾"
& ccls.exe --version
Write-Output "���ڼ��arm-none-eabi�汾"
& arm-none-eabi-gcc.exe --version
Write-Output "���ڼ��prosv5�汾"
& prosv5.exe --version















