#[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001) #����UTF8
function installRARZIP($name, $url, $myPath) {
    #����
    if (Test-Path($tmpPath + $name)) {
        Write-Host  $name" �Ѵ���������������" -ForegroundColor Yellow
    }
    else {
        Write-Host "��ʼ����" $name -ForegroundColor Green
        $client.DownloadFile(('https://qzrobot.top/index.php/s/' + $url + '/download/' + $name), ($tmpPath + $name))
    }
    Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    $iArgs = "x -ibck -y " + $tmpPath + $name + " $ncrRoboticsPath"
    Write-Host "��ʼ��ѹ��" $name "����" $iArgs -ForegroundColor Green
    Start-Process  $winrar $iArgs -Wait #��ѹ��zip
    #��ӻ�������
    $EnvironmentPath = [environment]::GetEnvironmentVariable('Path', 'machine') # ��ȡ��������
    if ($EnvironmentPath.split("; ") -Contains $myPath) {
        Write-Host "��������:" $myPath "�Ѵ���" -ForegroundColor yellow 
    }
    else {
        $EnvironmentPath += ($myPath + "; ")
        Write-Host "��������:" $myPath "�����" -ForegroundColor green 
        [environment]::SetEnvironmentvariable("Path", $EnvironmentPath, "machine") #ȷ�����û������� user machine
    }
}


# �����ͻ�������win10ϵͳ������������
Write-Host "�˰汾ʹ�������ͻ�����ѧԺ(�й�)��װԴ" -ForegroundColor Green
Write-Host "��ر���������360����Ѷ�ܼҵ��п�������ϵͳ�޸ĵİ�ȫ�������ֹϵͳ��װ����" -ForegroundColor Green
Write-Host "ȷ�Ϲرպ��밴���س���������..." -ForegroundColor Green
pause
Write-Host "��װ��ʼ" -ForegroundColor Green
$ncrRoboticsPath = "c:\ncrRobotics\"
$tmpPath = $ncrRoboticsPath + "temp\"
if (!(Test-Path -Path $ncrRoboticsPath )) {
    Write-Host "����ncrRobotics�ļ��� $ncrRoboticsPath" -ForegroundColor Green
    & mkdir $ncrRoboticsPath 
}
if (!(Test-Path -Path $tmpPath)) {
    Write-Host "������ʱ�ļ��� $tmpPath" -ForegroundColor Green
    & mkdir $tmpPath
}
#����wirar
$winrar = "C:\Program Files\WinRAR\winrar.exe"
$client = new-object System.Net.WebClient #�������ض���
if (Test-Path($winrar)) {
    Write-Host "winrar.exe �Ѵ���������������" -ForegroundColor Green
}
else {
    Write-Host "��ʼ����winrar.exe" -ForegroundColor Green
    $client.DownloadFile('https://qzrobot.top/index.php/s/RtFjoSR5Z2Skrnq/download/WinRAR.exe', $tmpPath + 'winrar.exe')
    Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    Write-Host "��ʼ��װwinrar.exe" -ForegroundColor Green
    Invoke-Expression($tmpPath + "winrar.exe /S /v /qn") 
}
# �ر������װ���
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
    $suffix = $it.name.Substring($it.name.IndexOf('.') + 1) #��׺��
    if ($suffix -eq "exe") {
        Write-Host "���ڼ�� $name �Ƿ�װ"  -ForegroundColor Green
        $p = Invoke-Expression($name + " --version") 2>&1
        if ([String]::IsNullOrEmpty($p)) {
            Write-Host $it.name "û�а�װ���߻�������û�����"-ForegroundColor Red
            Write-Host "��ʼ����" $it.name -ForegroundColor Yellow
            $client.DownloadFile(('https://qzrobot.top/index.php/s/' + $it.url + '/download/' + $it.name), ($tmpPath + $it.name))
            Start-Sleep -Milliseconds 200  # �ӳ�0.2��
            Write-Host '��ʼ��װ' $it.name -ForegroundColor Green
            Start-Process ($tmpPath + $it.name ) $it.args -Wait #ִ�а�װ
        }
        else {
            Write-Host $p -ForegroundColor Green
        }
    }
    else {
        if (Test-Path ($ncrRoboticsPath + $name)) {
            if ((Read-Host ("�Ƿ����" + $it.name + "?[Y/N]")) -eq 'y') {
                Write-Host "��⵽ $name �ļ����Ѿ�����, ����ɾ��" -ForegroundColor Yellow
                Remove-Item ($ncrRoboticsPath + $name) -recurse -force
                installRARZIP -name $it.name -url $it.url -myPath $it.path 
            }
        }
        else {
            installRARZIP -name $it.name -url $it.url -myPath $it.path 
        }
    }
}
# pros_toolchain����
Write-Host "��������prosToolchain·��" -ForegroundColor Green
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $ncrRoboticsPath + "PROS\toolchain\usr", "machine") #���û������� user machine

#��װPROS������
Write-Host "���ڼ��pros-cli�Ƿ�װ"  -ForegroundColor Green
$p = & { pros --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "pros-cliû�а�װ���߻�������û�����, ��ʼ��װ" -ForegroundColor yellow
    powershell "& C:\Users\$env:UserName\AppData\Local\Programs\Python\Python38\Scripts\pip.exe install --upgrade pros-cli -i https://mirrors.aliyun.com/pypi/simple/"
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host  "���ڰ�װvscode��� setting sync" -ForegroundColor Green
powershell "& code --install-extension shan.code-settings-sync" 

#GIT����
$gitName = Invoke-Expression("git config --global user.name") 2>&1
if ([String]::IsNullOrEmpty($gitName)) {
    $gitName = (Read-Host "����������git�û�����:dog,pig,mouse") 
    Invoke-Expression("git config --global user.name  $gitName")
    Write-Host "������Ϊ:$gitName" -ForegroundColor Green
}
else {
    Write-Host "git�û���������Ϊ:" $(Invoke-Expression("git config --global user.name")) -ForegroundColor green
}

$gitEmail = Invoke-Expression("git config --global user.email") 2>&1
if ([String]::IsNullOrEmpty($gitEmail)) {
    $gitEmail = (Read-Host "����������git Email ��:8888@qq.com") 
    Invoke-Expression("git config --global user.email  $gitEmail")
    Write-Host "������Ϊ:$gitEmail" -ForegroundColor Green
}
else {
    Write-Host "git email������Ϊ:" $(Invoke-Expression("git config --global user.email")) -ForegroundColor green
}

Write-Host "����ɾ����ʱ���ش���ļ���"  -ForegroundColor Green
# Remove-Item $tmpPath\ -recurse -force
Write-Host "��ϲ��װ�ɹ�"  -ForegroundColor Green













