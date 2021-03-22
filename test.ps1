$ncrRoboticsPath = "c:\ncrRobotics\"
$tmpPath = $ncrRoboticsPath + "temp\"
if (!(Test-Path -Path $ncrRoboticsPath )) {
    Write-Host "创建ncrRobotics文件夹 $path" -ForegroundColor Green
    & mkdir $ncrRoboticsPath 
}
if (!(Test-Path -Path $tmpPath)) {
    Write-Host "创建临时文件夹 $tmpPath" -ForegroundColor Green
    & mkdir $tmpPath
}
#下载wirar
$client = new-object System.Net.WebClient #创建下载对象
if (Test-Path("C:\Program Files\WinRAR\WinRAR.exe")) {
    Write-Host "winrar.exe 已存在无需重新下载" -ForegroundColor Green
}
else {
    Write-Host "开始下载winrar.exe" -ForegroundColor Green
    $client.DownloadFile('https://qzrobot.top/index.php/s/EgsQdNJzZKjrGCz/download/WinRAR.exe', $tmpPath + 'winrar.exe')
    Start-Sleep -Milliseconds 200  # 延迟0.2秒
    Write-Host "开始安装winrar.exe" -ForegroundColor Green
    Invoke-Expression($tmpPath + "winrar.exe /S /v /qn") 
}
c:/temp/python-3.7.0.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
https://www.jianshu.com/p/95c5194857b7