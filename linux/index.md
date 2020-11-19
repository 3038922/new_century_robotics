# Linux 常用命令索引

## 常用命令

- 查看匹配名字的进程 `ps aux|grep xxx`

## SMB 共享

- 挂载 smb 共享目录
  1. 打开配置文件 `vim /etc/fstab`
  2. 输入 `//IP地址/XXX /要挂载的地方/XXX cifs username=root,password=xxxx 0 0`
  3. 挂载配置文件里的全部目录 `mount -a`
  4. 取消挂载 `umount ./xxx`
- 共享 smb 目录
  1. 书写配置 `vim /etc/samba/smb.conf`
  2. 添加 SMB 用户 `sudo smbpasswd -a www`
  3. 重启 smb 服务 `sudo /etc/init.d/samba restart`

## 挂载

1.  取消挂载 `umount ./xxx`
2.  查看目录的所有共享目录 `smbclient -L //192.168.31.199 -U dataswap`
3.  连接共享目录 `smbclient //192.168.31.199/ncrNas/ -U dataswap`
4.  临时挂载下 方便拷贝 `mount -t cifs -o username=dataswap,password=xxx //192.168.31.199/ncrNas ./tmp`

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

## 后台运行程序

`nohub xxxx &`
