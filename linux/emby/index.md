# emby
## 破解
wget 下载
`dpkg -i xx`安装
`https://blog.jiawei.xin/?p=469`查看破解
`7z x ./linux64_docker64_4.7.5.7z -o./tmp`  解压缩
`cp -R /root/tmp/* /opt/emby-server/system/` 覆盖
## root权限
`service emby-server stop`
`vim /usr/lib/systemd/system/emby-server.service` 改用户为root
`systemctl daemon-reload`
`service emby-server start`