1. 更新
```
http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true update && \
http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true upgrade -y
```
2. 装软件
```
http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true update && \
http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true install vim -y
```