# Linux 常用命令索引

- 挂载 smb 共享目录
  1. 打开配置文件 `vim /etc/fstab`
  2. 输入 `//IP地址/XXX /要挂载的地方/XXX cifs username=root,password=xxxx 0 0`
  3. 挂载配置文件里的全部目录 `mount -a`
