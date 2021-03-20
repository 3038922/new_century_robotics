$soft = @{name = 'cmake.msi'; url = '9PpsXD9yxAd85sd' }, @{name = 'vscode.exe'; url = 'ySZieKANW5GedZM' },
@{name = 'git.exe'; url = 'afkWMfGGrZxZcaR' }, @{name = 'python.exe'; url = 'THniMLtpTa4j3j5' }
foreach ($it in $soft) {
    $name = $it.name.Substring(0, $it.name.IndexOf('.')) 
    Write-Host "正在检查 $name 是否安装"  -ForegroundColor Green
    $p = Invoke-Expression($name + " --version") 2>&1
    if ([String]::IsNullOrEmpty($p)) {
        Write-Host $it.name "没有安装或者环境变量没有添加"-ForegroundColor Red
        Write-Host "开始下载" $it.name -ForegroundColor Yellow
        Write-Host 'https://qzrobot.top/index.php/s/'+"$it.url"+'/download/cmake.msi' -ForegroundColor Green
        # $client.DownloadFile('https://qzrobot.top/index.php/s/9PpsXD9yxAd85sd/download/cmake.msi', 'c:/temp/cmake.msi')
        # Start-Sleep -Milliseconds 200  # 延迟0.2秒
        # Write-Host '开始安装cmake.msi' -ForegroundColor Green
        # Start-Process  'c:\temp\cmake.msi'-Wait #执行安装
    }
    else {
        Write-Host $p -ForegroundColor Green
    }
}