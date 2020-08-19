# 路由器

`service restart_dnsmasq` 重启 DNS

- 强制走一号线路

`ip router add 8.210.99.84 via 192.168.100.1 dev eth0 >/dev/null 2>&1`

- 强制开放路由器 443 端口

`iptables -I INPUT -p tcp --destination-port 443 -j ACCEPT`

- PC 端加入路由表\
  `route add 10.195.106.0 mask 255.255.255.0 10.195.106.238 -p` `route add 192.168.100.0 mask 255.255.255.0 192.168.100.101 -p`

# jails

1. 查看虚拟机编号 `jls`
2. 进入虚拟机 `jexec 编号`

# 更改 jails 用户

check everything with `id emby` change the group and user id: `pw groupmod transmission -n transmission -g 1101` `pw usermod transmission -n transmission -u 1101 -g 1101` change the permission on the emby executables: `chown -R emby:emby /media` tell the jail which user is using the emby server `sysrc emby_server_user=emby`

# 解压缩

`tar -C "要解压的目录" -xzf "被解压的文件名"`

# 搜索并删除

```
会删除所有以问mp3为扩展的文件。操作的时候先答：版
find / -name "*.mp3"
会打印出匹配的文件，如果觉得权正是想删除这些文件，再执行：
find / -name "*.mp3" |xargs rm -rf
```

# 开机自启和关闭

`sysrc aria2_enable=YES` `sysrc aria2_enable=NO`

# 挂载

1. 第一个是主机位置 第二个是虚拟机位置 `iocage fstab -a nextcloud /mnt/ares/nextCloud_files /usr/local/www/nextcloud/data/ nullfs rw 0 0` `iocage fstab -a nextcloud /mnt/ares/db/nextcloud /var/db/mysql nullfs rw 0 0` `iocage fstab -a emby /mnt/ares/aria2_download /movie nullfs rw 0 0`

# ZFS 存贮系统

1. 变更数据集模式 `zfs set primarycache=metadata ares/db`

# PKG 中科大源

```
FreeBSD: {

url: "pkg+http://mirrors.ustc.edu.cn/freebsd-pkg/${ABI}/latest",
mirror_type: "srv",
signature_type: "none",
fingerprints: "/usr/share/keys/pkg",
enabled: yes

}
```

# 安装 oh my zsh

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

# oh my zsh 中文乱码 及页面

```
ZSH_THEME="agnoster"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```

# 安装字体解决图标乱码

pkg install firacode

# nextcloud 相关

```
service mysql-server restart
service php-fpm restart
service nginx restart
```
