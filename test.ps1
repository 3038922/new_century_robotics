$soft =
@{name = 'cmake.msi'; url = '9PpsXD9yxAd85sd' },
@{name = 'code.exe'; url = 'GjQZgGKfBDw2FBW' },
@{name = 'git.exe'; url = 'afkWMfGGrZxZcaR' },
@{name = 'python.exe'; url = 'THniMLtpTa4j3j5' }
$client = new-object System.Net.WebClient #�������ض���
foreach ($it in $soft) {
    $name = $it.name.Substring(0, $it.name.IndexOf('.')) 
    Write-Host "���ڼ�� $name �Ƿ�װ"  -ForegroundColor Green
    $p = Invoke-Expression($name + " --version") 2>&1
    if ([String]::IsNullOrEmpty($p)) {
        Write-Host $it.name "û�а�װ���߻�������û�����"-ForegroundColor Red
        Write-Host "��ʼ����" $it.name -ForegroundColor Yellow
        $newUrl = 'https://qzrobot.top/index.php/s/' + $it.url + '/download/' + $it.name
        $newPath = 'c:/temp/' + $it.name
        Write-Host  $newUrl    $newPath  -ForegroundColor Green
        $client.DownloadFile($newUrl, $newPath)
        Start-Sleep -Milliseconds 200  # �ӳ�0.2��
        Write-Host '��ʼ��װ' $it.name -ForegroundColor Green
        Start-Process $newPath -Wait #ִ�а�װ
    }
    else {
        Write-Host $p -ForegroundColor Green
    }
}