$soft = @{name = 'cmake.msi'; url = '9PpsXD9yxAd85sd' }, @{name = 'vscode.exe'; url = 'ySZieKANW5GedZM' },
@{name = 'git.exe'; url = 'afkWMfGGrZxZcaR' }, @{name = 'python.exe'; url = 'THniMLtpTa4j3j5' }
foreach ($it in $soft) {
    $name = $it.name.Substring(0, $it.name.IndexOf('.')) 
    Write-Host "���ڼ�� $name �Ƿ�װ"  -ForegroundColor Green
    $p = Invoke-Expression($name + " --version") 2>&1
    if ([String]::IsNullOrEmpty($p)) {
        Write-Host $it.name "û�а�װ���߻�������û�����"-ForegroundColor Red
        Write-Host "��ʼ����" $it.name -ForegroundColor Yellow
        Write-Host 'https://qzrobot.top/index.php/s/'+"$it.url"+'/download/cmake.msi' -ForegroundColor Green
        # $client.DownloadFile('https://qzrobot.top/index.php/s/9PpsXD9yxAd85sd/download/cmake.msi', 'c:/temp/cmake.msi')
        # Start-Sleep -Milliseconds 200  # �ӳ�0.2��
        # Write-Host '��ʼ��װcmake.msi' -ForegroundColor Green
        # Start-Process  'c:\temp\cmake.msi'-Wait #ִ�а�װ
    }
    else {
        Write-Host $p -ForegroundColor Green
    }
}