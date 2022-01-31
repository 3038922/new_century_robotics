# ceph
- 参考 `https://blog.csdn.net/caiyqn/article/details/106303492`

## 网络规划
- 最好先去网盘下载好安装包 这货安装奇慢
- 先挂载 `mount -t cifs -o username=dataswap,password=protoss //10.255.0.199/ncrNas ./tmp`
- 然后复制 `cp -R /root/tmp/ceph/* /var/cache/apt/archives` apt安装包存放位置 `/var/cache/apt/archives`
1. 在每个节点上都安装ceph 后面不加版本号是安装最新的
`pveceph install` 
2. 建立ceph集群网络，3个存储节点上面均执行
`pveceph init -network 10.8.20.0/24`
3. 创建ceph集群存储Mon监控， 3个存储节点上面均执行
`pveceph createmon`
4. 创建ceph mgr - 每台执行
`pveceph createmgr`
```
Ceph Monitor：由该英文名字可以知道它是一个监视器，负责监视Ceph集群，维护Ceph集群的健康状态，同时维护着Ceph集群中的各种Map图，比如OSD Map、Monitor Map、PG Map和CRUSH Map，这些Map统称为Cluster Map，Cluster Map是RADOS的关键数据结构，管理集群中的所有成员、关系、属性等信息以及数据的分发，比如当用户需要存储数据到Ceph集群时，OSD需要先通过Monitor获取最新的Map图，然后根据Map图和object id等计算出数据最终存储的位置。
```
5. 创建ceph集群存储OSD服务， 3个存储节点上面均执行，事先为3个存储节点添加了一块200G的新硬盘。
`pveceph createosd /dev/sdxxxx`
```
Ceph OSD：OSD的英文全称是Object Storage Device，它的主要功能是存储数据、复制数据、平衡数据、恢复数据等，与其它OSD间进行心跳检查等，并将一些变化情况上报给Ceph Monitor。一般情况下一块硬盘对应一个OSD，由OSD来对硬盘存储进行管理，当然一个分区也可以成为一个OSD。
```
8. 创建集群存储资源池，将上面3个OSD结合在一起对外提供存储服务
- 只在作为mgr的pve-store1上面执行
`ceph osd pool create pvepool1 128 128`
```
其中的128(pg_num)的设置：
少于 5 个 OSD 时，可把 pg_num 设置为 128
OSD 数量在 5 到 10 个时，可把 pg_num 设置为 512
OSD 数量在 10 到 50 个时，可把 pg_num 设置为 4096

这里的128不是随便写的，是需要大家计算的，超出会报错
Pool 对应 PG PGP数量的计算公式： 官方计算地址
Total PGs = ((Total_number_of_OSD * Target PGs per OSD) / max_replication_count) / pool_count
Target PGs per OSD 通常被设置为 100
最终的结果取2的幂次方最靠近的数，这里为128
```
9. 创建RBD块设备存储
- 激活pvepool1为rbd存储池，用于存储pve的磁盘映像跟容器
` ceph osd pool application enable pvepool1 rbd`
```
RBD块存储是ceph提供的3种存储类型中使用最广泛，最稳定的存储类型。RBD块类似于磁盘，可以挂载到物理机或虚拟机中。这里是挂载到pve主机上，作为pve主机的存储（共享存储）。

登录pve-store1的web管理页面，依次打开：数据中心->存储->添加->选择RBD
打开添加RBD对话框

ID：填写为pve-rbd RBD设备的id

资源池：pve-pool，所属的资源池

Monitor： pve-store1 pve-store2 pve-store3，监视器

节点：暂时添加pve-store1， pve-store2， pve-store3，表示集群中哪些主机可以使用该块设备。
添加后，可以看到集群主机下会增加一个存储
rbd块设备存储
```
## 常用命令
- 查看集群状态
`ceph -s`
- 赋予应用相关权限 在pve-store1上执行
`ceph osd pool application enable pve-pool rgw rbd`
- 查看ceph有哪些存储池
`ceph osd lspools`
- 查看ceph的空间大小及可用大小
`ceph df`
- 查看ceph的副本数
`ceph osd pool get pve-pool size`
```
默认情况下是3，即存放在ceph集群中的数据会有3个副本，所以整个ceph集群的可用空间大约是(500*3（osd数目）)/3（副本数）=500G（里面的算法很复杂，所以要少于500G，这里实际上是473G）
```
- 设置新的副本数为2
`ceph osd pool set pve-pool size 2`

## 为集群安装ceph Dashboard

- 在pve-store1上执行
```
apt install ceph-mgr-dashboard -y
ceph mgr module enable dashboard
ceph dashboard create-self-signed-cert
ceph dashboard ac-user-create admin admin123 administrator（其中 admin是用户名 admin123是密码 administrator指定用户是管理员）
systemctl restart ceph-mgr@pve-store1.service
```
- 访问https://10.8.20.241:8443，使用用户名admin密码admin123登录即可。