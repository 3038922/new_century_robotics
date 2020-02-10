## New Century Robotics (Public Welfare) Development Environment Tutorial (WIN10-64bit 1909)
1. Install visual studio2019 and configure c ++ development environment
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/vs_community__1171082560.1567069112.exe)
    - Double-click to open the workload in the selection `Desktop development using C++`and `Linux development using C++` installation of him

2. Install cmake
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/cmake-3.16.2-win64-x64.msi)
    - Double-click to open the installation. Note that this step chooses the second addition path as shown below.

![avatar](./pic/1.cmake.jpg)

3. Install vscode
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/VSCodeUserSetup-x64-1.41.1.exe)
    - The selection steps are as follows:

![avatar](./pic/2.vscode.jpg)

4. Install git
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/Git-2.24.1.2-64-bit.exe)
    - The selection steps are as follows:

![avatar](./pic/3.git-1.jpg)
![avatar](./pic/3.git-2.jpg)

5. Install python
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/python-3.8.1-amd64.exe)
    - Be sure to check the box `for all users`.

![avatar](./pic/4.python.jpg)

6. Extract ccls+llvm+ninja.zip
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/ninja+ccls+llvm.zip)
    - Download `ninja + ccls + llvm.zip` and extract it to the root directory of `c:` (let the decompression software obtain the administrator rights to extract the root directory of drive C)

![avatar](./pic/5.ccls+llvm+ninja-1.jpg)
![avatar](./pic/5.ccls+llvm+ninja-2.jpg)

7. Extract pros.zip
    - [Download](https://github.com/3038922/new_century_robotics/releases/download/v1.0/PROS.zip)
    - Download `pros.zip` and unzip to `C:\Program Files`

8. Setting environment variables
    - `右键`->`此电脑`->`属性`->`高级系统设置`->`环境变量`->`系统变量`->`新建`
    - Variable name: `PROS_TOOLCHAIN` Variable value: `C:\Program Files\PROS\toolchain\usr` 

![avatar](./pic/7.环境变量-1.jpg)

- Then double click `Path`

![avatar](./pic/7.环境变量-2.jpg)

- point `新建`
- Line by line add it

```
    c:\ninja
    c:\llvm\Release\bin
    c:\ccls\Release
    c:\Program Files\PROS\toolchain\usr\bin
```

![avatar](./pic/7.环境变量-3.jpg)

- OK after adding. Restart the computer.
- Right click on the blank space on the desktop-> Git Bash Here
- Copy this sentence pip install `https://github.com/purduesigbots/pros-cli/releases/download/3.1.4/pros_cli_v5-3.1.4-py3-none-any.whl`
- Finally, we need to verify that our installation was successful.
- Enter one by one
```
    cmake --version
    git --version
    python --version
    ninja --version
    clang --version
    ccls --version
    arm-none-eabi-gcc --version
    prosv5 --version
```

![avatar](./pic/7.环境变量-4.jpg)

9. vscdoe plugin download and setup
    - turn on vscode
    - Choose add-ons store search `sync` selection `setting sync` and install

![avatar](./pic/8.vscode-1.jpg)

- Press  `clrl + shift + p` will pop up above the console input `sync download setting`

![avatar](./pic/8.vscode-2.jpg)

- Under point `download public gist` input `16c091a7b4ddcb213e72d430dac23422f`Enter. The plugin will be downloaded automatically. (If useless before the election `SYNC 重置扩展设置` and then `download public gist`）

![avatar](./pic/8.vscode-3.jpg)

## linux ubuntu-1803

1. Install common software:`sudo apt install cmake python3 ninja-build gcc-8 llvm-9 clang-9`
2. Install SDL2 `sudo apt-get update && sudo apt-get install -y build-essential libsdl2-dev`
3. Install `vscode`
4. Install `prosv5`