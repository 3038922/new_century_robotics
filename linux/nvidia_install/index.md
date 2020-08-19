# NV 显卡驱动安装

## 卸载所有 nv 相关

`apt-get --purge remove nvidia-*`

## 禁用 nouveau

- 这步操作是为了禁用系统自带的显卡驱动：
  `vim /etc/modprobe.d/blacklist.conf`
  - 最后添加
  ```sh
  blacklist nouveau
  options nouveau modeset=0
  ```
  `update-initramfs -u`
  - 重启，执行，如果没有输出说明禁用成功了，否则解决这一步的问题： `lsmod | grep nouveau`

## Nvidia 驱动安装

- 安装驱动 `apt-get install nvidia-390` 千万不要安装 `nvidia x-config`
- 检查驱动是否安装成功`nvidia-smi`

## 禁用 nvidia 自带的桌面

- 必须禁用 否则服务器重启会进入桌面模式 断网 `service gdm3 stop`

## 安装 cuda

- ubuntu20.04 GCC 版本过高 其实没法编译
- --override 表示覆盖之前的安装 `sh sh ./cuda_9.1.85_387.26_linux.run --override`
