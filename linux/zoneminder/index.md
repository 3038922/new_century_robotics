# 视频监控服务
## 安装
1. 下载并创建docker
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
2. 要等很久系统才能打开
`rtsp://admin:xxxx103@192.168.31.121:554/onvif1`