#!/usr/bin/env bash

set -e

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt install \
bat \
gh \
git \
git-delta \
hx \
podman-toolbox \
man-db \
ripgrep \
wl-clipboard \
-y

mkdir -p ~/.local/bin/ ~/.config/containers/ ~/.config/helix/ ~/Documents/github.com/ccouzens/

cat > ~/.local/bin/laptop-update <<< '#!/usr/bin/env bash

set -e
sudo apt-get update
sudo apt-get dist-upgrade -y
toolbox run dnf upgrade --assumeyes'

chmod +x ~/.local/bin/laptop-update

cat > ~/.config/containers/toolbox.conf <<< '
[general]
distro = "fedora"
release = "45"
'

cat > ~/.config/helix/config.toml <<< '
[editor.soft-wrap]
enable = true

[editor]
auto-pairs = false 
true-color = true

[editor.lsp]
display-inlay-hints = false

[editor.file-picker]
hidden = false
'

toolbox create
toolbox run sudo dnf install gh git git-delta ripgrep helix wl-clipboard --assumeyes

git config --global user.name "Chris Couzens"
git config --global user.email "ccouzens@gmail.com"
git config --global core.editor hx
git config --global init.defaultBranch main

curl -fsSL https://mise.run/bash | sh

gh auth login -p https -h github.com -w
gh config set editor hx

cat > ~/.bashrc <<< '# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

eval "$(/home/droid/.local/bin/mise activate bash)" # added by https://mise.run/bash
'
