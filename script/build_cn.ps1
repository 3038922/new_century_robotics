# �����ͻ�������win10ϵͳ������������

Write-Host "�˰汾ʹ�������ͻ�����ѧԺ(�й�)��װԴ" -ForegroundColor Green
# powershell�汾���
$powershellVersion = $host.Version.ToString()
Write-Host "������ʱ�ļ��� c:\temp" -ForegroundColor Green
& mkdir c:/temp
if ($powershellVersion -ge "5.0.0.0") {
    #����wirar
    $client = new-object System.Net.WebClient #�������ض���
    if ( $(Test-Path C:\temp\winrar.exe)) {
        Write-Host "c:\temp\winrar.exe �Ѵ���������������" -ForegroundColor Yellow
    }
    else {
        Write-Host "��ʼ����winrar.exe" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/EgsQdNJzZKjrGCz/download/WinRAR.exe', 'c:/temp/winrar.exe')
    }
    Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    & c:\temp\winrar.exe /S /v /qn #ִ�а�װ 
    # �ر������װ���
    Write-Host "���ڼ��cmake�Ƿ�װ"  -ForegroundColor Green
    $p = & { cmake --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "cmakeû�а�װ���߻�������û�����" -ForegroundColor Red
        Write-Host "��ʼ����cmake.exe" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/9PpsXD9yxAd85sd/download/cmake.msi', 'c:/temp/cmake.msi')
        Start-Sleep -Milliseconds 200  # �ӳ�0.2��
        Start-Process  'c:\temp\cmake.msi'-Wait #ִ�а�װ
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }
    Write-Host "���ڼ��git�Ƿ�װ"  -ForegroundColor Green
    $p = & { git --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "gitû�а�װ���߻�������û�����" -ForegroundColor Red
        Write-Host "��ʼ����git.exe" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/afkWMfGGrZxZcaR/download/Git.exe', 'c:/temp/Git.exe')
        Start-Sleep -Milliseconds 200  # �ӳ�0.2��
        Start-Process 'c:\temp\Git.exe'-Wait #ִ�а�װ
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }
    Write-Host "���ڼ��python�Ƿ�װ"  -ForegroundColor Green
    $p = & { python --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "pythonû�а�װ���߻�������û�����,���°�װ,��ע����ӻ�������" -ForegroundColor Red
        Write-Host "��ʼ����python.exe" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/THniMLtpTa4j3j5/download/python.exe', 'c:/temp/python.exe')
        Start-Sleep -Milliseconds 200  # �ӳ�0.2��
        Start-Process  'c:\temp\python.exe'-Wait #ִ�а�װ
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }
    Write-Host "���ڼ��vscode�Ƿ�װ"  -ForegroundColor Green
    $p = & { code --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "vscodeû�а�װ���߻�������û�����" -ForegroundColor Red
        Write-Host "��ʼ����vscode.exe" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/ySZieKANW5GedZM/download/VSCode.exe', 'c:/temp/vscode.exe')
        Start-Sleep -Milliseconds 200  # �ӳ�0.2��
        Start-Process 'c:\temp\vscode.exe'-Wait #ִ�а�װ
        return
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }

    #���ظ���ѹ����
    if ( $(Test-Path C:\temp\ninja+ccls+llvm.zip)) {
        Write-Host "c:\temp\ninja+ccls+llvm.zip �Ѵ���������������" -ForegroundColor Yellow
    }
    else {
        Write-Host "��ʼ����ninja+ccls+llvm.zip" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/bTdZJ6SefSGbLzd/download', 'c:/temp/ninja+ccls+llvm.zip')
    }
    Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    if ($(Test-Path C:\temp\PROS.zip)) {
        Write-Host "c:\temp\PROS.zip �Ѵ���������������" -ForegroundColor Yellow
    }
    else {
        Write-Host "��ʼ����PROS.zip" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/PSbyBdMJ2Ti8ZT8/download', 'c:/temp/PROS.zip')
    }   
    # ��ѹ��
    $isCcls = Test-Path C:\ccls
    if ($isCcls) {
        Write-Host "��⵽ c:\ccls �ļ����Ѿ�����,����ɾ��" -ForegroundColor Yellow
        Remove-Item C:\ccls\ -recurse -force
    }

    $isNinja = Test-Path C:\ninja
    if ($isNinja) {
        Write-Host "��⵽ c:\ninja �ļ����Ѿ�����,����ɾ��" -ForegroundColor Yellow
        Remove-Item C:\ninja\ -recurse -force
    }

    $isLlvm = Test-Path C:\llvm
    if ($isLlvm) {
        Write-Host "��⵽ c:\llvm �ļ����Ѿ�����,����ɾ��" -ForegroundColor Yellow
        Remove-Item C:\llvm\ -recurse -force
    }
    #������ѹ
    $cmd = 'c:\Program Files\WinRAR\winrar.exe'
    $args = 'x -ibck -y c:\temp\ninja+ccls+llvm.zip c:\'
    Write-Host "��ʼ��ѹ��ninja+ccls+llvm.zip" -ForegroundColor Green
    Start-Process  $cmd $args -Wait #��ѹ��zip

    $isPros = Test-Path 'C:\Program Files\PROS'
    if ($isPros) {
        Write-Host "��⵽ C:\Program Files\PROS\ �ļ����Ѿ�����,����ɾ��" -ForegroundColor Yellow
        Remove-Item -path 'C:\Program Files\PROS\' -recurse -force
    }
    $args = 'x  -ibck -y c:\temp\PROS.zip C:\Program Files\'
    Write-Host "��ʼ��ѹ��pros.zip" -ForegroundColor Green
    Start-Process  $cmd $args -Wait #��ѹ��zip

    #���ȫ�ֱ���
    $path = [environment]::GetEnvironmentVariable('Path', 'machine') # ��ȡ����
    $addPath = @('C:\ccls\Release', 'C:\llvm\Release\bin', 'C:\llvm\Release\lib', 'C:\ninja', 'C:\Program Files\PROS\toolchain\usr\bin')
    
    foreach ($it in $addPath) { 
        if ($path.split(";") -Contains $it) {
            Write-Host "·��: $it �Ѵ���" -ForegroundColor yellow 
        }
        else {
            $path += ($it + ";")
            Write-Host "·��: $it �����" -ForegroundColor green 
        }
    }
    [environment]::SetEnvironmentvariable("Path", $path, "machine") #���û������� user machine
    # pros_toolchain����
    Write-Host "��������prosToolchain·��" -ForegroundColor Green
    $prosToolchainPath = 'C:\Program Files\PROS\toolchain\usr'
    [environment]::SetEnvironmentvariable("PROS_TOOLCHAIN", $prosToolchainPath, "machine") #���û������� user machine

    #��װPROS������
    Write-Host "���ڼ��pros-cli�Ƿ�װ"  -ForegroundColor Green
    $p = & { pros --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "pros-cliû�а�װ���߻�������û�����,��ʼ��װ" -ForegroundColor yellow
        & pip.exe install --upgrade pros-cli -i https://mirrors.aliyun.com/pypi/simple/
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }
    Write-Host  "���ڰ�װvscode��� setting sync" -ForegroundColor Green
    & code --install-extension shan.code-settings-sync
    Write-Host "����ɾ����ʱ���ش���ļ���"  -ForegroundColor Green
    Remove-Item C:\temp\ -recurse -force
    Write-Host "��ϲ��װ�ɹ�"  -ForegroundColor Green
}
else {
    Write-Host "powershell��ǰ�汾Ϊ:$powershellVersion, ������powershell����5.x����" -ForegroundColor Red
}












