# Linux 常用命令索引

## 常用命令

- 查看匹配名字的进程 `ps aux|grep xxx`
## 关闭系统DNS
`systemctl stop systemd-resolved`
`systemctl disable systemd-resolved`

## SMB 共享

- 挂载 smb 共享目录
  1. 打开配置文件 `vim /etc/fstab`
  2. 输入 `//192.168.31.199/ncrNas /www/media/ cifs username=username,password=password,sec=ntlmssp,rw,_netdev, directio 0 0`
  3. 挂载配置文件里的全部目录 `mount -a`
  4. 取消挂载 `umount ./xxx`
- 共享 smb 目录
  1. 书写配置 `vim /etc/samba/smb.conf`
  2. 添加 SMB 用户 `sudo smbpasswd -a www`
  3. 重启 smb 服务 `sudo /etc/init.d/samba restart`

## 挂载

1.  取消挂载 `umount ./xxx`
2.  查看目录的所有共享目录 `smbclient //192.168.31.199/ncrNas -U dataswap`
3.  连接共享目录 `smbclient //192.168.31.199/ncrNas/ -U dataswap`
4.  临时挂载下 方便拷贝 `mount -t cifs -o username=dataswap,password=xxx //192.168.31.199/ncrNas ./tmp`
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

## 硬盘扩容
- 查看硬盘分区结构 `lsblk`
- 查看剩余容量 `vgdisplay`
- 先执行这个命令扩容. 236G 是你希望扩大到多少.不是新增.
lvextend -L 236G /dev/mapper/ubuntu--vg-ubuntu--lv
- 再执行这个
resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
- 最后`df -h` 看看是否增大了.
## 格式化
- 删除机械硬盘的 Windows 分区 `fdisk /dev/sda`
- 将机械硬盘格式化为 ext4 `mkfs.ext4 /dev/sda`
- 挂载机械硬盘 `mkdir /mnt/data` `mount /dev/sda /mnt/data` ` df -Th`
- 设置开机自动挂载 `在 /etc/fstab 中追加 /dev/sda /mnt/data ext4 defaults 0 0`
- 重启后验证 `lsblk -f`
## ZFS
- 磁盘容量及分区状况（不能查看未挂载分区） `df -hl`
- 磁盘容量及分区状况（可以查看未挂载分区） `fdisk -l` `lsblk -f`
-  /lib 目录大小 `du -sh /lib`
- /lib 子目录大小 `du -sh /lib/*`
- 安装 `apt install zfsutils`
- 创建ZFS池"zfs2" `zpool create ares raidz2 /dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde`
- 查看状态 `zpool status`
- 当检查 ZFS 状态时，池将通知你需要知道的所有更新。要更新池，请运行如下命令 `zpool upgrade pool-name`
- 也可以使用如下命令更新所有 ZFS 池 `zpool upgrade -a`
- 当然，你也可以随时向池中添加新的磁盘驱动器，只需使用 zpool 指定池名称和驱动器位置即可 `zpool add pool-name /dev/sdx`
