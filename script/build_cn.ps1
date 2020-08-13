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
            $flag = Test-Path $path 
            if (-not $flag) { 
                & mkdir $path 
            }
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

# �����ͻ�������win10ϵͳ������������

Write-Host "�˰汾ʹ�������ͻ�������(�й�)��װԴ" -ForegroundColor Green

# �ر������װ���
Write-Host "���ڼ��cmake�Ƿ�װ"  -ForegroundColor Green
$p = & { cmake --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "cmakeû�а�װ���߻�������û�����" -ForegroundColor Red
    Write-Host "�����򼴽�����,�밲װ���ٴγ���" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "���ڼ��git�Ƿ�װ"  -ForegroundColor Green
$p = & { git --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "gitû�а�װ���߻�������û�����" -ForegroundColor Red
    Write-Host "�����򼴽�����,�밲װ���ٴγ���" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "���ڼ��python�Ƿ�װ"  -ForegroundColor Green
$p = & { python --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "pythonû�а�װ���߻�������û�����" -ForegroundColor Red
    Write-Host "�����򼴽�����,�밲װ���ٴγ���" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}
Write-Host "���ڼ��vscode�Ƿ�װ"  -ForegroundColor Green
$p = & { code --version } 2>&1
if ($p -is [System.Management.Automation.ErrorRecord]) {
    Write-Host "vscodeû�а�װ���߻�������û�����" -ForegroundColor Red
    Write-Host "�����򼴽�����,�밲װ���ٴγ���" -ForegroundColor Red
    return
}
else {
    Write-Host  $p -ForegroundColor Green
}

# powershell�汾���
$powershellVersion = $host.Version.ToString()
if ($powershellVersion -ge "5.0.0.0") {
    #���ظ���ѹ����
    Write-Host "powershell��ǰ�汾Ϊ:$powershellVersion" -ForegroundColor Green
    if ( $(Test-Path C:\temp\ninja+ccls+llvm.zip)) {
        Write-Host "c:\temp\ninja+ccls+llvm.zip �Ѵ���������������" -ForegroundColor Yellow
    }
    else {
        Write-Host "��ʼ����ninja+ccls+llvm.zip" -ForegroundColor Green
        DownloadItem -url "https://qzrobot.top/index.php/s/bTdZJ6SefSGbLzd/download" -path "c:/temp" -filename "ninja+ccls+llvm.zip"
    }
    Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    if ($(Test-Path C:\temp\PROS.zip)) {
        Write-Host "c:\temp\PROS.zip �Ѵ���������������" -ForegroundColor Yellow
    }
    else {
        Write-Host "��ʼ����PROS.zip" -ForegroundColor Green
        DownloadItem -url "https://qzrobot.top/index.php/s/PSbyBdMJ2Ti8ZT8/download" -path "c:/temp" -filename "PROS.zip"
    }
    Start-Sleep -Milliseconds 200  # �ӳ�0.2��
    if ($(Test-Path C:\temp\extern_script.zip)) {
        Write-Host "c:\temp\extern_script.zip �Ѵ���������������" -ForegroundColor Yellow
    }
    else {
        Write-Host "��ʼ����extern_script.zip" -ForegroundColor Green
        DownloadItem -url "https://qzrobot.top/index.php/s/txT4NbJ4XLsBNCB/download" -path "c:/temp" -filename "extern_script.zip"
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
    Write-Host "��ʼ��ѹ��ninja+ccls+llvm.zip" -ForegroundColor Green
    Expand-Archive -Path C:\temp\ninja+ccls+llvm.zip -DestinationPath  C:\

    $isPros = Test-Path 'C:\Program Files\PROS'
    if ($isPros) {
        Write-Host "��⵽ C:\Program Files\PROS\ �ļ����Ѿ�����,����ɾ��" -ForegroundColor Yellow
        Remove-Item -path 'C:\Program Files\PROS\' -recurse -force
    }
    Write-Host "��ʼ��ѹ��PROS.zip" -ForegroundColor Green
    Expand-Archive -Path C:\temp\PROS.zip -DestinationPath 'C:\Program Files\'

    Write-Host "��ʼ��ѹ��extern_script.zip" -ForegroundColor Green
    Expand-Archive -Path c:\temp\extern_script.zip -DestinationPath c:\temp\ -Force
    
    #���ȫ�ֱ���
    $path = [environment]::GetEnvironmentVariable('Path', 'machine') # ��ȡ����
    $addPath = @('C:\ccls\Release', 'C:\llvm\Release\bin', 'C:\ninja', 'C:\Program Files\PROS\toolchain\usr\bin')
    
    foreach ($it in $addPath) { 
        if ($path.split(";") -Contains $it) {
            Write-Host "·��: $it �Ѵ���" -ForegroundColor yellow 
        }
        else {
<<<<<<< HEAD
            $path += ($it + ";")
=======
            $path += (";" + $it)
>>>>>>> e8e6aec94d6d28db9154d31dfc65e330c6ff4a2c
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
    $p = & { prosv5 --version } 2>&1
    if ($p -is [System.Management.Automation.ErrorRecord]) {
        Write-Host "pros-cliû�а�װ���߻�������û�����,��ʼ��װ" -ForegroundColor yellow
        & pip.exe install https://github.com/purduesigbots/pros-cli/releases/download/3.1.4/pros_cli_v5-3.1.4-py3-none-any.whl -i https://mirrors.aliyun.com/pypi/simple/
    }
    else {
        Write-Host  $p -ForegroundColor Green
    }

    # ��װ��չ�ű�
    $targetPath = "C:\Users\$env:UserName\AppData\Local\Programs\Python\Python38\Lib\site-packages\pros\common\ui\"
    $tmpFileName = 'c:\temp\__init__.py'
    Write-Host  "������ $targetPath ���� __init__.py" -ForegroundColor Green
    Copy-Item -Path $tmpFileName -Destination $targetPath -Force

    $targetPath = "C:\Users\$env:UserName\AppData\Roaming\PROS\templates"
    $tmpFileName = 'c:\temp\kernel@3.2.1'
    Write-Host  "������ $targetPath ���� kernel@3.2.1" -ForegroundColor Green
    Copy-Item -Path $tmpFileName -Destination $targetPath -Recurse -Force

    $targetPath = "C:\Users\$env:UserName\AppData\Roaming\PROS\templates"
    $tmpFileName = 'c:\temp\okapilib@4.0.4'
    Write-Host  "������ $targetPath ���� okapilib@4.0.4" -ForegroundColor Green
    Copy-Item -Path $tmpFileName -Destination $targetPath -Recurse -Force

    Write-Host  "���ڰ�װvscode��� setting sync" -ForegroundColor Green
    & code --install-extension shan.code-settings-sync

    # Write-Host "���ڼ��ninja�Ƿ�װ"  -ForegroundColor Green
    # $p = & { ninja --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "ninjaû�а�װ���߻�������û�����" -ForegroundColor Red
    #     Write-Host "����ϵ����ʦ" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "���ڼ��clang�Ƿ�װ"  -ForegroundColor Green
    # $p = & { clang --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "clangû�а�װ���߻�������û�����" -ForegroundColor Red
    #     Write-Host "����ϵ����ʦ" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "���ڼ��ccls�Ƿ�װ"  -ForegroundColor Green
    # $p = & { ccls --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "cclsû�а�װ���߻�������û�����" -ForegroundColor Red
    #     Write-Host "����ϵ����ʦ" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "���ڼ��arm-none-eabi�Ƿ�װ"  -ForegroundColor Green
    # $p = & { arm-none-eabi-gcc --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "arm-none-eabiû�а�װ���߻�������û�����" -ForegroundColor Red
    #     Write-Host "����ϵ����ʦ" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    # Write-Host "���ڼ��pros-cli�Ƿ�װ"  -ForegroundColor Green
    # $p = & { prosv5 --version } 2>&1
    # if ($p -is [System.Management.Automation.ErrorRecord]) {
    #     Write-Host "pros-cliû�а�װ���߻�������û�����" -ForegroundColor Red
    #     Write-Host "����ϵ����ʦ" -ForegroundColor Red
    #     return 
    # }
    # else {
    #     Write-Host  $p -ForegroundColor Green
    # }
    Write-Host "����ɾ����ʱ���ش���ļ���"  -ForegroundColor Green
    Remove-Item C:\temp\ -recurse -force
    Write-Host "��ϲ��װ�ɹ�"  -ForegroundColor Green
}
else {
    Write-Host "powershell��ǰ�汾Ϊ:$powershellVersion, ������powershell����5.x����" -ForegroundColor Red
}












