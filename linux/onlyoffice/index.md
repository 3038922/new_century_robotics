## docker 安装 onlyoffice
- LARGER_FILE_LIMITS=true

## 安装中文字体
### 宿主机本身装中文字体
`apt install ttf-mscorefonts-installer` 安装字体扫描软件
`cd /usr/share/fonts/`
`mkfontscale`
`fc-cache` 
`fc-list :lang=zh` 查看中文字体是否安装成功
### 容器装字体
- 容器挂载 外部磁盘 `- ./onlyoffice/fonts:/usr/share/fonts/truetype/custom`
- 进入容器 `docker exec -it onlyoffice /bin/bash`
- 删除老字体 `rm -rf /usr/share/fonts/*` `rm -rf /var/www/onlyoffice/documentserver/core-fonts/*` 
- `docker cp /usr/share/fonts onlyoffice:/usr/share` 再将字体全部下载到容器的`/usr/share/fonts`目录下。
- 在容器内执行 `fc-cache -f -v` `/usr/bin/documentserver-generate-allfonts.sh`
- 将浏览器缓存清空，即可正常使用。

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