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

## 配置静态路由
`route print` 查看下静态路由和网卡号码

`route add -p 192.168.168.0 mask 255.255.255.0 192.168.168.254 metric 2 if 4` metric 是优先级 if 是网卡号
`route delete 0.0.0.0 mask 0.0.0.0 10.255.0.2` 删除静态路由