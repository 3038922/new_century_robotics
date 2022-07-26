## linux ubuntu-22.04
## 升级到ubuntu 22.04 `sudo do-release-upgrade -d`
1. 一键部署
```
sudo bash -c "cat << EOF > /etc/apt/sources.list && apt update 
deb [arch=amd64] https://source.qzrobot.top/mirror/mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb [arch=amd64] https://source.qzrobot.top/mirror/mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb [arch=amd64] https://source.qzrobot.top/mirror/mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
deb [arch=amd64] https://source.qzrobot.top/mirror/mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb [arch=amd64] https://source.qzrobot.top/mirror/mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb [arch=amd64 trusted=yes] https://source.qzrobot.top/mirror/packages.microsoft.com/repos/code stable main
deb [arch=amd64 trusted=yes] https://source.qzrobot.top/mirror/dl.google.com/linux/chrome/deb stable main
EOF" && \
sudo apt update && sudo apt upgrade -y &&\
sudo apt install vim git curl cmake  clangd python3-pip ninja-build gcc llvm clang rar zsh vim  software-properties-common apt-transport-https wget openvpn  gcc-arm-none-eabi fonts-firacode google-chrome-stable code -y && \
sudo code --install-extension shan.code-settings-sync  && sudo apt autoremove -y && \
sudo pip install --upgrade pros-cli -i https://mirrors.aliyun.com/pypi/simple/ && \
sudo snap remove firefox && \
sh -c "$(curl -fsSL https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh)" 
```

2. 给vscode装插件
   - 然后按图点 `Download Public Gist` 输入`6c091a7b4ddcb213e72d430dac23422f` 回车.
   - ![avatar](../pic/sync_main.jpg)
3. 设置git名字和email
   - 输入你的名字: `git config --global user.name "xxx"` 比如 `"dog" "cat"`
   - 输入你的Email:`git config --global user.email "xxxx@qq.com"` 比如 `"1234@qq.com"`

4. 然后去完成免密登陆 
   - [GIT 免密登录](../git/git_id_ras_support.md)


## 其他
  - `oh-my-zsh` 更改主题 `vim .zshrc`修改主题,我用 `ZSH_THEME="agnoster"` 有很多插件和主题可以装,自己百度
  - 使其生效 `source .zshrc`
  - 这个属于个性化修改,不需要都一样,自己百度.vim也可以装很多插件变成IDE
  - TIM 微信等安装`sudo wget -O- https://deepin-wine.i-m.dev/setup.sh | sh`  
<!-- 2. Install SDL2 `sudo apt-get update && sudo apt-get install -y build-essential libsdl2-dev`
3. Install `vscode`
4. Install `prosv5` -->
