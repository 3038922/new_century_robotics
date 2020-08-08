## New Century Robotics (Public Welfare) Development Environment Tutorial (WIN10-64bit 1909)

[中文](./readme_cn.md)

1. Install visual studio2019 and configure c ++ development environment

- [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/vs_community__1548256886.1596784179.exe)
- Double-click to open the workload in the selection `Desktop development using C++`and `Linux development using C++` installation of him

![avatar](0.visualstudio.jpg)

2. Install cmake

- [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/cmake-3.18.1-win64-x64.msi)
- Double-click to open the installation. Note that this step chooses the second addition path as shown below.

![avatar](./pic/1.cmake.jpg)

3. Install vscode

- [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/VSCodeUserSetup-x64-1.47.3.exe)
- The selection steps are as follows:

![avatar](./pic/2.vscode.jpg)

4. Install git

- [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/Git-2.27.0-64-bit.exe)
- The selection steps are as follows:

![avatar](./pic/3.git-1.jpg)
![avatar](./pic/3.git-2.jpg)

- git global configuration user name `git config --global user.name "nameVal"`
- git global configuration email `git config --global user.email "eamil@qq.com"`

5. Install python

- [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/python-3.8.5-amd64.exe)
- Be sure to check the box `for all users`.

![avatar](./pic/4.python.jpg)

6. Automated installation and configuration of environment variables using scripts

- [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/build_en.ps1)
- I save this script on my desktop,Click the file in the upper left corner.Click to `open windows PowerShell as administrator`
- input `.\build_en.ps1`
  If unable to execute, please enter `Set-ExecutionPolicy Unrestricted` Set execution policy to Unrestricted

![avatar](./pic/7.环境变量-1.jpg)

- OK after adding. Restart the computer.

7. vscdoe plugin download and setup

- turn on vscode
- Choose add-ons store search `sync` selection `setting sync` and install

![avatar](./pic/8.vscode-1.jpg)

- Press `clrl + shift + p` will pop up above the console input `sync download setting`

![avatar](./pic/8.vscode-2.jpg)

- Under point `download public gist` input `6c091a7b4ddcb213e72d430dac23422f`Enter. The plugin will be downloaded automatically. (If useless before the election `SYNC Reset extended settings` and then `download public gist`）

![avatar](./pic/8.vscode-3.jpg)

## 关于中文报错问题

- `pros-cli3 3.1.4` 有一个中文支持的 BUG 错误返回如下:

```sh
Exception in thread Thread-1:
Traceback (most recent call last):
File "c:\users\aresp\appdata\local\programs\python\python37\lib\threading.py", line 917, in _bootstrap_inner
self.run()
File "c:\users\aresp\appdata\local\programs\python\python37\lib\site-packages\pros\common\ui\__init__.py", line 180, in run
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
