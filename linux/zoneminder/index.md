# 视频监控服务
## 安装
1. 下载并创建docker
```
docker run -d -t -p 8088:80 \
    -e TZ='Asia/Shanghai' \
    -v /app/zoneminder/events:/var/cache/zoneminder/events \
    -v /app/zoneminder/images:/var/cache/zoneminder/images \
    -v /app/zoneminder/mysql:/var/lib/mysql \
    -v /app/zoneminder/logs:/var/log/zm \
    --shm-size="2048m" \
    --name zoneminder \
    zoneminderhq/zoneminder:latest-ubuntu18.04
```
```
docker run -d -t -p 8088:443 \
    --net="bridge" \
    --privileged="false" \
    -e TZ='Asia/Shanghai' \
    -e ZM_DB_USER='zoneminder' \
    -e ZM_DB_PASS='protoss' \
    -e ZM_DB_NAME='zoneminder' \
    -e ZM_DB_HOST='10.195.106.43:3306' \
    -v /app/zoneminder/events:/var/lib/zoneminder/events \
    -v /app/zoneminder/logs:/var/log/zm \
    --shm-size="2048m" \
    --name zoneminder \
    zoneminderhq/zoneminder:latest-el7
```
```sh
docker run -d --name="zoneminder" \
--net="bridge" \
--privileged="false" \
--shm-size="4G" \
-p 8088:80/tcp \
-p 8089:443/tcp \
-p 8090:9000/tcp \
-e TZ="Asia/Shanghai" \
-e PUID="99" \
-e PGID="100" \
-e INSTALL_HOOK="0" \
-e INSTALL_FACE="0" \
-e INSTALL_TINY_YOLOV3="0" \
-e INSTALL_YOLOV3="0" \
-e INSTALL_TINY_YOLOV4="0" \
-e INSTALL_YOLOV4="0" \
-e MULTI_PORT_START="0" \
-e MULTI_PORT_END="0" \
-v "/app/zoneminder":"/config":rw \
-v "/app/zoneminder/data":"/var/cache/zoneminder":rw \
dlandon/zoneminder
```
`rtsp://admin:protoss103@192.168.31.121:554/onvif1`