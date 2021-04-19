# h3c交换机配置
## 常用查看命令
- 可使用如下命令查看交换机配置了哪些IP地址 `dis ip int brief`   `dis int brief`
- 可使用如下命令查看VLAN IP的配置：`dis cu int vlan`
- 查看所有 IP `dis arp`
- 查看接口下的IP地址+MAC地址 `dis arp int gi 1/0/1`
## 时间同步核心
```
interface Vlan-interface 1000
ntp-service broadcast-client
```
## 配置VLAN
- 查看VLAN `dis vlan 111` 
- 创建VLAN  `vlan 111`
- 配置VLANIP ``
### 配置交换端口 trunk 可以通过多个VLAN  access 本身只能通过一个vlan
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
    interface Vlan-interface 11
    ip address 192.168.1.1 255.255.255.0                    //配置vlan 100 网关和掩码：注意要和dhcp网关配置一致，否则网络也不通
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


### 关闭无线 DHCP 
`undo dhcp server ip-pool wuxian`
