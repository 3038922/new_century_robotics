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
    $args = "x -ibck -y " + $tmpPath + $name + " $ncrRoboticsPath"
    Write-Host "��ʼ��ѹ��" $name "����" $args -ForegroundColor Green
    Start-Process  $winrar $args -Wait #��ѹ��zip
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
    $client.DownloadFile('https://qzrobot.top/index.php/s/EgsQdNJzZKjrGCz/download/WinRAR.exe', $tmpPath + 'winrar.exe')
    Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    Write-Host "��ʼ��װwinrar.exe" -ForegroundColor Green
    Invoke-Expression($tmpPath + "winrar.exe /S /v /qn") 
}
# �ر������װ���
$soft =
@{name = 'python.exe'; url = 'THniMLtpTa4j3j5'; args = (' /quiet InstallAllUsers=1 PrependPath=1') },
@{name = 'code.exe'; url = 'GjQZgGKfBDw2FBW'; args = (' /verysilent /suppressmsgboxes /mergetasks=!runcode,desktopicon /ALLUSERS') },
@{name = 'git.exe'; url = 'afkWMfGGrZxZcaR'; args = (' /VERYSILENT /ALLUSERS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"') },
@{name = 'cmake.rar'; url = '6bAiQPsa497goAe'; path = ($ncrRoboticsPath + "CMake\bin") },
@{name = 'ninja.rar'; url = 'dcSrTgns6qEfDw8'; path = ($ncrRoboticsPath + "ninja") },
@{name = 'LLVM.rar'; url = '8ZE2KoQLYSEqrpa'; path = ($ncrRoboticsPath + "llvm\Release\bin") },
@{name = 'ccls.rar'; url = '36qwxFrbbpydBJS'; path = ($ncrRoboticsPath + "ccls\Release") },
@{name = 'PROS.zip'; url = 'PSbyBdMJ2Ti8ZT8'; path = ($ncrRoboticsPath + "PROS\toolchain\usr\bin") }
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
[environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", "$ncrRoboticsPath\PROS\toolchain\usr", "machine") #���û������� user machine

#��װPROS������
Write-Host "���ڼ��pros-cli�Ƿ�װ"  -ForegroundColor Green
$p = & { pros --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "pros-cliû�а�װ���߻�������û�����, ��ʼ��װ" -ForegroundColor yellow
    powershell "& pip.exe install --upgrade pros-cli -i https://mirrors.aliyun.com/pypi/simple/"
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













