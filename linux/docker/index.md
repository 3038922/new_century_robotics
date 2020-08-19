# dokcer 常用命令

## onlyoffice

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
