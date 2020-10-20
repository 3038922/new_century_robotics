Docker 安装 Onlyoffice 并更新中文字体的办法
必要条件：操作系统如果选择 centos 必须选择 7 以上（旧版本的 docker 拷贝文件命令有 bug）

1、安装 docker（yum 安装即可，yum 版本要在 1.8 以上），并启动 docker 服务

2、在 docker 下下载 onlyoffice 镜像，用的是 pull 命令

docker pull onlyoffice/documentserver
3、在 docker 下启动镜像：

- 创建一个容器

```sh
docker run -i -t -d -p 8085:80 --restart=always \
 -v /app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice \
 -v /app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data \
 -v /app/onlyoffice/DocumentServer/lib:/var/lib/onlyoffice \
 -v /app/onlyoffice/DocumentServer/db:/var/lib/postgresql onlyoffice/documentserver
```

- 进入容器 `docker exec -it funny_turing /bin/bash`
- 如果 nextcloud 无法挂载 onlyoffice
  1. 就进去 onlyoffice 虚拟机 修改 `nano /etc/hosts`
  2. 加入`qzrobot.top` 和 `onlyoffice.qzrobot.top` 的重定向

查看正在运行的 docker

docker ps

4、进入运行着的 docker 镜像内：

docker exec [镜像 id] /bin/bash
exec 命令可以进入 docker，并执行后面的命令，上面是执行/bin/bash

5、把从 windows 字体目录拷贝的文件 cp 到镜像内（在镜像外执行，镜像是否运行无所谓）：

docker cp /root/fonts/ [镜像 id]:/usr/share/fonts/
cp 后面的路径都以”/”结尾，前提是，把中文字体文件名改成英文

6、在镜像内，进入/usr/bin 目录 输入

./documentserver-generate-allfonts.sh，字体更换完成，这是最关键的一步。
7、把当前镜像保存成一个 image 并保存成 tar 文件保存。

docker commit -a "jingying.cn" -m "onlyoffice-chinesefonts" [镜像 id] onlyoffice:v1
-a 作者 -m 镜像描述 最后是镜像名称和版本

8、把镜像保存成 tar 文件，tar 镜像的加载可以用 docker load -i [镜像.tar] 加载

docker save -o onlyoffice-chinesefonts.tar onlyoffice:v1

docker save -o onlyoffice-chinesefonts.tar onlyoffice:v1
