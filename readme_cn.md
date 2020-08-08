## 新世纪机器人（公益）开发环境教程（WIN10-64bit 1909）

[English](./readme.md)

1. 安装 Visual Studio2019 并配置 C ++开发环境

- [下载](https://qzrobot.top/index.php/s/ckFtR2YwynSrSiz/download)
- Double-click to open the workload in the selection `Desktop development using C++`and `Linux development using C++` installation of him

2. 安装 cmake

- [下载](https://qzrobot.top/index.php/s/9PpsXD9yxAd85sd/download)
- 双击打开安装。请注意，此步骤选择第二条添加路径，如下所示。

![avatar](./pic/1.cmake.jpg)

3. 安装 vscode

- [下载](https://qzrobot.top/index.php/s/ySZieKANW5GedZM/download)
- 选择步骤如下：

![avatar](./pic/2.vscode.jpg)

4. 安装 git

- [下载](https://qzrobot.top/index.php/s/R5XNM2HLjLkRp6D/download)
- 选择步骤如下：

![avatar](./pic/3.git-1.jpg)
![avatar](./pic/3.git-2.jpg)

5. 安装 python

- [下载](https://qzrobot.top/index.php/s/THniMLtpTa4j3j5/download)
- 确保选中 `for all users`.

![avatar](./pic/4.python.jpg)

6. 使用脚本自动化安装和配置环境变量

- [另存为](./script/build_cn.ps1)

- 我将此脚本另存在桌面,点击左上角文件,点击`以管理员身份打开 windows powershell`
- 再输入 `./build_cn.ps1`
  如果无法执行 请输入 `Set-ExecutionPolicy Unrestricted` 将执行策略设置为 Unrestricted
  ![avatar](./pic/7.环境变量-1.jpg)
- 执行完毕后,重新启动计算机。

7. vscdoe 插件下载和设置

- 打开 vscode
- 选择加载项商店搜索`sync`选择`setting sync`并安装

![avatar](./pic/8.vscode-1.jpg)

- 按下 `clrl + shift + p` 输入 `sync download setting`

![avatar](./pic/8.vscode-2.jpg)

- 点击 `download public gist` 输入 `6c091a7b4ddcb213e72d430dac23422f` 回车.

  ![avatar](./pic/8.vscode-3.jpg)

- 如果没有弹出上面的页面,输入 `SYNC Reset extended settings` 然后点击 `download public gist`

## 关于中文报错问题

- `pros-cli3 3.1.4` 有一个中文支持的 BUG 错误返回如下:

```sh
Exception in thread Thread-1:
Traceback (most recent call last):
File "c:\users\aresp\appdata\local\programs\python\python38\lib\threading.py", line 917, in _bootstrap_inner
self.run()
File "c:\users\aresp\appdata\local\programs\python\python38\lib\site-packages\pros\common\ui\__init__.py", line 180, in run
for line in iter(self.pipeReader.readline, ''):
UnicodeDecodeError: 'gbk' codec can't decode byte 0x80 in position 10: illegal multibyte sequence
```

- 打开`c:\users\你的用户名\appdata\local\programs\python\python38\lib\site-packages\pros\common\ui\__init__.py`
- 修改 `kwargs['file'] = open(os.devnull, 'w')` 为 `kwargs['file'] = open(os.devnull, 'w', encoding='UTF-8')`
- 修改 `self.pipeReader = os.fdopen(self.fdRead)` 为 `self.pipeReader = os.fdopen(self.fdRead, encoding='UTF-8')`

## linux ubuntu-1803

1. Install common software:`sudo apt install cmake python3 ninja-build gcc-8 llvm-9 clang-9`
2. Install SDL2 `sudo apt-get update && sudo apt-get install -y build-essential libsdl2-dev`
3. Install `vscode`
4. Install `prosv5`
