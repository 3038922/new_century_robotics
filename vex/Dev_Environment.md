# 开发环境安装及配置

1. 安装 Visual Studio2019 并配置 C ++开发环境

- [下载](https://qzrobot.top/index.php/s/ckFtR2YwynSrSiz/download)
- 安装的时候选择`使用C++的桌面开发`和 `使用c++的Linux开发`

![avatar](/pic/0.visualstudio.jpg)

2. 使用脚本自动化安装和配置环境变量

- [下载](https://qzrobot.top/index.php/s/wzNnD2JW59ocTpH/download)

- 我将此脚本另存在桌面,点击左上角文件,点击`以管理员身份打开 windows powershell`
- 输入 `Set-ExecutionPolicy Unrestricted` 将执行策略设置为 Unrestricted
- 再输入 `./build_cn.ps1`

- 如果无法执行 
  如果还不行 试试输入`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`   再重复之前的操作
- 百度这两个命令会导致系统出错 不要使用
  `Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine` 本地计算机的所有用户删除执行策略
  `Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser`删除 作用域 的执行策略 

3. 安装 cmake

- [下载](https://qzrobot.top/index.php/s/9PpsXD9yxAd85sd/download)
- 双击打开安装。请注意，此步骤选择第二条添加路径，如下所示。

![avatar](/pic/1.cmake.jpg)

4. 安装 vscode

- [下载](https://qzrobot.top/index.php/s/ySZieKANW5GedZM/download)
- 选择步骤如下：

![avatar](/pic/2.vscode.jpg)

5. 安装 git

- [下载](https://qzrobot.top/index.php/s/afkWMfGGrZxZcaR/download)
- 选择步骤如下：

![avatar](/pic/3.git-1.jpg)
![avatar](/pic/3.git-2.jpg)

- git 全局配置用户名 `git config --global user.name "nameVal"`
- git 全局配置邮箱 `git config --global user.email "eamil@qq.com"`

6. 安装 python

- [下载](https://qzrobot.top/index.php/s/THniMLtpTa4j3j5/download)
- 确保选中 `Add Python 3.x to Path`.
- 然后选 `Install Now` 默认安装到 C 盘即可

![avatar](/pic/4.python.jpg)

![avatar](/pic/7.环境变量-1.jpg)

- 执行完毕后,重新启动计算机。

7. vscode 插件下载和设置

- 打开 vscode

- 按下 `ctrl + shift + p` 输入 `sync download setting`

![avatar](/pic/8.vscode-2.jpg)

- 点击 `download public gist` 输入 `6c091a7b4ddcb213e72d430dac23422f` 回车.

![avatar](/pic/8.vscode-3.jpg)

- 如果没有弹出上面的页面,输入 `SYNC Reset extended settings` 然后点击 `download public gist`

8. 字体安装

- [下载](https://qzrobot.top/index.php/s/b8DMCSHAEdD964J)
- 双击安装

## linux 下安装开发环境

- [linux install](./Dev_Environment_linux.md)
