# h3c交换机配置
## 配置TELNET 登录
- 配置虚拟终端接口认证方式`user-interface vty 0 4` 
- 设置认证方式 `authentication-mode scheme` 
- 设置本地认证用户名 `local-user 用户名` 
- `password simple 密码`
- `service-type telnet`
- `telnet server enable`
- 开启网页登录 `ip http enable`
## 配置时间
改时区 `clock timezone BJ add 08:00:00`
- `ntp-service enable`
- 设置时间服务器 `ntp-service unicast-server 10.255.0.1`
## 常用查看命令
- 查看VLAN IP 简略 `dis ip int brief`   
- 查看VLAN IP的配置：`dis cu int vlan`
- 查看所有 IP `dis arp`
- 查看接口下的IP地址+MAC地址 `dis arp int gi 1/0/1`

## 配置VLAN
- 查看VLAN `dis vlan 11` 
- 创建VLAN  `vlan 11`
- 把端口加入VLAN  `port gi 1/0/37 to gi 1/0/38`
### 配置交换端口 trunk 可以通过多个VLAN  access 本身只能通过一个vlan
- 批量改端口 `int ra g1/0/2  to  g1/0/12`
- 批量改端口 `port-group manual ap` `group-member g 4/0/11 to g 4/0/24` `port group member ap`
- 改PVID `port trunk pvid vlan XXXX`
## 链路聚合
二层聚合：

一、静态聚合

1. `int Bridge-Aggregation xxx`

[SW-Ethernet1/0/1]port link-aggregation group 1

[SW-Ethernet1/0/2]port link-aggregation group 1

[SW-Bridge-Aggregation1]port link-type trunk

[SW-Bridge-Aggregation1]port trunk permit vlan all 必须先加入端口再起Trunk，要不然会出错

二、动态聚合

int Bridge-Aggaregation 1

[SW-Bridge-Aggregation1]link-aggregation mode dynamic

[SW-Ethernet1/0/1]port link-aggregation group 1

[SW-Ethernet1/0/2]port link-aggregation group 1

[SW-Bridge-Aggregation1]port link-type trunk

[SW-Bridge-Aggregation1]port trunk permit vlan all

查看命令：

display link-aggregation summary

[S1]display link-aggregation verbose

负载分担：

[S1]link-aggregation load-sharing mode destination-mac 两端都配置（貌似接口也可以配置）

三层聚合：

[R2]int Route-Aggregation 1

[R2-Route-Aggregation1]ip add 12.1.1.2 24

[R2]int g0/0

[R2-GigabitEthernet0/0]port link-aggregation group 1

[R2-GigabitEthernet0/0]int g0/1

[R2-GigabitEthernet0/1]port link-aggregation group 1

负载分担：

[R1]link-aggregation global load-sharing mode source-ip destination-ip基于源IP，目的IP
## DHCP
- 开打DHCP `dhcp enable`

### 新增 无线DHCP
```
dhcp server ip-pool wuxian
    network 10.195.104.0 mask 255.255.254.0
    gateway-list 10.195.104.1
    dns-list 202.96.113.34 202.96.113.35
```
- 他DHCP 255.255.255.252 是向前的 所以写的时候写 192.168.13.0
```
dhcp server ip-pool ikuai
    network 192.168.11.0 mask 255.255.255.0
    gateway-list 192.168.11.1
    dns-list 223.5.5.5 202.96.113.34
```

### 关闭无线 DHCP 
`undo dhcp server ip-pool wuxian`
### 配置SNMP3
- 开启SNMP版本 `snmp-agent sys-info version v2c`
- 禁用V3版本 `undo snmp-agent sys-info version v3`
- 新增组织 `snmp-agent community write newcenturyschool`
- 可选
- 允许向网管工作站（NMS）1.1.1.2/24发送Trap报文，使用的团体名为public。
`snmp-agent trap enable`
`target-host trap address udp-domain 1.1.1.2 params securityname newceturyschool v1`
### IGMP
- 多播是 4类地址 224-239 服务器是目的地址

### HUAWEI S5720 LACP 聚合协议
`load-balance ? ` 查看负载均衡模式
`disp eth-trunk 31` 查看聚合状态
`dis load-balance mode` 查看当前聚合策略


### H3C 查看聚合组
`display link-aggregation verbose Bridge-Aggregation`
`link-aggregation load-sharing mode destination-mac` 设置聚合策略