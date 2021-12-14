## win10 链路聚合
1. `route print` 可以查看当前跃点数
2. 设置相同跃点数
### NetSwitchTeam
1. `Get-NetAdapter`查看当前网卡列表详情
2. `New-NetSwitchTeam -Name "lacp" -TeamMembers "以太网 1","以太网 2"` 添加成员组
3. `Get-NetSwitchTeam -Name "lacp"` 查看当前成员
4. `Remove-NetSwitchTeam -Name "lacp"` 删除当前组
### Intel® PROSet