# docker 常用命令
`vim /etc/docker/daemon.json`
```
{
        "registry-mirrors": [
        "http://hub-mirror.c.163.com", "https://registry.docker-cn.com"
        ],
        "dns": ["10.255.0.253","223.5.5.5"]
}
```
`service docker restart`