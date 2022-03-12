# pros linux 开发环境
## 安装ARM-NONE-EABI编译器
1. [下载编译器](https://qzrobot.top/index.php/s/jEsRfpjZRQP37HW/download/gcc-arm-none-eabi.tar.bz2)
2. 进入下载文件夹,点 解压缩(提取)到此处 
3. 进入文件夹 找到 `bin`文件夹,打开终端,输入`pwd`.
- 会出现类似 `/home/xxxxxxx/下载/gcc-arm-none-eabi/gcc-arm-none-eabi-10.3-2021.10/bin`这类的路径
4. 打开主目录,并打开隐藏文件,找到.bashrc 在最后面加入一行  `export PATH=$PATH:/home/xxxxxxx/下载/gcc-arm-none-eabi/gcc-arm-none-eabi-10.3-2021.10/bin` 
5. 重启.
6. 测试 输入 `arm-none-eabi-gcc -v`看看有没用.