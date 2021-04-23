# h3c交换机配置
## 常用查看命令
- 查看VLAN IP 简略 `dis ip int brief`   
- 查看端口信息 简略`dis int brief`
- 查看VLAN IP的配置：`dis cu int vlan`
- 查看所有 IP `dis arp`
- 查看接口下的IP地址+MAC地址 `dis arp int gi 1/0/1`
- 查看连接的计算机的名字 `dis ndp`
## 时间同步核心
```
interface Vlan-interface 1000
ntp-service broadcast-client
clock timezone beijing add 8
```
## 配置VLAN
- 查看VLAN `dis vlan 11` 
- 创建VLAN  `vlan 11`
- 把端口加入VLAN  `port gi 1/0/37 to gi 1/0/38`
### 配置交换端口 trunk 可以通过多个VLAN  access 本身只能通过一个vlan
- 批量改端口 `int ra g1/0/2  to  g1/0/12`
- 改PVID `port trunk pvid vlan XXXX`
- 配置电脑 AP之类的
``` 
    int gi 0/0/13 //进入端口 
    dis th //当查看当前端口视图下配置
    port link-type access
```
- 配置多VLAN 比如交换机什么的
```
    int gi 1/0/15
    dis th //当查看当前端口视图下配置
    port link-type trunk
    port trunk permit vlan 11 //只允许VLAN11 通过 怕环
```
### 创建VLAN 11 对应的接口地址
- 为了能转发访问的公共服务器报文，也就是此交换机上vlan 199对应的接口能转发访问DHCP服务器的报文，即Route Interface: configured 
- 给交换机创建vlan地址并配置上IP地址，默认所有的端口属于vlan1，这里给vlan 100 配置上IP地址。
- 注意:在创建VLAN接口之前，对应的VLAN必须已经存在。
```
    int vlan 11
    ip address 192.168.11.1 255.255.255.0                    //配置vlan 100 网关和掩码：注意要和dhcp网关配置一致，否则网络也不通
```
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