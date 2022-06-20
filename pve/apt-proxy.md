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
3. 常用源
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
