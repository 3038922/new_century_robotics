# if ((Read-Host '�Ƿ����ninja+ccls+llvm?[Y/N]') -eq 'y') {
#     Write-Host "ѡ����" -ForegroundColor Green
# }
# else {
#     Write-Host "ѡ�˷�" -ForegroundColor Green
# }

# #& msiexec /i "C:\temp\WinRAR.exe" TARGETDIR="C:\temp" /qb

#c:/ncrRobotics/temp/python.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
& c:/ncrRobotics/temp/code.exe /VERYSILENT /mergetasks=!runcode /ALLUSERS
& c:/ncrRobotics/temp/Git.exe /VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /ALLUSERS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"