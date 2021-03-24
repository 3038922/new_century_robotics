# #安装choco 
# Set-ExecutionPolicy Bypass -Scope Process -Force; 
# iex ((New-Object System.Net.WebClient).DownloadString('https://qzrobot.top/index.php/s/C8CqBw6a2conq54/download/ChocolateyInstall.ps1'))

# if ((Read-Host '??????ninja+ccls+llvm?[Y/N]') -eq 'y') {
#     Write-Host "?????" -ForegroundColor Green
# }
# else {
#     Write-Host "????" -ForegroundColor Green
# }
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001)

# $gitName = Invoke-Expression("git config --global user.name") 2>&1
# if ([String]::IsNullOrEmpty($gitName)) {
#     $gitName = (Read-Host "请输入您的git用户名如:dog,pig,mouse") 
#     Invoke-Expression("git config --global user.name  $gitName")
#     Write-Host "已设置为:$gitName" -ForegroundColor Green
# }
# else {
#     Write-Host "git用户名已配置为:" $(Invoke-Expression("git config --global user.name")) -ForegroundColor green
# }

# $gitEmail = Invoke-Expression("git config --global user.email") 2>&1
# if ([String]::IsNullOrEmpty($gitEmail)) {
#     $gitEmail = (Read-Host "请输入您的git Email 如:8888@qq.com") 
#     Invoke-Expression("git config --global user.email  $gitEmail")
#     Write-Host "已设置为:$gitEmail" -ForegroundColor Green
# }
# else {
#     Write-Host "git email已配置为:" $(Invoke-Expression("git config --global user.email")) -ForegroundColor green
# }
$name = "cmake.exe"
$suffix = $name.Substring($name.IndexOf('.') + 1) ;
if ( $suffix -eq "exe") { 
    Write-Host $suffix -ForegroundColor green 
}
else {
    Write-Host $suffix -ForegroundColor red
}