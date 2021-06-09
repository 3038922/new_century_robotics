# 新世纪机器人社win10系统环境变量配置
Write-Host "此版本使用新世纪机器人学院(中国)安装源" -ForegroundColor Green
Write-Host "请关闭所有类似360、腾讯管家等有可能拦截系统修改的安全软件，防止系统安装出错" -ForegroundColor Green
Write-Host "确认关闭后，请按【回车】键继续..." -ForegroundColor Green
pause
Write-Host "开始安装" -ForegroundColor Green
$ncrRoboticsPath = "c:\ncrRobotics\"
$tmpPath = $ncrRoboticsPath + "temp\"
$winrar = "C:\Program Files\WinRAR\winrar.exe"

#visualstudio
if (Test-Path("C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC")) {
    Write-Host "vs2019 已安装" -ForegroundColor Green
}
else {
    # 下载vs压缩包
    $vsRar = $tmpPath + "vs2019.rar"
    $client = new-object System.Net.WebClient #创建下载对象
    if (Test-Path($vsRar)) {
        Write-Host "$vsRar 已存在无需重新下载" -ForegroundColor Green
    }
    else {
        Write-Host "开始下载 vs2019.rar" -ForegroundColor Green
        $client.DownloadFile('https://qzrobot.top/index.php/s/TRZwkD9dJNxZoWk/download/vs2019.rar', $tmpPath + 'vs2019.rar')
        Start-Sleep -Milliseconds 200  # 延迟0.2秒
    }
    # 解压缩
    $vs = $tmpPath + "vs2019"
    if (Test-Path($vs)) {
        Write-Host "$vs 已存在无需解压" -ForegroundColor Green
    }
    else {
        Write-Host "开始解压缩 vs2019.rar" -ForegroundColor Green
        $iArgs = "x -ibck -y " + $tmpPath + "vs2019.rar" + " $tmpPath"
        Start-Process  $winrar $iArgs -Wait #解压缩zip
    }

}
Write-Host "正在安装 vs2019" -ForegroundColor Green
Start-Process ("C:\ncrRobotics\temp\vs2019\vs_Community.exe") " --noweb --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.NativeCrossPlat --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --includeRecommended" -Wait
Write-Host "安装完毕 vs2019" -ForegroundColor Green
Write-Host "安装完毕 vs2019" -ForegroundColor Yellow
Write-Host "安装完毕 vs2019" -ForegroundColor Red