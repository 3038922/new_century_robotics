## linux ubuntu-22.04
## 升级到ubuntu 22.04 `sudo do-release-upgrade -d`
1. 一键部署
```
sudo apt update && \
sudo http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true update && \
sudo http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true upgrade --fix-missing -y &&\
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y &&\
sudo apt update  &&\
sudo http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true update && \
sudo http_proxy=http://10.255.0.194:3142 apt-get -o pkgProblemResolver=true -o Acquire::http=true install vim git curl cmake  clangd python3-pip ninja-build gcc llvm clang rar zsh vim  software-properties-common apt-transport-https wget openvpn  gcc-arm-none-eabi -y && \
wget https://qzrobot.top/index.php/s/k6oYH3gN7pkQ89e/download/google-chrome-stable_current_amd64.deb && sudo apt install ./google-chrome-stable_current_amd64.deb -y && \
wget https://qzrobot.top/index.php/s/e39TKeQKcWRBBqG/download/code.deb && sudo apt install ./code.deb && \
code --install-extension shan.code-settings-sync -y && \
sudo pip install --upgrade pros-cli -i https://pypi.tuna.tsinghua.edu.cn/simple
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
  - 装个 `oh-my-zsh` 美化下,可选 
  -  修改默认终端为zsh `chsh -s /bin/zsh` 然后输入 `zsh`进入zsh 
  - 安装oh my zsh(国内源) `sh -c "$(curl -fsSL https://gitee.com/pocmon/ohmyzsh/raw/master/tools/install.sh)"`
  - `vim .zshrc`修改主题,我用 `ZSH_THEME="agnoster"` 有很多插件和主题可以装,自己百度
  - 使其生效 `source .zshrc`

  - 这个属于个性化修改,不需要都一样,自己百度.vim也可以装很多插件变成IDE
  - TIM 微信等安装`sudo wget -O- https://deepin-wine.i-m.dev/setup.sh | sh`  
<!-- 2. Install SDL2 `sudo apt-get update && sudo apt-get install -y build-essential libsdl2-dev`
3. Install `vscode`
4. Install `prosv5` -->
