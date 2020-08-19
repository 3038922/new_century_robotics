# NV 显卡驱动安装

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

- 安装驱动 `apt-get install nvidia-390`
- 检查驱动是否安装成功`nvidia-smi`
