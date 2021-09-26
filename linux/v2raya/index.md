# v2raya

## 新版需要关闭原始进程
- 查看进程 `ps -aux | grep systemd-resolved`
- kill  进程 pid

## ufw 会导致 v2raya局域网共享失效.
- # 允许输入链
`ufw allow from 192.168.1.0/24`
# 允许转发链
`ufw route allow in on bond0 out  on bond0 to any from 192.168.1.0/24`
# 重载规则
`ufw reload`
# 最后查看规则应该有类似的两条规则
`iptables --list-rules`
`-A ufw-user-forward -s 192.168.0.0/23 -i bond0 -o bond0 -j ACCEPT`
`-A ufw-user-input -s 192.168.0.0/23 -j ACCEPT`