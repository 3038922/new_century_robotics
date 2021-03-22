$tmp = Read-Host '是否更新ninja+ccls+llvm?[Y/N]' 
if ($tmp -eq 'y') {
    Write-Host "选了是" -ForegroundColor Green
}
else {
    Write-Host "选了否" -ForegroundColor Green

}

c:/temp/python-3.7.0.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
https://www.jianshu.com/p/95c5194857b7