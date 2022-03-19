# ceph
## 删除OSD
1. 移除 `pveceph osd out 0`
2. 停止服务 `ceph osd down 0` 或者 `systemctl stop ceph-osd@0.service`
3. 移除挂载 `umount /var/lib/ceph/osd/ceph-0`
4. 从crush map 中移除osd `ceph osd crush remove osd.0`
5. 删除故障osd的密钥 `ceph auth del osd.0`
6. 删除故障osd `ceph osd rm 0`
7. 销毁 `pveceph osd destroy 0`


## 如果删不掉用这个方法
1. 查看当前表明 `dmsetup ls`
2. 查看谁在占用 `lsblk`
3. 移除`dmsetup remove ceph-**`
4. 然后进UI格式化


## 重新导入已有节点
`ceph-volume lvm activate --all`

## 网络规划
- 参考 `https://blog.csdn.net/caiyqn/article/details/106303492`
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
2.1 查看osd状态
$ ceph osd stat
5 osds: 5 up, 5 in
状态说明：

集群内(in)
集群外(out)
活着且在运行(up)
挂了且不再运行(down)
说明：

如果OSD活着，它也可以是 in或者 out 集群。如果它以前是 in 但最近 out 了， Ceph 会把其归置组迁移到其他OSD 。
如果OSD out 了， CRUSH 就不会再分配归置组给它。如果它挂了（ down ）其状态也应该是 out 。
如果OSD 状态为 down 且 in ，必定有问题，而且集群处于非健康状态。
2.2 查看osd映射信息
$ ceph osd dump
epoch 4971
fsid 97219550-d917-4154-b745-32bac14f99f2
created 2017-08-31 16:14:26.155920
modified 2017-11-15 13:48:39.834169
flags sortbitwise,recovery_deletes
crush_version 113
full_ratio 0.95
backfillfull_ratio 0.9
nearfull_ratio 0.85
require_min_compat_client jewel
min_compat_client jewel
require_osd_release luminous
pool 1 'rbd' replicated size 3 min_size 2 crush_rule 0 object_hash rjenkins pg_num 2048 pgp_num 2048 last_change 3845 lfor 0/187 flags hashpspool stripe_width 0 application rbd
 removed_snaps [1~3,7~8,11~5,17~4,1c~4,21~1]
pool 2 'test_data' replicated size 3 min_size 2 crush_rule 0 object_hash rjenkins pg_num 512 pgp_num 512 last_change 1575 lfor 0/227 flags hashpspool stripe_width 0 application cephfs
 removed_snaps [1~3,5~4]
osd.0 up in weight 1 up_from 4959 up_thru 4966 down_at 4789 last_clean_interval [4551,4788) 10.1.1.34:6817/477028 10.1.1.34:6818/477028 10.1.1.34:6819/477028 10.1.1.34:6820/477028 exists,up 1c43b2d1-fc59-4e55-8511-2480964fef41
osd.1 up in weight 1 up_from 4577 up_thru 4966 down_at 4575 last_clean_interval [4521,4574) 10.1.1.34:6825/338609 10.1.1.34:6827/338609 10.1.1.34:6841/338609 10.1.1.34:6844/338609 exists,up 68630ac4-09a4-4b50-9dba-4bbe161bc6b3
osd.2 up in weight 1 up_from 4568 up_thru 4966 down_at 4566 last_clean_interval [4533,4565) 10.1.1.34:6805/337916 10.1.1.34:6806/337916 10.1.1.34:6807/337916 10.1.1.34:6808/337916 exists,up 752ffd2c-6cdc-4377-bbde-b89a5a46f449
osd.3 up in weight 1 up_from 4572 up_thru 4966 down_at 4570 last_clean_interval [4529,4569) 10.1.1.34:6801/338244 10.1.1.34:6802/338244 10.1.1.34:6803/338244 10.1.1.34:6804/338244 exists,up c59c5ef7-6f55-4fe5-9952-4f4c602b4c1a
osd.4 up in weight 1 up_from 4564 up_thru 4966 down_at 4562 last_clean_interval [4537,4561) 10.1.1.34:6809/337796 10.1.1.34:6810/337796 10.1.1.34:6811/337796 10.1.1.34:6812/337796 exists,up d264e02b-3f93-4125-a40b-8e1515158b3c
2.3 查看osd目录树
$ ceph osd tree
ID  CLASS WEIGHT    TYPE NAME                 STATUS REWEIGHT PRI-AFF
 -1       200.12276 root default
 -3        40.02455     host ceph-xx-osd00
  0   hdd   3.63860         osd.0                 up  1.00000 1.00000
  1   hdd   3.63860         osd.1                 up  1.00000 1.00000
  2   hdd   3.63860         osd.2                 up  1.00000 1.00000
  3   hdd   3.63860         osd.3                 up  1.00000 1.00000
  4   hdd   3.63860         osd.4                 up  1.00000 1.00000
2.4 下线osd
#让编号为0的osd down 掉,此时该 osd 不接受读写请求,但 osd 还是存活的
 
$ ceph osd down 0
marked down osd.0.
 
$ ceph osd tree
ID  CLASS WEIGHT    TYPE NAME                 STATUS REWEIGHT PRI-AFF
 -1       200.12276 root default
 -3        40.02455     host ceph-xx-osd00
  0   hdd   3.63860         osd.0               down  1.00000 1.00000
  1   hdd   3.63860         osd.1                 up  1.00000 1.00000
  2   hdd   3.63860         osd.2                 up  1.00000 1.00000
  3   hdd   3.63860         osd.3                 up  1.00000 1.00000
  4   hdd   3.63860         osd.4                 up  1.00000 1.00000
2.5 拉起osd
#让编号为0的osd up 掉,此时该 osd 接受读写请求
 
$ ceph osd up 0
marked up osd.0.
 
$ ceph osd tree
ID  CLASS WEIGHT    TYPE NAME                 STATUS REWEIGHT PRI-AFF
 -1       200.12276 root default
 -3        40.02455     host ceph-bench-osd00
  0   hdd   3.63860         osd.0                 up  1.00000 1.00000
  1   hdd   3.63860         osd.1                 up  1.00000 1.00000
  2   hdd   3.63860         osd.2                 up  1.00000 1.00000
  3   hdd   3.63860         osd.3                 up  1.00000 1.00000
  4   hdd   3.63860         osd.4                 up  1.00000 1.00000
2.6 osd逐出集群
#将一个 osd 逐出集群,即下线一个 osd,此时可以对该 osd 进行维护
$ ceph osd out 0
2.7 osd加入集群
#把一个 osd 加入集群,即上线一个 osd
$ ceph osd in 0
2.8 删除osd
#在集群中删除一个 osd,可能需要先 stop 该 osd,即 stop osd.0
$ ceph osd rm 0
2.9 从crush map中删除osd
#从 crush map 中删除一个 osd
$ ceph osd crush rm osd.0
2.10 删除host节点
#在集群中删除一个host节点
$ ceph osd crush rm node1
2.11 查看最大osd个数
#查看最大osd的个数，默认最大是4个osd节点
$ ceph osd getmaxosd
2.12 设置最大osd个数
#设置最大osd的个数，当扩大osd节点的时候必须扣大这个值
$ ceph osd setmaxosd 60
2.13 设置最大osd个数
#设置最大osd的个数，当扩大osd节点的时候必须扣大这个值
$ ceph osd setmaxosd 60
2.14 设置osd的crush权重
#ceph osd crush set {id} {weight} [{loc1} [{loc2} ...]]

$ ceph osd crush set 3 3.0 host=node4
#或者
$ ceph osd crush reweight osd.3 1.0
2.15 设置osd的权重
#ceph osd reweight {id} {weight}
$ ceph osd reweight 3 0.5
2.16 暂停osd
#暂停后整个集群不再接收数据
$ ceph osd pause
2.17 开启osd
#开启后再次接收数据
$ ceph osd unpause
2.18 查看osd参数配置
#查看某个osd的配置参数
$ ceph --admin-daemon /var/run/ceph/ceph-osd.2.asok config show | less
2.19 osd打摆子
#我们建议同时部署公网（前端）和集群网（后端），这样能更好地满足对象复制的容量需求。
#然而，如果集群网（后端）失败、或出现了明显的延时，同时公网（前端）却运行良好， OSD 现在不能很好地处理这种情况。
#这时 OSD 们会向监视器报告邻居 down 了、同时报告自己是 up 的，我们把这种情形称为打摆子（ flapping ）。
#如果有东西导致 OSD 打摆子（反复地被标记为 down ，然后又 up ），你可以强制监视器停止。 主要用于osd抖动的时候
 
$ ceph osd set noup      # prevent OSDs from getting marked up
$ ceph osd set nodown    # prevent OSDs from getting marked down
 
#这些标记记录在 osdmap 数据结构里：
ceph osd dump | grep flags
flags no-up,no-down
 
#下列命令可清除标记：
ceph osd unset noup
ceph osd unset nodown
2.20 osd动态修改参数
#修改所有osd参数,重启失效，需要写到配置文件中持久化
$ ceph tell osd.* injectargs "--rbd_default_format 2 "   
2.21 查看延迟情况
#主要解决单块磁盘问题，如果有问题应及时剔除osd。统计的是平均值
#fs_commit_latency 表示从接收请求到设置 commit 状态的时间间隔
#通过 fs_apply_latency 表示从接受请求到设置为 apply 状态的时间间隔
 
$ ceph osd perf
osd commit_latency(ms) apply_latency(ms)
 0 0 0
 1 37 37
 2 0 0
2.22 主亲和性
#Ceph 客户端读写数据时，总是连接 acting set 里的主 OSD （如 [2, 3, 4] 中， osd.2 是主的）。
#有时候某个 OSD 与其它的相比并不适合做主 OSD （比如其硬盘慢、或控制器慢），最大化硬件利用率时为防止性能瓶颈（特别是读操作），
#你可以调整 OSD 的主亲和性，这样 CRUSH 就尽量不把它用作 acting set 里的主 OSD 了。
 
#ceph osd primary-affinity <osd-id> <weight>   
 
$ ceph osd primary-affinity 2 1.0#主亲和性默认为 1 （就是说此 OSD 可作为主 OSD ）。此值合法范围为 0-1 ，其中 0 意为此 OSD 不能用作主的，#1 意为 OSD 可用作主的；此权重小于 1 时， CRUSH 选择主 OSD 时选中它的可能性低
2.23 提取crush图
#提取最新crush图
#ceph osd getcrushmap -o {compiled-crushmap-filename}
 
$ ceph osd getcrushmap -o /tmp/crush
 
#反编译crush图
# crushtool -d {compiled-crushmap-filename} -o {decompiled-crushmap-filename}
$ crushtool -d /tmp/crush -o /tmp/decompiled_crush
2.24 注入crush图
#编译crush图
#crushtool -c {decompiled-crush-map-filename} -o {compiled-crush-map-filename}
 
$ crushtool -c /tmp/decompiled_crush -o /tmp/crush_new
#注入crush图
# ceph osd setcrushmap -i {compiled-crushmap-filename}
$ ceph osd setcrushmap -i /tmp/crush_new
2.25 停止自动重均衡
#你得周期性地维护集群的子系统、或解决某个失败域的问题（如一机架）。如果你不想在停机维护 OSD 时让 CRUSH 自动重均衡，提前设置 noout
$ ceph osd set noout
2.26 取消停止自动均衡
#跟ceph osd set noout相反的操作
$ ceph osd unset noout
2.27 查看分区情况
ceph-disk list
