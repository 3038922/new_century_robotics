## s7003x
1. 进入相应 int vlan 后 `dhcp relay server-address 10.255.0.1`
2. 配置DHCP中继支持Option 82功能 `dhcp relay information enable`
3. 开启DHCP中继支持smart-relay功能。`dhcp smart-relay enable`
4. 配置DHCP中继在DHCP请求报文中添加Option 60选项
```
Option 60字段记录的是客户端的厂商标识信息。当DHCP服务器收到带有Option 60选项的DHCP请求报文后，可以根据Option 60选项匹配正确的用户类，再从该用户类对应的地址空间选择地址分配给DHCP客户端，从而确保不同Option 60选项的DHCP客户端可以获取到不同范围的IP地址。
在DHCP中继上开启本功能，当DHCP中继收到DHCP请求报文后，先检查报文中是否存在Option 60选项。如果报文中不存在Option 60选项，则DHCP中继使用本命令指定的Option 60选项内容填充报文，再将报文转发给DHCP服务器；如果报文中存在Option 60选项，则DHCP中继不会处理该报文，将报文直接转发给DHCP服务器。
配置步骤
dhcp relay insert option60 option-text
```