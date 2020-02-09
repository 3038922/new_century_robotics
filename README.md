## 新世纪机器人社(公益)开发环境教程 (WIN10-64bit 1909)
1. 安装visual studio2019 并配置c++开发环境
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/vs_community__1171082560.1567069112.exe)
    - 双击打开 工作负载里选择 `使用c++的桌面开发` 和 `使用c++的linux开发` 安装他.

2. 安装cmake
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/cmake-3.16.2-win64-x64.msi)
    - 双击打开 安装.需要注意的是 这一步 选 第二个 添加路径 如下图.
![avatar](./pic/1.cmake.jpg)

3. 安装vscode
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/VSCodeUserSetup-x64-1.41.1.exe)
    - 这样勾选 如下图:

![avatar](./pic/2.vscode.jpg)

4. 安装git
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/Git-2.24.1.2-64-bit.exe)
    - 选择步骤如下图:

![avatar](./pic/3.git-1.jpg)
![avatar](./pic/3.git-2.jpg)

5. 安装python
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/python-3.8.1-amd64.exe)
    - 千万注意勾选 `for all users`.
![avatar](./pic/4.python.jpg)

6. 解压缩ccls+llvm+ninja.zip
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/ninja+ccls+llvm.zip)
    - 下载 ninja+ccls+llvm.zip 并解压缩到C盘根目录 `c:\` (让解压缩软件取得管理员权限可以直接解压到C盘根目录)
![avatar](./pic/5.ccls+llvm+ninja-1.jpg)
![avatar](./pic/5.ccls+llvm+ninja-2.jpg)

7. 解压缩pros.zip
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/PROS.zip)
    - 下载 `pros.zip`,并解压到 `C:\Program Files`

8. 设置环境变量
    - `右键`->`此电脑`->`属性`->`高级系统设置`->`环境变量`->`系统变量` 那里的 `新建`
    - 变量名: `PROS_TOOLCHAIN` 变量值: `C:\Program Files\PROS\toolchain\usr` 确定
![avatar](./pic/7.环境变量-1.jpg)

    - 然后双击 `Path`

![avatar](./pic/7.环境变量-2.jpg)

    - 点 `新建`
    - 一行一行的加
```
    c:\ninja
    c:\llvm\Release\bin
    c:\ccls\Release
    c:\Program Files\PROS\toolchain\usr\bin
```
![avatar](./pic/7.环境变量-3.jpg)
    - 添加好了以后确定. 重启电脑.
    - 桌面空白处右键->Git Bash Here
    - 复制这句话 `pip install https://github.com/purduesigbots/pros-cli/releases/download/3.1.4/pros_cli_v5-3.1.4-py3-none-any.whl` 回车
    - 最后我们还要验证我们是否安装成功.
    - 依次输入
```
    cmake --version
    git --version
    python --version
    ninja --version
    clang --version
    ccls --version
    arm-none-eabi-gcc –version
    prosv5 --version
```
![avatar](./pic/7.环境变量-4.jpg)

9. vscdoe插件下载和设置
    - 打开`vscode`
    - 选 插件商店 搜 `sync` 选择 `setting sync` 并 `install`
![avatar](./pic/8.vscode-1.jpg)
    - 按 `clrl + shift + p` 会弹出控制台 上面输入 `sync download setting`
![avatar](./pic/8.vscode-2.jpg)
    - 点下 `download public gist` 输入 `16c091a7b4ddcb213e72d430dac23422f` 回车。系统会自动下载插件。（如果没用 先选 `SYNC 重置扩展设置` 再 `download public gist`）
![avatar](./pic/8.vscode-3.jpg)