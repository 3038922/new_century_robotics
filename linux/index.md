# Linux 常用命令索引

## 常用命令

- 查看匹配名字的进程 `ps aux|grep xxx`

## SMB 共享

- 挂载 smb 共享目录
  1. 打开配置文件 `vim /etc/fstab`
  2. 输入 `//IP地址/XXX /要挂载的地方/XXX cifs username=root,password=xxxx 0 0`
  3. 挂载配置文件里的全部目录 `mount -a`

## 重启后任务

1. 检查各种 WEB 服务器
2. 检查 docker 被还原的服务 如 onlyoffice
3. 检查 aria2
4. 检查 smb 挂载
5. 检查 v2ray

## TCP 连接数限制

## TCP BBR 加速

```
echo net.core.default_qdisc=fq >> /etc/sysctl.conf
echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf
```

- 保存 `sysctl -p`
- 验证 `sysctl net.ipv4.tcp_available_congestion_control`
- 如果结果是 `net.ipv4.tcp_available_congestion_control = bbr cubic reno` 就表示开启了.
- 执行 `lsmod | grep bbr` ，以检测 BBR 是否开启。
