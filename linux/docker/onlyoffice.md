## docker 安装 onlyoffice

1. 安装 docker

2. 在 docker 下下载 onlyoffice 镜像，用的是 pull 命令 `docker pull onlyoffice/documentserver `
3. 在 docker 下启动镜像：

4. 创建一个容器

```sh
docker run -i -t -d -p 8086:80 --restart=always \
 -v /app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice \
 -v /app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data \
 -v /app/onlyoffice/DocumentServer/lib:/var/lib/onlyoffice \
 -v /app/onlyoffice/DocumentServer/db:/var/lib/postgresql onlyoffice/documentserver
```

## 安装中文字体

- 进入容器 `docker exec -it jovial_mayer/bin/bash`
- 如果 nextcloud 无法挂载 onlyoffice

  1. 就进去 onlyoffice 虚拟机 修改 `nano /etc/hosts`
  2. 加入`qzrobot.top` 和 `onlyoffice.qzrobot.top` 的重定向

- 查看正在运行的 docker `docker ps -a`
- 更换字体
  1. 删除内置字体`rm -rf /var/www/onlyoffice/documentserver/core-fonts/*` `rm -rf `
  2. 复制进 docker 内 `docker cp ./fonts/ 2e2e2af4c1e4:/usr/share/fonts/truetype/`
  3. 清缓存 `fc-cache -f -v`
  4. 导入新字体。 `/usr/bin/documentserver-generate-allfonts.sh`

把当前镜像保存成一个 image 并保存成 tar 文件保存。
docker commit -a "jingying.cn" -m "onlyoffice-chinesefonts" [镜像 id] onlyoffice:v1
-a 作者 -m 镜像描述 最后是镜像名称和版本

8、把镜像保存成 tar 文件，tar 镜像的加载可以用 docker load -i [镜像.tar] 加载

docker save -o onlyoffice-chinesefonts.tar onlyoffice:v1

## 更新 onlyoffice
