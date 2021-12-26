1.20  SmartMC典型配置举例
1.20.1  SmartMC基本组网配置举例
1. 组网需求
SmartMC网络的物理连接如图1-3所示，TM为管理设备，TC 1～TC 3为成员设备。现需要通过自动方式建立SmartMC网络，并通过SmartMC组升级所有成员设备的配置文件。

·            所有成员设备的设备类型都相同，均为S10500系列设备。

·            FTP服务器的IP地址为192.168.2.1，用户名为admin，密码为admin。

·            配置文件名称为startup.cfg。

2. 组网图
图1-3 SmartMC配置举例



 

3. 配置步骤
(1)       配置成员设备。

# 配置VLAN1接口。

<TC1> system-view

[TC1] interface vlan-interface 1

[TC1-Vlan-interface1] ip address 192.168.2.3 24

[TC1-Vlan-interface1] quit

# 开启成员设备的Telnet服务。

[TC1] telnet server enable

# 开启基于HTTP的NETCONF over SOAP功能。

[TC1] netconf soap http enable

# 全局开启LLDP功能。

[TC1] lldp global enable

# 配置本地用户admin，密码为admin、服务类型为Telnet、HTTP和HTTPS、RBAC角色为network-admin。

[TC1] local-user admin

[TC1-luser-manage-admin] password simple admin

[TC1-luser-manage-admin] service-type telnet http https

[TC1-luser-manage-admin] authorization-attribute user-role network-admin

[TC1-luser-manage-admin] quit

# 配置VTY用户线0～63的认证方式为scheme。

[TC1] line vty 0 63

[TC1-line-vty0-63] authentication-mode scheme

[TC1-line-vty0-63] quit

# 开启SmartMC功能，并配置设备角色为成员设备。

[TC1] smartmc tc enable

# 按此方法配置TC 2和TC 3。

(2)       配置管理设备

# 配置VLAN1接口。

<TM> system-view

[TM] interface vlan-interface 1

[TM-Vlan-interface1] ip address 192.168.2.2 24

[TM-Vlan-interface1] quit

# 开启Telnet服务。

[TM] telnet server enable

# 开启基于HTTP的NETCONF over SOAP功能。

[TM] netconf soap http enable

# 全局开启LLDP功能。

[TM] lldp global enable

# 配置本地用户admin，密码为admin、服务类型为Telnet、HTTP和HTTPS、RBAC角色为network-admin。

[TM] local-user admin

[TM-luser-manage-admin] password simple admin

[TM-luser-manage-admin] service-type telnet http https

[TM-luser-manage-admin] authorization-attribute user-role network-admin

[TM-luser-manage-admin] quit

# 配置VTY用户线0～63的认证方式为scheme。

[TM] line vty 0 63

[TM-line-vty0-63] authentication-mode scheme

[TM-line-vty0-63] quit

# 开启SmartMC功能并配置设备的角色为管理设备，用户名为admin，明文密码为admin。

[TM] smartmc tm username admin password simple admin enable

# 配置FTP服务器信息，指定FTP服务器的IP为192.168.2.1，用户名为admin，明文密码为admin。

[TM] smartmc ftp-server 192.168.2.1 username admin password simple admin

# 创建SmartMC组S1，并进入SmartMC组视图。

[TM] smartmc group S1

# 配置SmartMC组的匹配规则为按照设备类型匹配成员设备。

[TM-smartmc-group-S1] match device-type S10504

# 配置SmartMC组使用的配置文件为startup.cfg。

[TM-smartmc-group-S1] startup-configuration startup.cfg

[TM-smartmc-group-S1] quit

# 执行立即升级操作。

[TM] smartmc upgrade startup-configuration group s1 startup.cfg

(3)       验证配置

# SmartMC网络建立完成后，显示所有成员设备的简要信息。

[TM] display smartmc tc

TCID  DeviceType Sysname  IpAddress       MacAddress      Status   Version

1     S10504     S1       192.168.2.3     201c-e7c3-0300  Normal   R7568

2     S10504     S2       192.168.2.4     201c-e7c3-0301  Normal   R7568

3     S10504     S3       192.168.2.5     201c-e7c3-0302  Normal   R7568

# 显示成员设备 配置文件的升级状态。

<TM> display smartmc upgrade status

ID    IpAddress        MacAddress      Status      UpdateTime        UpdateFile

1     192.168.2.3      201c-e7c3-0300  Finished    Immediately       startup.cfg

2     192.168.2.4      201c-e7c3-0301  Finished    Immediately       startup.cfg

3     192.168.2.5      201c-e7c3-0302  Finished    Immediately       startup.cfg