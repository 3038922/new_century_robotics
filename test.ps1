$soft =
@{name = 'cmake.msi'; url = '9PpsXD9yxAd85sd' },
@{name = 'code.exe'; url = 'GjQZgGKfBDw2FBW' },
@{name = 'git.exe'; url = 'afkWMfGGrZxZcaR' },
@{name = 'python.exe'; url = 'THniMLtpTa4j3j5' }
$client = new-object System.Net.WebClient #创建下载对象
foreach ($it in $soft) {
    $name = $it.name.Substring(0, $it.name.IndexOf('.')) 
    Write-Host "正在检查 $name 是否安装"  -ForegroundColor Green
    $p = Invoke-Expression($name + " --version") 2>&1
    if ([String]::IsNullOrEmpty($p)) {
        Write-Host $it.name "没有安装或者环境变量没有添加"-ForegroundColor Red
        Write-Host "开始下载" $it.name -ForegroundColor Yellow
        $newUrl = 'https://qzrobot.top/index.php/s/' + $it.url + '/download/' + $it.name
        $newPath = 'c:/temp/' + $it.name
        Write-Host  $newUrl    $newPath  -ForegroundColor Green
        $client.DownloadFile($newUrl, $newPath)
        Start-Sleep -Milliseconds 200  # 延迟0.2秒
        Write-Host '开始安装' $it.name -ForegroundColor Green
        Start-Process $newPath -Wait #执行安装
    }
    else {
        Write-Host $p -ForegroundColor Green
    }
}