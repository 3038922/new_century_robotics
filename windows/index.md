## oh-my-posh
1. 先装好choco 
2. `choco install ConEmu`
3. `Install-Module posh-git -Scope CurrentUser`
4. 安装 `Install-Module oh-my-posh -Scope CurrentUser` 更新 `Update-Module -Name oh-my-posh`
5. 更新配置文件$PROFILE `$PROFILE` 输出 `C:\Users\ares-work\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
6. powershell 直接输入 `if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }`
7. `notepad $PROFILE` 打开的文件中 输入 
```
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme Paradox
```
8. 配置更新 `C:\Users\ares-work\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` 重启

## 常用软件
`chcoc install gsudo`
`choco install winmtr-redux`
`choco install iperf3`
`choco install telnet`
