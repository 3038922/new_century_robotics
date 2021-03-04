## docker 安装 onlyoffice

1. 安装 docker

2. 在 docker 下下载 onlyoffice 镜像，用的是 pull 命令 `docker pull onlyoffice/documentserver`
3. 在 docker 下启动镜像：

4. 创建一个容器

```sh
docker run -i -t -d -p 8086:80 --restart=always --name="onlyoffice" \
 -v /app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice \
 -v /app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data \
 -v /app/onlyoffice/DocumentServer/lib:/var/lib/onlyoffice \
 -v /app/onlyoffice/DocumentServer/db:/var/lib/postgresql onlyoffice/documentserver
```

## 安装中文字体

- 进入容器 `docker exec -it distracted_mayer /bin/bash`
- 如果 nextcloud 无法挂载 onlyoffice

  1. 就进去 onlyoffice 虚拟机 修改 `nano /etc/hosts`
  2. 加入`qzrobot.top` 和 `onlyoffice.qzrobot.top` 的重定向

- 查看正在运行的 docker `docker ps -a`
- 更换字体

  1. 删除内置字体`rm -rf /var/www/onlyoffice/documentserver/core-fonts/*` `rm -rf /usr/share/fonts/*`
  2. 复制进 docker 内 `docker cp ./fonts/ 7603321130e4:/usr/share/fonts/truetype/custom`
  3. 修改字体权限 `chmod -R 644 /usr/share/fonts`
  4. 清缓存 `fc-cache -f -v`
  5. 导入新字体。 `docker exec -it onlyoffice documentserver-generate-allfonts.sh`

- 把当前镜像保存成一个 image 并保存成 tar 文件保存。
  `docker commit -a "jingying.cn" -m "onlyoffice-chinesefonts" [镜像 id] onlyoffice:v1 -a 作者 -m 镜像描述 最后是镜像名称和版本`

- 把镜像保存成 tar 文件，tar 镜像的加载可以用 docker load -i [镜像.tar] 加载

docker save -o onlyoffice-chinesefonts.tar onlyoffice:v1

## 更新 onlyoffice

1. 关闭 ONLYOFFICE
   由于操作特性，ONLYOFFICE Docs 仅在文档的所有编辑者都关闭了文档之后才保存该文档。为避免数据丢失，如果需要在应用程序更新时停止 ONLYOFFICE Docs，则必须强制断开 ONLYOFFICE Docs 用户的连接。为此，请执行以下脚本：
   `sudo docker exec onlyoffice documentserver-prepare4shutdown.sh`
   您可以使用 Docker 命令轻松列出当前的 ONLYOFFICE Docs 容器名称或 ID，该命令将列出所有现有容器：
   `sudo docker ps -a`
   执行脚本可能需要很长时间（最多 5 分钟）。
   断开用户连接可能需要很长时间（最多 5 分钟）。

2. 为 Docker 更新 ONLYOFFICE 文档

   1. ：检查是否已安装所有外部数据存储文件夹
      确保使用以下命令装入用于存储 ONLYOFFICE Docs 数据的所有容器卷：
      `sudo docker inspect --format='{{range $p,$conf:=.HostConfig.Binds}}{{$conf}};{{end}}' {{DOCUMENT_SERVER_ID}}`
   2. 停止当前的 ONLYOFFICE Docs Docker 容器。
      `sudo docker stop {{DOCUMENT_SERVER_ID}}`
   3. 下载最新的 ONLYOFFICE 文档图像
      下载最新的 ONLYOFFICE Docs 图像，并指定 latest 标签：
      `docker pull onlyoffice/documentserver:latest`
   4. 使用相同的地图路径运行新图像
      ```
      sudo docker run -i -t -d -p 80:80 --restart=always \
       -v /host_folder:/volume \
       -v /host_folder:/volume onlyoffice/documentserver
      ```
      确保运行新映像时所映射的文件夹路径与为先前版本安装的文件夹路径完全一致，否则将不会自动拾取存储在这些文件夹中的数据。为此，请指定-v 选项参数，将`/host_folder:/volume` 值替换为步骤 1 中显示的实际路径。

3. 删除旧的 ONLYOFFICE Docs 容器和图像
   确保一切正常并且更新的 ONLYOFFICE Docs 版本正常运行后，可以删除旧的 ONLYOFFICE Docs 容器：
   `sudo docker rm {{OLD_DOCUMENT_SERVER_CONTAINER_ID}}`
   其中`{{OLD_DOCUMENT_SERVER_CONTAINER_ID}}`代表 OLD ONLYOFFICE Docs 容器名称或 ID。
   如果要释放空间，也可以删除旧图像。显示所有 docker 映像：
   `sudo docker images -a`
   在图像列表中找到不必要的图像 ID 并删除图像：
   `sudo docker rmi {{OLD_DOCUMENT_SERVER_IMAGE_ID}}`
4. 手动启动 `sudo docker exec -it onlyoffice /app/ds/run-document-server.sh`
## onlyoffice nginx配置
```
  server {
    server_name onlyoffice.qzrobot.top;
    listen 443 ssl;
    ssl_certificate /root/1591072824883.pem;
    ssl_certificate_key /root/1591072817311.key;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
    listen 80;
    if ($scheme = http) {
      return 301 https://$host:443$request_uri;
    }
    location / {
      proxy_pass http://10.195.106.43:8086;
      proxy_set_header Host $host:$server_port;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_redirect http:// https://;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
    }
  }
  ```