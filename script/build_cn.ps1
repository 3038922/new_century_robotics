# �����ͻ�������win10ϵͳ������������
# Set-ExecutionPolicy Unrestricted # ��ִ�в�������ΪUnrestricted
Write-Host "�˰汾ʹ�������ͻ������簲װԴ" -ForegroundColor Green
# pros_toolchain����
Write-Host "��������prosToolchain·��" -ForegroundColor Green
$prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #���û������� user machine

Write-Host "��������Path·��" -ForegroundColor Green
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

Write-Host "���ڰ�װpros-cli ������"
& pip.exe install https://git.qzrobot.top/NewCenturyRobotics/new_century_robotics/src/branch/master/script/pros_cli_v5-3.1.4-py3-none-any.whl

Write-Host "���ڼ��cmake�汾"  -ForegroundColor Green
& cmake.exe --version
Write-Host "���ڼ��git�汾" -ForegroundColor Green
& git.exe --version
Write-Host "���ڼ��python�汾" -ForegroundColor Green
& python.exe --version
Write-Host "���ڼ��ninja�汾" -ForegroundColor Green
& ninja.exe --version
Write-Host "���ڼ��clang�汾" -ForegroundColor Green
& clang.exe --version
Write-Host "���ڼ��ccls�汾" -ForegroundColor Green
& ccls.exe --version
Write-Host "���ڼ��arm-none-eabi�汾" -ForegroundColor Green
& arm-none-eabi-gcc.exe --version
Write-Host "���ڼ��prosv5�汾" -ForegroundColor Green
& prosv5.exe --version


# ���ص����ļ�
function DownloadItem {
    param([string]$url, [string]$path, [string]$filename , [string]$referer)
    if ($referer.Contains("(*)")) {
        $referer = $referer -replace "\(\*\)", $url
    }
    try {
        $tmpFileName = [System.IO.Path]::GetTempFileName()
        $destFileName = [System.IO.Path]::Combine($path, $filename)
        $watch = Measure-Command {
            # �����ļ�����ʱ�ļ���
            Invoke-WebRequest -Uri $url -Method Get -Headers @{"Referer" = $referer } -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36" -TimeoutSec 120 -OutFile $tmpFileName
            # ����ʱ�ļ��ƶ���Ŀ���ļ���
            Move-Item -Path $tmpFileName -Destination $destFileName -Force
        }
        $script:succeed += 1
        $fileLength = [Math]::Ceiling((Get-Item -LiteralPath $destFileName).Length / 1024.0)
        $elapsed = [Math]::Round($watch.TotalMilliseconds)
        # ���سɹ���12.jpg - 115KB/2356ms
        Write-Host "���سɹ���$filename - $fileLength KB/$elapsed ms" -ForegroundColor Green
    }
    catch {
        Write-Error $PSItem.ToString()
    }
    finally {
        $script:completed += 1
    }
}












