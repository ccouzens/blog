sudo apt install \
adb \
binaryen \
bubblewrap \
build-essential \
clang \
clang-tools \
gcc \
git \
hx \
make \
man-db \
nodejs \
node-corepack \
podman \
ripgrep \
rustup \
wabt \
wl-clipboard

rustup-init -y
rustup default stable
rustup component add rust-analyzer

# set password
sudo passwd chris
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# unset password
sudo passwd chris --delete

brew install node pnpm

# other stuff from silverblue setup

# add `true-color = true` to `editor` section in helix config
