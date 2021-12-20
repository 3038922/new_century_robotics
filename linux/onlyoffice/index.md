## docker 安装 onlyoffice

1. 安装 docker

2. 在 docker 下下载 onlyoffice 镜像，用的是 pull 命令 `docker pull onlyoffice/documentserver`
3. 在 docker 下启动镜像：

4. 创建一个容器

```sh
docker run -itd --add-host qzrobot.top:10.195.106.231 -p 3003:80 --restart=always --name="onlyoffice" \
 -v /app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice \
 -v /app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data \
 -v /app/onlyoffice/DocumentServer/lib:/var/lib/onlyoffice \
 -v /app/onlyoffice/DocumentServer/db:/var/lib/postgresql onlyoffice/documentserver
```

## 安装中文字体

- 进入容器 `docker exec -it onlyoffice /bin/bash`
- 删除老字体 `rm -rf /usr/share/fonts/*` `rm -rf /var/www/onlyoffice/documentserver/core-fonts/*`
- 再将字体全部下载到容器的`/usr/share/fonts`目录下。
- 在容器内执行 ` fc-cache -f -v` `/usr/bin/documentserver-generate-allfonts.sh`
- 将浏览器缓存清空，即可正常使用。
## 字号问题
中文还是习惯小初、小四之类的。<br>
将<br>
/var/www/onlyoffice/documentserver/web-apps/apps/documenteditor/main/<br>
目录下的app.js做修改即可。<br>
注意：一共有6个app.js文件，我只修改了文档编辑器的电脑版本。其他如电子表格、幻灯片及移动版本没有修改。因为基本用不到。
<br>
app.js需要从容器拷贝出来后修改，直接修改未必会成功。<br>
在app.js中查找`{value:8,displayValue:"8"}`字符串，将相应字符串替换为:<br>
```
{value:42,displayValue:"初号"},{value:36,displayValue:"小初"},{value:26,displayValue:"一号"},{value:24,displayValue:"小一"},{value:22,displayValue:"二号"},{value:18,displayValue:"小二"},{value:16,displayValue:"三号"},{value:15,displayValue:"小三"},{value:14,displayValue:"四号"},{value:12,displayValue:"小四"},{value:10.5,displayValue:"五号"},{value:9,displayValue:"小五"},{value:7.5,displayValue:"六号"},{value:6.5,displayValue:"小六"},{value:5.5,displayValue:"七号"},{value:5,displayValue:"八号"},
```
<br>
建议保留后面的value:48等值。
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