my lvim
===

## Requirements

```bash
# nvim 9.5.0
curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux64.tar.gz
export PATH="/opt/nvim-linux64/bin:$PATH"

sudo apt update
sudo apt install -y build-essential nodejs npm cargo ripgrep 
sudo apt install -y codespell fd-find
sudo apt install shellcheck

# 当前使用
node -v
v22.22.1
npm -v
9.2.0
cargo --version
cargo 1.93.1 (083ac5135 2025-12-15) (built from a source tarball)
```

## install

```bash
# 假如lunarvim官方仓库跑路
# LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/oldpower/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
lvim
```

## myconfig

```bash
cd ~/.config 
git clone https://github.com/oldpower/mylvim
mv lvim lvim_officialA
mv mylvim lvim
```
